module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, src)
import Html.Events exposing (onClick, onInput)
import Http exposing (Error(..))
import Models exposing (..)
import Msgs exposing (Msg(..))
import RemoteData exposing (RemoteData(..))


{-| Convert the current Model to displayable HTML
-}
view : Model -> Html Msg
view model =
    div [ class "ui container github-user-info-app " ]
        [ div [class "ui segments"] [ viewUserDetails model.userInfo
          , viewForm model
          ]
        ]


viewForm model =
    div [ class "ui segment" ]
        [ input [ onInput SearchTextChange, placeholder "Enter a GitHub username" ] []
        , button [ onClick FetchUser ] [ text "Find" ]
        ]


viewUserDetails userInfoWebData =
    let
        content =
            case userInfoWebData of
                NotAsked ->
                    [ em [] [ text "Search a user first" ]
                    ]

                Loading ->
                    [ em [] [ text "Loading..." ] ]

                Failure (BadStatus _) ->
                    [ strong [] [ text "User does not exist" ] ]

                Failure Timeout ->
                    [ strong [] [ text "Your internet connection timed out" ] ]

                Failure _ ->
                    [ text "Problem loading user" ]

                Success userInfo ->
                    [ h1 [] [ text userInfo.name ]
                    , img [ src userInfo.avatarUrl ] []
                    , a [ href userInfo.profileUrl ] [ text userInfo.profileUrl ]
                    ]
    in
    div [ class "ui segment" ] content
