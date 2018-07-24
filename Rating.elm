module Rating exposing (..)

import Html exposing (Html, div, span, text)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)


type alias RatingModel =
    { rating : Int
    , renderedRating : Int
    }


type Msg
    = UpdateRating Int
    | UpdateRenderedRatingOnEnter Int
    | UpdateRenderedRatingOnLeave


initialRatingModel : RatingModel
initialRatingModel =
    RatingModel 0 0


updatedRenderedRatingOnEnter : RatingModel -> Int -> RatingModel
updatedRenderedRatingOnEnter ratingModel enteredRating =
    if ratingModel.rating > enteredRating then
        { ratingModel | renderedRating = ratingModel.rating }
    else
        { ratingModel | renderedRating = enteredRating }


ratingToBoolean : Int -> Int -> Bool
ratingToBoolean index rating =
    if rating > index then
        True
    else
        False


generateRatingList : Int -> List Bool
generateRatingList rating =
    List.indexedMap (\index _ -> ratingToBoolean index rating) (List.repeat 5 "")


chooseCharacter : Bool -> Html msg
chooseCharacter filled =
    if filled then
        text "★"
    else
        text "☆"


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


view : RatingModel -> Html Msg
view ratingModel =
    div [] ((generateRatingList ratingModel.renderedRating) |> List.indexedMap star)


update : Msg -> RatingModel -> RatingModel
update msg model =
    case msg of
        UpdateRating rating ->
            { rating = rating, renderedRating = rating }

        UpdateRenderedRatingOnEnter enteredRating ->
            enteredRating |> updatedRenderedRatingOnEnter model

        UpdateRenderedRatingOnLeave ->
            { model | renderedRating = model.rating }
