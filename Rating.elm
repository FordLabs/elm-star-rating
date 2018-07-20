module Rating exposing (..)

import Html exposing (Html, span, text)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Msg exposing (Msg(UpdateRating, UpdateRenderedRatingOnEnter, UpdateRenderedRatingOnLeave))


type alias RatingModel =
    { rating : Int
    , renderedRating : Int
    }


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
    List.indexedMap (\index _ -> ratingToBoolean index rating) [ 1, 2, 3, 4, 5 ]


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


renderStars : Int -> List (Html Msg)
renderStars rating =
    (generateRatingList rating) |> List.indexedMap star
