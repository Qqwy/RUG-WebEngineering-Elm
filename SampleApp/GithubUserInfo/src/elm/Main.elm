module Main exposing (main)

import Browser
import Html exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg)
import Update
import View


{-| Entry-point of application
-}
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = View.view
        , update = Update.update
        }


{-| Initialize with a simple model. We don't need special configuration passed in.
-}
init : () -> ( Model, Cmd Msg )
init _ =
    ( Models.initialModel, Cmd.none )


{-| For this simple application, we need no subscriptions.
-}
subscriptions model =
    Sub.none

