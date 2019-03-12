module Msgs exposing (Msg(..))

import Http
import Models exposing (Airline, AirlineDetails)

{-| Events that might happen in our app -}
type Msg
    = SearchTextChange String
    | FetchAirlines
    | AirlinesLoaded (Result Http.Error (List Airline))
    | SelectAirline Airline
    | AirlineDetailsLoaded (Result Http.Error AirlineDetails)
