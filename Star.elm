module Star exposing (..)


type alias Stars =
    { rating : Maybe Int }


none : String
none =
    "☆☆☆☆☆"


one : String
one =
    "★☆☆☆☆"


two : String
two =
    "★★☆☆☆"


three : String
three =
    "★★★☆☆"


four : String
four =
    "★★★★☆"


five : String
five =
    "★★★★★"


render : Stars -> String
render stars =
    case stars.rating of
        Just 1 ->
            one

        Just 2 ->
            two

        Just 3 ->
            three

        Just 4 ->
            four

        Just 5 ->
            five

        Nothing ->
            none

        _ ->
            none
