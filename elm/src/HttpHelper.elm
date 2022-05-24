module HttpHelper exposing (apiEndpoint, getErrorMessage)

import Http exposing (Error(..))


apiUrl : String
apiUrl =
    "https://api.rawg.io/api"



-- This key is supposed to be public, don't worry about it


apiKey : String
apiKey =
    "95e8c863516c40beb2f474e2a9206a2d"


getQueryString : List ( String, String ) -> String
getQueryString params =
    List.foldl (\( key, value ) acc -> acc ++ "&" ++ key ++ "=" ++ value) "" params


apiEndpoint : String -> List ( String, String ) -> String
apiEndpoint path params =
    apiUrl ++ path ++ "?key=" ++ apiKey ++ getQueryString params


getErrorMessage : Error -> String
getErrorMessage err =
    case err of
        BadUrl url ->
            "Bad URL: " ++ url

        Timeout ->
            "Timeout"

        NetworkError ->
            "Network error"

        BadStatus status ->
            "Bad status: " ++ String.fromInt status

        BadBody message ->
            "Bad body: " ++ message
