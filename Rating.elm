module Rating exposing (State, view, update, initialRatingModel, Msg, get)

import Html exposing (Html, div, span, text)
import Html.Events exposing (onClick, onMouseEnter, onMouseLeave)


type alias Model =
    { rating : Int
    , renderedRating : Int
    }


type State
    = RatingType Model


type Msg
    = UpdateRating Int
    | UpdateRenderedRatingOnEnter Int
    | UpdateRenderedRatingOnLeave


view : State -> Html Msg
view ratingModel =
    let
        val =
            case ratingModel of
                RatingType a ->
                    a.renderedRating
    in
        div []
            (generateRatingList
                val
                |> List.indexedMap star
            )


get : State -> Int
get state =
    case state of
        RatingType model ->
            model.rating


generateRatingList : Int -> List Bool
generateRatingList rating =
    List.indexedMap (\index _ -> ratingToBoolean index rating) (List.repeat 5 "")


ratingToBoolean : Int -> Int -> Bool
ratingToBoolean index rating =
    if rating > index then
        True
    else
        False


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


chooseCharacter : Bool -> Html msg
chooseCharacter filled =
    if filled then
        text "★"
    else
        text "☆"


update : Msg -> State -> State
update msg model =
    let
        ratingModel =
            case model of
                RatingType ratingModel ->
                    ratingModel
    in
        case msg of
            UpdateRating rating ->
                RatingType { rating = rating, renderedRating = rating }

            UpdateRenderedRatingOnEnter enteredRating ->
                enteredRating |> updatedRenderedRatingOnEnter model

            UpdateRenderedRatingOnLeave ->
                RatingType { ratingModel | renderedRating = ratingModel.rating }


updatedRenderedRatingOnEnter : State -> Int -> State
updatedRenderedRatingOnEnter ratingModel enteredRating =
    let
        model =
            case ratingModel of
                RatingType a ->
                    a
    in
        if model.rating > enteredRating then
            RatingType { model | renderedRating = model.rating }
        else
            RatingType { model | renderedRating = enteredRating }


initialRatingModel : State
initialRatingModel =
    RatingType (Model 0 0)
