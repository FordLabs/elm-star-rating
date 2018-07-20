module RatingTests exposing (..)

import Expect exposing (Expectation)
import Html exposing (text)
import Rating exposing (generateRatingList, ratingToBoolean, renderStar)
import Test exposing (..)


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
        , describe "renderStar tests"
            [ test "True returns filled star" <|
                \_ -> (renderStar True) |> Expect.equal (text "★")
            , test "False returns empty star" <|
                \_ -> (renderStar False) |> Expect.equal (text "☆")
            ]
        ]
