module Main exposing (main)

import Html exposing (Html, button, div, span, text)
import Html.Events exposing (onClick)
import Rating exposing (generateRatingList, renderStar)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


init : ( Model, Cmd Msg )
init =
    ( Model 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateRating rating ->
            ( Model rating, Cmd.none )


type alias Model =
    { rating : Int
    }


type Msg
    = NoOp
    | UpdateRating Int


star : Int -> Bool -> Html Msg
star index filled =
    span [ onClick (UpdateRating (index + 1)) ] [ renderStar filled ]


renderStars : Int -> List (Html Msg)
renderStars rating =
    (generateRatingList rating) |> List.indexedMap star


view : Model -> Html Msg
view model =
    div [] (renderStars model.rating)
