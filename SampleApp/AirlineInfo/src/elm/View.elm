module View exposing (view)

import Html exposing (Html, div, h1, h2, input, li, text, ul)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (Airline, Model, Msg(..))


view model =
    div [ class "airlines-app" ]
        [ div [ class "ui grid" ]
            [ div [ class "sixteen wide column" ]
                [ h1 [ class "ui center aligned header" ] [ text "Fancy Airline Selection App" ]
                ]
            , div [ class "row" ]
                [ div [ class "three wide column" ] [ airlinesForm model ]
                , div [ class "thirteen wide column" ] [ airlineDetailView model.currentAirline ]
                ]
            ]
        ]


airlinesForm model =
    div [ class "airlines-form" ]
        [ input
            [ placeholder "Filter Airline Name"
            , class "airline-search"
            , onInput SearchTextChange
            ]
            []
        , airlinesView (Models.matchingAirlines model.airlines model.searchText) model.currentAirline
        ]


airlinesView : List Airline -> Maybe Airline -> Html Msg
airlinesView airlines currentAirline =
    let
        correctAirlineView =
            if Just airline == currentAirline then
                currentAirlineView airline

            else
                airlineView airline
    in
    ul [ class "airlines-list" ]
        (List.map correctAirlineView airlines)


airlineView : Airline -> Html Msg
airlineView airline =
    li [ onClick (SelectAirline airline) ] [ text (airline.abbreviation ++ ": " ++ airline.name) ]


currentAirlineView : Airline -> Html Msg
currentAirlineView airline =
    li [ class "current" ] [ text (airline.abbreviation ++ ": " ++ airline.name) ]


airlineDetailView maybeAirline =
    let
        content =
            case maybeAirline of
                Nothing ->
                    [ div [ class "empty" ]
                        [ text "Select an airline first" ]
                    ]

                Just airline ->
                    [ h1 [] [ text airline.name ]
                    , h2 [] [ text ("Abbreviation: " ++ airline.abbreviation) ]
                    ]
    in
    div [ class "airline-detail" ] content
