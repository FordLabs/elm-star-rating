module Example exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Browser
import Rating


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { ratingState : Rating.State }


type Msg
    = RatingMsg Rating.Msg


init : Model
init =
    { ratingState = Rating.initialRatingModel }


update : Msg -> Model -> Model
update msg model =
    case msg of
        RatingMsg message ->
            { model | ratingState = Rating.update message model.ratingState }


view : Model -> Html Msg
view model =
    div []
        [ Html.map RatingMsg (Rating.view [] model.ratingState)
        , div []
            [ text
                (Rating.get model.ratingState |> String.fromInt)
            ]
        ]
