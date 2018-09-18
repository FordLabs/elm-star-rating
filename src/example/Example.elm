module Example exposing (main)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Rating


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { classRatingState : Rating.State, styleRatingState : Rating.State }


type Msg
    = ClassRatingMsg Rating.Msg
    | StyleRatingMsg Rating.Msg


init : Model
init =
    { classRatingState = Rating.initialRatingModel, styleRatingState = Rating.initialRatingModel }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClassRatingMsg message ->
            { model | classRatingState = Rating.update message model.classRatingState }

        StyleRatingMsg message ->
            { model | styleRatingState = Rating.update message model.styleRatingState }


view : Model -> Html Msg
view model =
    div []
        [ Html.map ClassRatingMsg (Rating.classView [] model.classRatingState)
        , div []
            [ text
                (Rating.get model.classRatingState |> String.fromInt)
            ]
        , div
            []
            [ Html.map StyleRatingMsg (Rating.styleView [ ( "color", "red" ), ( "font-size", "24px" ) ] model.styleRatingState) ]
        , div []
            [ text
                (Rating.get model.styleRatingState |> String.fromInt)
            ]
        ]
