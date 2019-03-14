module View exposing (view)

import Html exposing (Html, div, h1, h2, i, input, li, text, ul, dl, dt, dd)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import Msgs exposing (Msg(..))

{-| Convert the current Model to displayable HTML -}
view : Model -> Html Msg
view model = div [] []

errorLogView error =
    case error of
        Nothing ->
            text ""
        Just errorText ->
            div [class "ui error message"]
                [ div [class "header"] [text "Error encountered while communicating with the server:"]
                , div [class "description"] [text errorText]
                ]
