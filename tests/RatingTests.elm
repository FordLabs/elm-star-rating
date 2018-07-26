module RatingTests exposing (..)

import Expect exposing (Expectation)
import Html exposing (text)
import Rating
import Test exposing (..)


suite : Test
suite =
    describe "Rating Tests"
        [ test "placeholder, hid testable functions behind opaque types." <|
            \_ -> 1 |> Expect.equal 1
        ]
