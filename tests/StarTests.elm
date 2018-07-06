module StarTests exposing (..)

import Expect exposing (Expectation)
import Star exposing (Stars, none, one, render)
import Test exposing (..)


suite : Test
suite =
    describe "star tests"
        [ test "returns 5 empty stars on none" <|
            \_ ->
                Star.none
                    |> Expect.equal "☆☆☆☆☆"
        , test "returns one star rating on 1" <|
            \_ ->
                Star.one
                    |> Expect.equal
                        "★☆☆☆☆"
        , test "render returns none when rating is set to Nothing" <|
            \_ -> Stars Nothing |> Star.render |> Expect.equal none
        , test "render returns one when rating is set to 1" <|
            \_ -> Stars (Just 1) |> Star.render |> Expect.equal one
        ]
