module Models exposing (Model, UserInfo, initialModel, userInfoDecoder)

import Json.Decode as JD
import RemoteData exposing (WebData)


type alias Model =
    { searchText : String
    , userInfo : WebData UserInfo -- NotAsked / Loading / Failure / Success
    }


type alias UserInfo =
    { name : String
    , avatarUrl : String
    , profileUrl : String
    , publicRepos : Int
    }


initialModel : Model
initialModel =
    { searchText = ""
    , userInfo = RemoteData.NotAsked
    }


userInfoDecoder =
    JD.map4 UserInfo
        (JD.field "login" JD.string)
        (JD.field "avatar_url" JD.string)
        (JD.field "html_url" JD.string)
        (JD.field "public_repos" JD.int)
