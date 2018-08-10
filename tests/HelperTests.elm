module HelperTests exposing (suite)

import Expect
import Html exposing (text)
import Internal.Helpers exposing (chooseCharacter, generateRatingList, ratingToBoolean, updateRenderedRating)
import Internal.Model exposing (Model)
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Rating Tests"
        [ describe "ratingToBoolean tests"
            [ test "if rating is greater than index return true" <|
                \_ -> (ratingToBoolean 0 1) |> Expect.equal True
            , test "if rating is equal to than index return false" <|
                \_ -> (ratingToBoolean 1 1) |> Expect.equal False
            , test "if rating is less than index return false" <|
                \_ -> (ratingToBoolean 2 1) |> Expect.equal False
            ]
        , describe
            "generateRatingList tests"
            [ test "0 rating returns list of 5 true" <|
                \_ -> (generateRatingList 0 |> Expect.equal [ False, False, False, False, False ])
            , test "3 rating returns list of 3 true followed by 2 false" <|
                \_ -> (generateRatingList 3 |> Expect.equal [ True, True, True, False, False ])
            ]
        , describe "chooseCharacter tests"
            [ test "True returns filled star" <|
                \_ -> (chooseCharacter True) |> Expect.equal (text "★")
            , test "False returns empty star" <|
                \_ -> (chooseCharacter False) |> Expect.equal (text "☆")
            ]
        , describe "updatedRenderedRatingOnEnter tests"
            [ test "if rating is greater than index of entered star on mouseEnter then set renderedRating to rating" <|
                \_ -> 2 |> updateRenderedRating (Model 3 3) |> Expect.equal (Model 3 3)
            , test "if rating is less than index of entered star on mouseEnter then set renderedRating to index of entered star" <|
                \_ -> 3 |> updateRenderedRating (Model 2 2) |> Expect.equal (Model 2 3)
            ]
        ]