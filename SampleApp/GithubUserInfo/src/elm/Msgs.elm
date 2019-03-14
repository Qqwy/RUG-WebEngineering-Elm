module Msgs exposing (Msg(..))

import Http
import Models exposing (UserInfo)

{-| Events that might happen in our app -}
type Msg
    = SearchTextChange String
    | FetchUser
    | UserInfoLoaded (Result Http.Error UserInfo)
