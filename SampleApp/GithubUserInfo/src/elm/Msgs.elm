module Msgs exposing (Msg(..))

import Http
import RemoteData exposing (WebData)
import Models exposing (UserInfo)

{-| Events that might happen in our app -}
type Msg
    = SearchTextChange String
    | FetchUser
    | UserInfoLoaded (WebData UserInfo)
