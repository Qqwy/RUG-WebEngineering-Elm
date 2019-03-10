module Update exposing (update)

import Models exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchTextChange newSearchText ->
            ( { model | searchText = newSearchText }, Cmd.none )

        SelectAirline airline ->
            ( { model | currentAirline = Just airline }, Cmd.none )
