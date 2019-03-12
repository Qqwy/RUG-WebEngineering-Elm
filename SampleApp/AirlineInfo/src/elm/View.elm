module View exposing (view)

import Html exposing (Html, div, h1, h2, i, input, li, text, ul, dl, dt, dd)
import Html.Attributes exposing (class, placeholder)
import Html.Events exposing (onClick, onInput)
import Models exposing (Airline, AirlineDetails, Model)
import Msgs exposing (Msg(..))


view : Model -> Html Msg
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


airlinesForm : Model -> Html Msg
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


airlinesView : List Airline -> Maybe AirlineDetails -> Html Msg
airlinesView airlines currentAirline =
    let
        correctAirlineView airline =
            if Just airline.abbreviation == (currentAirline |> Maybe.map .abbreviation) then
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


airlineDetailView maybeAirlineDetails =
    let
        content =
            case maybeAirlineDetails of
                Nothing ->
                    [ div [ class "empty" ]
                        [ text "Select an airline first" ]
                    ]

                Just airline ->
                    [ h1 [] [ text airline.name ]
                    , dl []
                        [ dt [] [ text "abbreviation" ]
                        , dd [] [ text airline.abbreviation ]
                        , dt [] [ text "No. of flights" ]
                        , dd [] [ text (String.fromInt airline.flights) ]
                        ]
                    ]
    in
    div [ class "airline-detail" ] content
