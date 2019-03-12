module Models exposing (Airline, AirlineDetails, Model, initialModel, matchingAirlines, airlinesDecoder, airlineDetailsDecoder)

import Json.Decode as JD

type alias Airline =
    { name : String
    , abbreviation : String
    }


type alias AirlineDetails =
    { name : String
    , abbreviation : String
    , flights : Int
    }


type alias Model =
    { airlines : List Airline
    , currentAirline : Maybe AirlineDetails
    , searchText : String
    }


initialModel : Model
initialModel =
    { airlines = []

    -- [ { name = "My Jet Now Airlines", abbreviation = "MJN" }
    -- , { name = "SuperFast Planes", abbreviation = "SFP" }
    -- , { name = "Airlines Anonymous", abbreviation = "AA" }
    -- ]
    , currentAirline = Nothing
    , searchText = ""
    }


airlinesDecoder =
    JD.list airlineDecoder


airlineDecoder =
    JD.map2 Airline
        (JD.field "name" JD.string)
        (JD.field "abbr" JD.string)


airlineDetailsDecoder =
    JD.map3 AirlineDetails
        (JD.field "name" JD.string)
        (JD.field "abbr" JD.string)
        (JD.field "flights" JD.int)


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
