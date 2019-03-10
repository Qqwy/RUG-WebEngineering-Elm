module Models exposing (Airline, Model, Msg(..), initialModel, matchingAirlines)


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
        [ { name = "My Jet Now Airlines", abbreviation = "MJN" }
        , { name = "SuperFast Planes", abbreviation = "SFP" }
        , { name = "Airlines Anonymous", abbreviation = "AA" }
        ]
    , currentAirline = Nothing
    , searchText = ""
    }


{-| All airlines containing the search box text in their name.
Case-Insensitive
-}
matchingAirlines airlines query =
    let
        normalizedQuery =
            String.toUpper query

        containsQuery : String -> Bool
        containsQuery str =
            String.contains normalizedQuery (String.toUpper str)
    in
    airlines
        |> List.filter
            (\airline ->
                containsQuery airline.abbreviation
                    || containsQuery airline.name
            )
