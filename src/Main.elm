module Main exposing (..)

import Html exposing (Html)
import Presentation exposing (Model, init, update, subscriptions, view)


main =
    Html.program
        { init = ( init, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
