module View exposing (view)

import Html exposing (Html, div, h1, h2, input, li, text, ul)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (Airline, Model, Msg(..))


view model =
    div []
        [ listView model
        , airlineDetailView model.currentAirline
        ]


listView model =
    let
        {--All airlines containing the search box text in their name-}
        matchingAirlines =
            model.airlines
                |> List.filter (\airline -> String.contains model.searchText airline.name)
    in
    div []
        [ input
            [ placeholder "Filter Airline Name"
            , class "airline-search"
            , onInput SearchTextChange
            ]
            []
        , airlinesView matchingAirlines
        ]


airlinesView : List Airline -> Html Msg
airlinesView airlines =
    ul [class "airlines-list"] (List.map airlineView airlines)


airlineView : Airline -> Html Msg
airlineView airline =
    li [ onClick (SelectAirline airline) ] [ text airline.name ]


airlineDetailView maybeAirline =
    case maybeAirline of
        Nothing ->
            div [ class "airline-detail no-airline-selected" ] [ text "Select an airline first" ]

        Just airline ->
            div [ class "airline-detail" ]
                [ h1 [] [ text airline.name ]
                , h2 [] [ text ("Abbreviation: " ++ airline.abbreviation) ]
                ]
