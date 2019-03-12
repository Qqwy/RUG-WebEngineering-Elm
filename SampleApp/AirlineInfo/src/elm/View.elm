module View exposing (view)

import Html exposing (Html, div, h1, h2, i, input, li, text, ul)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (Airline, Model, Msg(..))


view model =
    div [ class "airlines-app" ]
        [ div [ class "ui grid" ]
            [ div [ class "fifteen wide column" ]
                [ h1 [ class "ui center aligned header" ] [ text "Fancy Airline Selection App" ]
                ]
            , div [ class "row" ]
                [ div [ class "three wide column" ] [ airlinesForm model ]
                , div [ class "twelve wide column" ] [ airlineDetailView model.currentAirline ]
                ]
            ]
        ]


airlinesForm model =
    div [ class "airlines-form" ]
        [ div [ class "airline-search ui fluid icon input" ]
            [ input
                [ placeholder "Filter Airline Name"
                , onInput SearchTextChange
                ]
                []
            ]
        , airlinesView (Models.matchingAirlines model.airlines model.searchText) model.currentAirline
        ]


airlinesView : List Airline -> Maybe Airline -> Html Msg
airlinesView airlines currentAirline =
    let
        correctAirlineView airline =
            if Just airline == currentAirline then
                currentAirlineView airline

            else
                airlineView airline
    in
    div [ class "airlines-list ui relaxed divided list" ]
        (List.map correctAirlineView airlines)


airlineView : Airline -> Html Msg
airlineView airline =
    div [ class "item", onClick (SelectAirline airline) ] [ text (airline.abbreviation ++ ": " ++ airline.name) ]


currentAirlineView : Airline -> Html Msg
currentAirlineView airline =
    div [ class "current item" ] [ text (airline.abbreviation ++ ": " ++ airline.name) ]


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
