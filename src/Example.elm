{-
   Copyright 2018 Ford Motor Company

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
-}


module Example exposing (main)

import Browser
import Html exposing (Html, div, fieldset, legend, text)
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
    { classRatingState : Rating.State, styleRatingState : Rating.State, customRatingState : Rating.State }


type Msg
    = ClassRatingMsg Rating.Msg
    | StyleRatingMsg Rating.Msg
    | CustomRatingMsg Rating.Msg


init : Model
init =
    { classRatingState = Rating.initialState
    , styleRatingState = Rating.initialState |> Rating.set 3
    , customRatingState = Rating.initialCustomState (text "😃") (text "🤨")
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClassRatingMsg message ->
            { model | classRatingState = Rating.update message model.classRatingState }

        StyleRatingMsg message ->
            { model | styleRatingState = Rating.update message model.styleRatingState }

        CustomRatingMsg message ->
            { model | customRatingState = Rating.update message model.customRatingState }


view : Model -> Html Msg
view model =
    div [ style "padding-left" "3rem", style "width" "15rem" ]
        [ fieldset
            []
            [ legend [] [ text "default star rating" ]
            , Html.map ClassRatingMsg (Rating.classView "default rating" [] model.classRatingState)
            , div []
                [ text
                    (Rating.get model.classRatingState |> String.fromInt)
                ]
            ]
        , fieldset []
            [ legend [] [ text "red star rating" ]
            , Html.map StyleRatingMsg (Rating.styleView "red rating" [ ( "color", "red" ), ( "font-size", "24px" ) ] model.styleRatingState)
            , div []
                [ text
                    (Rating.get model.styleRatingState |> String.fromInt)
                ]
            ]
        , fieldset []
            [ legend [] [ text "custom emoji star rating" ]
            , Html.map CustomRatingMsg (Rating.styleView "emoji rating" [ ( "font-size", "24px" ) ] model.customRatingState)
            , div []
                [ text
                    (Rating.get model.customRatingState |> String.fromInt)
                ]
            ]
        ]
