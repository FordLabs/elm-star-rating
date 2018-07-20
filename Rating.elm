module Rating exposing (..)

import Html exposing (Html, span, text)


ratingToBoolean : Int -> Int -> Bool
ratingToBoolean index rating =
    if rating > index then
        True
    else
        False


generateRatingList : Int -> List Bool
generateRatingList rating =
    List.indexedMap (\index _ -> ratingToBoolean index rating) [ 1, 2, 3, 4, 5 ]


star : Bool -> Html msg
star filled =
    span [] [ renderStar filled ]


renderStar : Bool -> Html msg
renderStar filled =
    if filled then
        text "★"
    else
        text "☆"
