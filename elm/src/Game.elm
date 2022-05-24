module Game exposing (..)

import Date exposing (Date, dateDecoder)
import Genre exposing (Genre, genreDecoder)
import Json.Decode as Decode exposing (Decoder, int, list, nullable, string)
import Json.Decode.Pipeline exposing (required)


type GameId
    = GameId Int


idDecoder : Decoder GameId
idDecoder =
    Decode.map GameId int


idToString : GameId -> String
idToString (GameId id) =
    String.fromInt id


type alias BasicListGame =
    { id : GameId
    , slug : String
    , name : String
    , background_image : Maybe String
    , released : Maybe Date
    , genres : List Genre
    }


basicListGameDecoder : Decoder BasicListGame
basicListGameDecoder =
    Decode.succeed BasicListGame
        |> required "id" idDecoder
        |> required "slug" string
        |> required "name" string
        |> required "background_image" (nullable string)
        |> required "released" (nullable dateDecoder)
        |> required "genres" (list genreDecoder)
