module Cmds exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg(..))
import Json.Decode
import Http

{-|
Fetches information from our 'fake' API using a GET-request.

The result is decoded using the given jsonDecoder and then passed to the given Msg constructor.
 -}
performAPIRequest : String -> (Result Http.Error a -> Msg) -> Json.Decode.Decoder a -> Cmd Msg
performAPIRequest endpointPath responseMsg jsonDecoder =
    let
        fullPath =
            "./fake_server/" ++ endpointPath ++ ".json"
    in
    Http.get { url = fullPath, expect = Http.expectJson responseMsg jsonDecoder }

{-| The index endpoint returning a list of airlines -}
fetchAirlines =
    performAPIRequest "airlines" AirlinesLoaded Models.airlinesDecoder

{-| The details endpoint fetching more info about one single airline. -}
fetchAirlineDetails abbreviation =
    performAPIRequest ("details/" ++ abbreviation) AirlineDetailsLoaded Models.airlineDetailsDecoder
