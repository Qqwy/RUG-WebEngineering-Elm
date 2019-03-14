module Update exposing (update)

import Http
import Models exposing (Model)
import Msgs exposing (Msg(..))


{-| Run each time an event occurs
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchTextChange newSearchText ->
            ( { model | searchText = newSearchText }, Cmd.none )

        FetchUser ->
            ( model, fetchUserFromGithubAPI model.searchText )

        UserInfoLoaded (Ok userInfo) ->
            ( { model | userInfo = Just userInfo }, Cmd.none )

        UserInfoLoaded (Err _) ->
            ( model, Cmd.none )


fetchUserFromGithubAPI username =
    performGithubAPIRequest ("users/" ++ username) UserInfoLoaded Models.userInfoDecoder


performGithubAPIRequest endpoint msgOnResponse decoder =
    let
        apiUrl =
            "https://api.github.com/"
    in
    Http.get { url = apiUrl ++ endpoint, expect = Http.expectJson msgOnResponse decoder }
