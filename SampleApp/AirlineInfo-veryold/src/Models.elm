module Models exposing (..)

type alias Airline =
    { name : String
    , abbreviation : String
    }


type alias Model =
    { airlines : List Airline
    , currentAirline : Maybe Airline
    , searchText : String
    }


type Msg
    = SearchTextChange String
    | SelectAirline Airline


initialModel : Model
initialModel =
    { airlines =
          [ {name = "My Jet Now Airlines", abbreviation = "MJN" },
                {name = "SuperFast Planes", abbreviation = "SFP"}
          ]
    , currentAirline = Nothing
    , searchText = ""
    }
