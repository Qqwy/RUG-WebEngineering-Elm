module Update exposing (update)

import Http
import RemoteData exposing (WebData)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Json.Decode


{-| Run each time an event occurs
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchTextChange newSearchText ->
            ( { model | searchText = newSearchText }, Cmd.none )

        FetchUser ->
            ( model, fetchUserFromGithubAPI model.searchText )

        UserInfoLoaded userInfo ->
            ({model | userInfo = userInfo}, Cmd.none)


fetchUserFromGithubAPI username =
    performGithubAPIRequest ("users/" ++ username) UserInfoLoaded Models.userInfoDecoder

performGithubAPIRequest : String -> (WebData a -> Msg) -> Json.Decode.Decoder a -> Cmd Msg
performGithubAPIRequest endpoint msgOnResponse decoder =
    let
        apiUrl =
            "https://api.github.com/"
    in
    Http.get { url = apiUrl ++ endpoint, expect = Http.expectJson (\response -> response |> RemoteData.fromResult |> msgOnResponse) decoder }
