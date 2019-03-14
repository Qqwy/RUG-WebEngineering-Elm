module Models exposing (..)

import Json.Decode as JD


type alias Model =
    { searchText : String
    , userInfo : Maybe UserInfo
    , errorLog : Maybe String
    }

type alias UserInfo =
    { name : String
    , avatarUrl : String
    , profileUrl : String
    }

initialModel : Model
initialModel = {searchText = ""
               , userInfo = Nothing
               , errorLog = Nothing
               }
