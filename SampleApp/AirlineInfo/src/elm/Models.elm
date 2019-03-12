module Models exposing (Airline, AirlineDetails, Model, airlineDetailsDecoder, airlinesDecoder, initialModel, matchingAirlines)

import Json.Decode as JD


{-| The basic info we know about an Airline.
Returned by index endpoint; used in list.
-}
type alias Airline =
    { name : String
    , abbreviation : String
    }


{-| The extra info we obtain from looking at the details
endpoint of a given Airline.
-}
type alias AirlineDetails =
    { name : String
    , abbreviation : String
    , flights : Int
    }


type alias Model =
    { airlines : List Airline --| The airlines that can be selected
    , searchText : String --| The text we filter the 'airlines' list by.
    , currentAirline : Maybe AirlineDetails --| The current airline we ar looking at in detail
    , errorLog : Maybe String --| to display connection problems to the user.
    }


{-| An empty Model to start the app with
-}
initialModel : Model
initialModel =
    { airlines = []
    , currentAirline = Nothing
    , searchText = ""
    , errorLog = Nothing
    }


airlinesDecoder =
    JD.list airlineDecoder


{-| Decodes a single Airline object from JSON.
-}
airlineDecoder =
    JD.map2 Airline
        (JD.field "name" JD.string)
        (JD.field "abbr" JD.string)


{-| Decodes a single AirlineDetails object from JSON.
-}
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
