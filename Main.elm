module Main exposing (main)

import Html exposing (Html, div)
import Msg exposing (Msg(UpdateRating, UpdateRenderedRatingOnEnter, UpdateRenderedRatingOnLeave))
import Rating exposing (RatingModel, chooseCharacter, generateRatingList, renderStars, updatedRenderedRatingOnEnter)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


type alias Model =
    RatingModel


init : ( Model, Cmd Msg )
init =
    ( RatingModel 0 0, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateRating rating ->
            ( { rating = rating, renderedRating = rating }, Cmd.none )

        UpdateRenderedRatingOnEnter enteredRating ->
            ( enteredRating |> updatedRenderedRatingOnEnter model, Cmd.none )

        UpdateRenderedRatingOnLeave ->
            ( { model | renderedRating = model.rating }, Cmd.none )


view : Model -> Html Msg
view model =
    div [] (renderStars model.renderedRating)
