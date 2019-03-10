module AirlineInfo exposing (main)

import Browser
import Html exposing (..)


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
    { airlines = []
    , currentAirline = Nothing
    , searchText = ""
    }


init : () -> ( Model, Cmd msg )
init _ =
    ( initialModel, Cmd.none )

subscriptions model = Sub.none

main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchTextChange newSearchText ->
            ( { model | searchText = newSearchText }, Cmd.none )

        SelectAirline airline ->
            ( { model | currentAirline = Just airline }, Cmd.none )


view model =
    div [] [ text "Hello, world!" ]
