module Genre exposing (..)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (required)


type GenreId
    = GenreId Int


idDecoder : Decoder GenreId
idDecoder =
    Decode.map GenreId int


idToString : GenreId -> String
idToString (GenreId id) =
    String.fromInt id


type alias Genre =
    { id : GenreId
    , slug : String
    , name : String
    }


genreDecoder : Decoder Genre
genreDecoder =
    Decode.succeed Genre
        |> required "id" idDecoder
        |> required "slug" string
        |> required "name" string
