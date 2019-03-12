module Update exposing (update)

import Cmds
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Http

{-| Run each time an event occurs -}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchTextChange newSearchText ->
            ( { model | searchText = newSearchText }, Cmd.none )

        SelectAirline airline ->
            ( model, Cmds.fetchAirlineDetails airline.abbreviation )

        FetchAirlines ->
            ( model, Cmds.fetchAirlines )

        AirlinesLoaded airlinesResult ->
            case airlinesResult of
                Err error ->
                    ( logResponseError error model, Cmd.none )

                Ok airlines ->
                    ( { model | airlines = airlines }, Cmd.none )

        AirlineDetailsLoaded airlineDetailsResult ->
            case airlineDetailsResult of
                Err error ->
                    ( logResponseError error model, Cmd.none )

                Ok airlineDetails ->
                    ( { model | currentAirline = Just airlineDetails }, Cmd.none )

{-| Show errors to the user -}
logResponseError httpError model =
    let
        errorString =
            case httpError of
                Http.BadUrl url ->
                    "`" ++ url ++ "` was a bad URL and could not be found."

                Http.Timeout ->
                    "The connection timed out"

                Http.NetworkError ->
                    "The network connection was interrupted."

                Http.BadStatus status ->
                    "Bad status code returned by server, indicating failure: " ++ (String.fromInt status)

                Http.BadBody info ->
                    "Response could not be parsed: " ++ info
    in
    { model | errorLog = Just errorString }
