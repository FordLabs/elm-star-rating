{-
   Copyright 2018 Ford Motor Company

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
-}


module Rating exposing
    ( initialState
    , initialCustomState
    , classView, styleView
    , update
    , get
    , set
    , State, Msg
    )

{-| A simple five star rating component. Uses unicode star characters ★ & ☆ (U+2605 & U+2606) by default. Allows for custom Html elements to be used.


# Init

@docs initialState
@docs initialCustomState


# View

@docs classView, styleView


# Update

@docs update


# Helpers

@docs get
@docs set


# Types

@docs State, Msg

-}

import Html exposing (Attribute, Html, div, input, label, span, text)
import Html.Attributes exposing (attribute, name, style, type_)
import Html.Events exposing (onBlur, onClick, onFocus, onMouseEnter, onMouseLeave)
import Internal.Helpers exposing (addOutlineIfInputFocused, chooseCharacter, generateRatingList, updateRenderedRating)
import Internal.Model exposing (Model)


{-| Opaque type obscuring rating model.
-}
type State
    = RatingType (Model Msg)


{-| Opaque type obscuring rating messages.
-}
type Msg
    = UpdateRating Int
    | UpdateRenderedRatingOnEnter Int
    | UpdateRenderedRatingOnLeave
    | InputFocused (Maybe Int)


{-| Render the component. Accepts a name for the rating component, a list of css class names and a Rating.State.
The radioGroupName is used to populate the name parameter on the radio buttons, so use a unique name for each star rating on the same page.
If using initialState to initialize this component, it uses text characters to display the stars, so use css accordingly.

    Rating.classView "starRating" [ "cssClass1", "cssClass2" ] ratingState

-}
classView : String -> List String -> State -> Html Msg
classView radioGroupName classes ratingModel =
    let
        model =
            case ratingModel of
                RatingType state ->
                    state

        ratingList =
            generateRatingList
                model.renderedRating

        modelStar =
            star radioGroupName model
    in
    div (classes |> List.map (\class -> Html.Attributes.class class))
        (List.indexedMap modelStar ratingList)


{-| Render the component. Accepts a name for the rating component, a list of style tuples and a Rating.State.
The radioGroupName is used to populate the name parameter on the radio buttons, so use a unique name for each star rating on the same page.
If using initialState to initialize this component, it uses text characters to display the stars, so use css accordingly.

    Rating.styleView "starRating" [ ( "color", "red" ) ] ratingState

-}
styleView : String -> List ( String, String ) -> State -> Html Msg
styleView radioGroupName styles ratingModel =
    let
        model =
            case ratingModel of
                RatingType state ->
                    state

        ratingList =
            generateRatingList
                model.renderedRating

        modelStar =
            star radioGroupName model
    in
    div (styles |> List.map (\( style, value ) -> Html.Attributes.style style value))
        (List.indexedMap modelStar ratingList)


star : String -> Model Msg -> Int -> Bool -> Html Msg
star radioGroupName model index filled =
    let
        updatedIndex =
            index + 1
    in
    label []
        [ input
            [ onClick (UpdateRating updatedIndex)
            , onFocus (InputFocused (Just updatedIndex))
            , onBlur (InputFocused Nothing)
            , type_ "radio"
            , name radioGroupName
            , style "appearance" "none"
            , style "position" "absolute"
            , style "outline" "none"
            ]
            []
        , span
            ([ onClick (UpdateRating updatedIndex)
             , onBlur (InputFocused Nothing)
             , onMouseEnter (UpdateRenderedRatingOnEnter updatedIndex)
             , onMouseLeave UpdateRenderedRatingOnLeave
             , style "cursor" "pointer"
             , attribute "aria-label" ("rate " ++ String.fromInt updatedIndex ++ " stars")
             ]
                ++ addOutlineIfInputFocused model.focusedStar updatedIndex
            )
            [ chooseCharacter filled model ]
        ]


{-| Update the state of the rating component.

    RatingMsg msg ->
        ( { model | ratingState = (Rating.update msg model.ratingState) }, Cmd.none )

-}
update : Msg -> State -> State
update msg model =
    let
        ratingModel =
            case model of
                RatingType state ->
                    state
    in
    case msg of
        UpdateRating rating ->
            RatingType { ratingModel | rating = rating, renderedRating = rating, focusedStar = Just rating }

        UpdateRenderedRatingOnEnter enteredRating ->
            enteredRating |> updateRenderedRatingOnMouseEnter model

        UpdateRenderedRatingOnLeave ->
            RatingType { ratingModel | renderedRating = ratingModel.rating }

        InputFocused focusedIndex ->
            RatingType { ratingModel | focusedStar = focusedIndex }


updateRenderedRatingOnMouseEnter : State -> Int -> State
updateRenderedRatingOnMouseEnter ratingModel enteredRating =
    let
        model =
            case ratingModel of
                RatingType state ->
                    state
    in
    RatingType (updateRenderedRating model enteredRating)


{-| Get the current rating.

    Rating.get ratingState

-}
get : State -> Int
get state =
    case state of
        RatingType model ->
            model.rating


{-| Set the rating. Keeps values between 0 and 5.

    Rating.set 4 ratingState

-}
set : Int -> State -> State
set rating state =
    case state of
        RatingType model ->
            RatingType { model | rating = clamp 0 5 rating, renderedRating = clamp 0 5 rating }


{-| Initial rating state. Sets rating to zero. Uses "★" and "☆".
-}
initialState : State
initialState =
    RatingType (Model 0 0 Nothing (text "★") (text "☆"))


{-| Initial rating state. Sets rating to zero. Uses html passed in by user.
-}
initialCustomState : Html Msg -> Html Msg -> State
initialCustomState filledStar emptyStar =
    RatingType (Model 0 0 Nothing filledStar emptyStar)
