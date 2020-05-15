module Msg exposing (Msg(..))

{-| Opaque type obscuring rating messages
-}


type Msg
    = UpdateRating Int
    | UpdateRenderedRatingOnEnter Int
    | UpdateRenderedRatingOnLeave
