module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, src, href)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import Msgs exposing (Msg(..))


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


viewUserDetails maybeUserInfo =
    case maybeUserInfo of
        Nothing ->
            div []
                [ em [] [ text "Search a user first" ]
                ]

        Just userInfo ->
            div [ class "card ui" ]
                [ h1 [] [ text userInfo.name ]
                , img [ src userInfo.avatarUrl ] []
                , a [href userInfo.profileUrl] [text userInfo.profileUrl]
                ]


errorLogView error =
    case error of
        Nothing ->
            text ""

        Just errorText ->
            div [ class "ui error message" ]
                [ div [ class "header" ] [ text "Error encountered while communicating with the server:" ]
                , div [ class "description" ] [ text errorText ]
                ]
