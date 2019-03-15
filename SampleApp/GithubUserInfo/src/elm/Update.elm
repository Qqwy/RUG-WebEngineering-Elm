module Update exposing (update)

import Http
import Json.Decode
import Models exposing (Model)
import Msgs exposing (Msg(..))
import RemoteData exposing (WebData)


{-| Run each time an event occurs
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchTextChange newSearchText ->
            ( { model | searchText = newSearchText }, Cmd.none )

        FetchUser ->
            ( {model | userInfo = RemoteData.Loading}, fetchUserFromGithubAPI model.searchText )

        UserInfoLoaded userInfo ->
            ( { model | userInfo = userInfo }, Cmd.none )


fetchUserFromGithubAPI username =
    performGithubAPIRequest ("users/" ++ username) Models.userInfoDecoder UserInfoLoaded


performGithubAPIRequest : String -> Json.Decode.Decoder a -> (WebData a -> Msg) -> Cmd Msg
performGithubAPIRequest endpoint decoder msgOnResponse =
    let
        apiUrl =
            "https://api.github.com/"
    in
    Http.get
        { url = apiUrl ++ endpoint
        , expect = Http.expectJson (\response -> response |> RemoteData.fromResult |> msgOnResponse) decoder
        }
