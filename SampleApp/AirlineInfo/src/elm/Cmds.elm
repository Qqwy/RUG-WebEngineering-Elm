module Cmds exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg(..))
import Json.Decode
import Http


performAPIRequest : String -> (Result Http.Error a -> Msg) -> Json.Decode.Decoder a -> Cmd Msg
performAPIRequest endpointPath responseMsg jsonDecoder =
    let
        fullPath =
            "./fake_server/" ++ endpointPath ++ ".json"
    in
    Http.get { url = fullPath, expect = Http.expectJson responseMsg jsonDecoder }


fetchAirlines =
    performAPIRequest "airlines" AirlinesLoaded Models.airlinesDecoder


fetchAirlineDetails abbreviation =
    performAPIRequest ("details/" ++ abbreviation) AirlineDetailsLoaded Models.airlineDetailsDecoder
