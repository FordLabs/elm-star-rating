module Internal.Helpers exposing (chooseCharacter, generateRatingList, ratingToBoolean, updateRenderedRating)

import Html exposing (Html, text)
import Internal.Model exposing (Model)


ratingToBoolean : Int -> Int -> Bool
ratingToBoolean index rating =
    if rating > index then
        True

    else
        False


chooseCharacter : Bool -> Html msg
chooseCharacter filled =
    if filled then
        text "★"

    else
        text "☆"


generateRatingList : Int -> List Bool
generateRatingList rating =
    List.indexedMap (\index _ -> ratingToBoolean index rating) (List.repeat 5 "")


updateRenderedRating : Model -> Int -> Model
updateRenderedRating model enteredRating =
    if model.rating > enteredRating then
        { model | renderedRating = model.rating }

    else
        { model | renderedRating = enteredRating }
