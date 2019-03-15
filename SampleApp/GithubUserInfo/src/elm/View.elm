module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, src)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http exposing (Error(..))
import Models exposing (..)
import Msgs exposing (Msg(..))
import RemoteData exposing (RemoteData(..))


{-| Convert the current Model to displayable HTML
-}
view : Model -> Html Msg
view model =
    div [ class "ui container github-user-info-app " ]
        [ h1 [ class "ui centered header" ] [ text "Elm Github User Info App" ]
        , div [ class "ui segments" ]
            [ viewUserDetails model.userInfo
            , viewForm model
            ]
        ]


viewForm model =
    div [ class "ui segment" ]
        [ form [ onSubmit FetchUser, class "ui huge fluid action input" ]
            [ input [ onInput SearchTextChange, placeholder "Enter a GitHub username" ] []
            , button [ class "ui huge right labeled icon button" ] [ i [ class "search icon" ] [], text "Find" ]
            ]
        ]


viewUserDetails userInfoWebData =
    case userInfoWebData of
        NotAsked ->
            div [ class "ui segment" ]
                [ em [] [ text "Search a user first" ]
                ]

        Loading ->
            div [ class "ui loading segment" ]
                [ em [] [ text "Loading..." ]
                ]

        Failure failure ->
            let
                failureText =
                    case failure of
                        BadStatus 404 ->
                            "User does not exist"

                        Timeout ->
                            "Your internet connection timed out."

                        _ ->
                            "Problem loading user"
            in
            div [ class "ui segment" ] [ div [ class "ui error message" ] [ text failureText ] ]

        Success userInfo ->
            div [ class "ui segment" ]
                [ div
                    [ class "ui centered card" ]
                    [ div [ class "image" ] [ img [ src userInfo.avatarUrl ] [] ]
                    , div [ class "content" ]
                        [ a [ class "header", href userInfo.profileUrl ] [ text userInfo.name ]
                        , a [ class "meta", href userInfo.profileUrl ] [ text userInfo.profileUrl ]
                        ]
                    , div [ class "extra content" ]
                        [ span [] [ i [ class "archive icon" ] [], text (String.fromInt userInfo.publicRepos ++ " Public Repos") ]
                        ]
                    ]
                ]
