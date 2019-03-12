module Main exposing (main)

import Browser
import Html exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg)
import Cmds
import Update
import View


{-| Entry-point of application
-}
main =
    Browser.element
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = subscriptions
        }


{-| Initialize with a simple model. We don't need special configuration passed in.
-}
init : () -> ( Model, Cmd Msg )
init _ =
    ( Models.initialModel, Cmds.fetchAirlines )


{-| For this simple application, we need no subscriptions.
-}
subscriptions model =
    Sub.none
