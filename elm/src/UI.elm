module UI exposing (centerColumn, spinner)

import Css exposing (fontSize, height, rem, width)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (attribute, class, css)


centerColumn : String -> List (Html msg) -> Html msg
centerColumn extraClass content =
    div [ class ("d-flex flex-column justify-content-center align-items-center " ++ extraClass) ] content


spinner : Float -> Float -> Html msg
spinner size strokeWidth =
    div
        [ class "spinner-border"
        , attribute "role" "status"
        , css
            [ width (rem size)
            , height (rem size)
            , fontSize (rem strokeWidth)
            ]
        ]
        [ span [ class "visually-hidden" ] [ text "Loading..." ]
        ]
