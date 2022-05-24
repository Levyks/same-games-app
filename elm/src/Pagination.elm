module Pagination exposing (Pagination, paginationDecoder)

import Json.Decode as Decode exposing (Decoder, int, list, nullable, string)
import Json.Decode.Pipeline exposing (required)


type alias Pagination a =
    { results : List a
    , count : Int
    , next : Maybe String
    , previous : Maybe String
    }


paginationDecoder : Decoder a -> Decoder (Pagination a)
paginationDecoder decoder =
    Decode.succeed Pagination
        |> required "results" (list decoder)
        |> required "count" int
        |> required "next" (nullable string)
        |> required "previous" (nullable string)
