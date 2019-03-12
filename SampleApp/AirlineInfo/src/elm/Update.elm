module Update exposing (update)

import Cmds
import Models exposing (Model)
import Msgs exposing (Msg(..))


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
                Err _ ->
                    -- TODO logging
                    ( model, Cmd.none )

                Ok airlines ->
                    ( { model | airlines = airlines }, Cmd.none )

        AirlineDetailsLoaded airlineDetailsResult ->
            case airlineDetailsResult of
                Err _ ->
                    -- TODO logging
                    ( model, Cmd.none )

                Ok airlineDetails ->
                    ( { model | currentAirline = Just airlineDetails }, Cmd.none )
