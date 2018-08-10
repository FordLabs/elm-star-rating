module Rating exposing (State, view, update, initialRatingModel, Msg, get)

import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Internal.Helpers exposing (chooseCharacter, generateRatingList, ratingToBoolean, updateRenderedRating)
import Internal.Model exposing (Model)


type State
    = RatingType Model


type Msg
    = UpdateRating Int
    | UpdateRenderedRatingOnEnter Int
    | UpdateRenderedRatingOnLeave


view : List String -> State -> Html Msg
view attributes ratingModel =
    let
        val =
            case ratingModel of
                RatingType a ->
                    a.renderedRating
    in
        div (attributes |> List.map (\attribute -> class attribute))
            (generateRatingList
                val
                |> List.indexedMap star
            )


get : State -> Int
get state =
    case state of
        RatingType model ->
            model.rating


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


update : Msg -> State -> State
update msg model =
    let
        ratingModel =
            case model of
                RatingType ratingModel ->
                    ratingModel
    in
        case msg of
            UpdateRating rating ->
                RatingType { rating = rating, renderedRating = rating }

            UpdateRenderedRatingOnEnter enteredRating ->
                enteredRating |> updatedRenderedRatingOnEnter model

            UpdateRenderedRatingOnLeave ->
                RatingType { ratingModel | renderedRating = ratingModel.rating }


updatedRenderedRatingOnEnter : State -> Int -> State
updatedRenderedRatingOnEnter ratingModel enteredRating =
    let
        model =
            case ratingModel of
                RatingType model ->
                    model
    in
        RatingType (updateRenderedRating model enteredRating)


initialRatingModel : State
initialRatingModel =
    RatingType (Model 0 0)
