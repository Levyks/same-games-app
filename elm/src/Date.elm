module Date exposing (..)

import Json.Decode as Decode exposing (Decoder)


type alias Date =
    { year : Int
    , month : Int
    , day : Int
    }


dateDecoder : Decoder Date
dateDecoder =
    Decode.string
        |> Decode.andThen
            (\date ->
                case String.split "-" date |> List.map String.toInt of
                    [ Just year, Just month, Just day ] ->
                        Decode.succeed (Date year month day)

                    _ ->
                        Decode.fail "Not a yyyy-MM-dd date"
            )
