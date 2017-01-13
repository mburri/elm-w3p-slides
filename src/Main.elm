module Main exposing (..)

import Html exposing (Html)
import Presentation exposing (Model, init, update, subscriptions, view, getJson)
import Json.Decode


main =
    Html.program
        { init = ( init, getJson )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
