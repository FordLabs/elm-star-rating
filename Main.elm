module Main exposing (main)

import Html exposing (Html, button, div, span, text)
import Html.Events exposing (onClick)
import Rating exposing (star, generateRatingList)


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
    ( Model (generateRatingList 0) 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        RatingUp ->
            let
                updatedRating =
                    model.rating + 1

                updatedRatingList =
                    generateRatingList updatedRating
            in
                ( Model updatedRatingList updatedRating, Cmd.none )


type alias Model =
    { ratingList : List Bool
    , rating : Int
    }


type Msg
    = NoOp
    | RatingUp


view : Model -> Html Msg
view model =
    div [] ((model.ratingList |> List.map star) ++ [ button [ onClick RatingUp ] [ text "+1" ] ])
