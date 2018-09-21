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
    ( classView, styleView
    , update
    , get
    , State, Msg
    , initialState
    )

{-| A simple five star rating component. Uses unicode star characters (U+2605 & U+2606).


# Init

@docs initialRatingModel


# View

@docs classView, styleView


# Update

@docs update


# Helpers

@docs get


# Types

@docs State, Msg

-}

import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Internal.Helpers exposing (chooseCharacter, generateRatingList, ratingToBoolean, updateRenderedRating)
import Internal.Model exposing (Model)


{-| Opaque type obscuring rating model
-}
type State
    = RatingType Model


{-| Opaque type obscuring rating messages
-}
type Msg
    = UpdateRating Int
    | UpdateRenderedRatingOnEnter Int
    | UpdateRenderedRatingOnLeave


{-| Render the component. Accepts a list of css class names and a Rating.State.
Note that the component uses text characters to display the stars, so use css accordingly.

    Rating.view [ "cssClass1", "cssClass2" ] ratingState

-}
classView : List String -> State -> Html Msg
classView classes ratingModel =
    let
        renderedRating =
            case ratingModel of
                RatingType state ->
                    state.renderedRating
    in
    div (classes |> List.map (\class -> Html.Attributes.class class))
        (generateRatingList
            renderedRating
            |> List.indexedMap star
        )


{-| Render the component. Accepts a list of style tuples and a Rating.State.
Note that the component uses text characters to display the stars, so use css accordingly.

    Rating.view [ ( "color", "red" ) ] ratingState

-}
styleView : List ( String, String ) -> State -> Html Msg
styleView styles ratingModel =
    let
        renderedRating =
            case ratingModel of
                RatingType state ->
                    state.renderedRating
    in
    div (styles |> List.map (\( style, value ) -> Html.Attributes.style style value))
        (generateRatingList
            renderedRating
            |> List.indexedMap star
        )


star : Int -> Bool -> Html Msg
star index filled =
    let
        updatedIndex =
            index + 1
    in
    span
        [ onClick (UpdateRating updatedIndex)
        , onMouseEnter (UpdateRenderedRatingOnEnter updatedIndex)
        , onMouseLeave UpdateRenderedRatingOnLeave
        ]
        [ chooseCharacter filled ]


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
            RatingType { rating = rating, renderedRating = rating }

        UpdateRenderedRatingOnEnter enteredRating ->
            enteredRating |> updateRenderedRatingOnMouseEnter model

        UpdateRenderedRatingOnLeave ->
            RatingType { ratingModel | renderedRating = ratingModel.rating }


updateRenderedRatingOnMouseEnter : State -> Int -> State
updateRenderedRatingOnMouseEnter ratingModel enteredRating =
    let
        model =
            case ratingModel of
                RatingType state ->
                    state
    in
    RatingType (updateRenderedRating model enteredRating)


{-| Get the current rating

    Rating.get ratingState

-}
get : State -> Int
get state =
    case state of
        RatingType model ->
            model.rating


{-| Initial rating model. Sets rating to zero.
-}
initialState : State
initialState =
    RatingType (Model 0 0)
