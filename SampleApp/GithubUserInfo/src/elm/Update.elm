module Update exposing (update)

import Models exposing (Model)
import Msgs exposing (Msg(..))
import Http

{-| Run each time an event occurs -}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    (model, Cmd.none)
