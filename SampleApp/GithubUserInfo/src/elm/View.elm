module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, src, href)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import Msgs exposing (Msg(..))
import RemoteData exposing (RemoteData(..))
import Http exposing (Error(..))

{-| Convert the current Model to displayable HTML
-}
view : Model -> Html Msg
view model =
    div [ class "github-user-info-app" ]
        [ viewUserDetails model.userInfo
        , viewForm model
        ]


viewForm model =
    div []
        [ input [ onInput SearchTextChange, placeholder "Enter a GitHub username" ] []
        , button [ onClick FetchUser ] [ text "Find" ]
        ]


viewUserDetails userInfoWebData =
    case userInfoWebData of
        NotAsked ->
            div []
                [ em [] [ text "Search a user first" ]
                ]
        Loading ->
            div [] [ em [] [text "Loading..."]]
        Failure (BadStatus _)->
            div [] [ strong [] [text ("User does not exist")]]
        Failure Timeout->
            div [] [ strong [] [text ("Your internet connection timed out")]]
        Failure _ ->
            div [] [text "Problem loading user"]

        Success userInfo ->
            div [ class "card ui" ]
                [ h1 [] [ text userInfo.name ]
                , img [ src userInfo.avatarUrl ] []
                , a [href userInfo.profileUrl] [text userInfo.profileUrl]
                ]
