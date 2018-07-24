module Main exposing (main)

import Html exposing (Html, div)
import Rating exposing (RatingModel, Msg, chooseCharacter, generateRatingList, initialRatingModel, updatedRenderedRatingOnEnter, view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


type alias Model =
    { ratingModel : RatingModel }


type Msg
    = RatingMsg Rating.Msg


init : ( Model, Cmd Msg )
init =
    ( { ratingModel = initialRatingModel }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RatingMsg msg ->
            ( { model | ratingModel = (Rating.update msg model.ratingModel) }, Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ (Html.map RatingMsg (Rating.view model.ratingModel)) ]
