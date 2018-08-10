module Example exposing (main)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Rating


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


type alias Model =
    { ratingState : Rating.State }


type Msg
    = RatingMsg Rating.Msg


init : ( Model, Cmd Msg )
init =
    ( { ratingState = Rating.initialRatingModel }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RatingMsg msg ->
            ( { model | ratingState = (Rating.update msg model.ratingState) }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ (Html.map RatingMsg (Rating.view [] model.ratingState))
        , div []
            [ text
                ((Rating.get model.ratingState) |> toString)
            ]
        ]
