module HelperTests exposing (suite)

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

import Expect
import Html exposing (div, text)
import Html.Attributes exposing (style)
import Internal.Helpers exposing (addOutlineIfInputFocused, chooseCharacter, generateRatingList, ratingToBoolean, updateRenderedRating)
import Internal.Model exposing (Model)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Rating Tests"
        [ describe "ratingToBoolean tests"
            [ test "if rating is greater than index return true" <|
                \_ -> ratingToBoolean 0 1 |> Expect.equal True
            , test "if rating is equal to than index return false" <|
                \_ -> ratingToBoolean 1 1 |> Expect.equal False
            , test "if rating is less than index return false" <|
                \_ -> ratingToBoolean 2 1 |> Expect.equal False
            ]
        , describe
            "generateRatingList tests"
            [ test "0 rating returns list of 5 true" <|
                \_ -> generateRatingList 0 |> Expect.equal [ False, False, False, False, False ]
            , test "3 rating returns list of 3 true followed by 2 false" <|
                \_ -> generateRatingList 3 |> Expect.equal [ True, True, True, False, False ]
            ]
        , describe "chooseCharacter tests"
            [ test "True returns filled star" <|
                \_ -> chooseCharacter True (Model 2 2 Nothing (text "★") (text "☆")) |> Expect.equal (text "★")
            , test "False returns empty star" <|
                \_ -> chooseCharacter False (Model 2 2 Nothing (text "★") (text "☆")) |> Expect.equal (text "☆")
            ]
        , describe "updatedRenderedRatingOnEnter tests"
            [ test "if rating is greater than index of entered star on mouseEnter then set renderedRating to rating" <|
                \_ -> 2 |> updateRenderedRating (Model 3 3 Nothing (div [] []) (div [] [])) |> Expect.equal (Model 3 3 Nothing (div [] []) (div [] []))
            , test "if rating is less than index of entered star on mouseEnter then set renderedRating to index of entered star" <|
                \_ -> 3 |> updateRenderedRating (Model 2 2 Nothing (div [] []) (div [] [])) |> Expect.equal (Model 2 3 Nothing (div [] []) (div [] []))
            ]
        , describe "addOutlineIfInputFocused tests"
            [ test "if focused index is Nothing then return empty list" <|
                \_ -> addOutlineIfInputFocused Nothing 1 |> Expect.equal []
            , test "if focused index is not equal to starIndex then return empty list" <|
                \_ -> addOutlineIfInputFocused (Just 3) 1 |> Expect.equal []
            , test "if focused index is equal to starIndex then return list of styles containing blue outline" <|
                \_ -> addOutlineIfInputFocused (Just 3) 3 |> Expect.equal [ style "outline" "0.125rem solid deepskyblue", style "border-radius" ".125rem" ]
            ]
        ]
