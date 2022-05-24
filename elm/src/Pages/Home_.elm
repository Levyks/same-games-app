module Pages.Home_ exposing (Model, Msg, page)

import Css exposing (Style, height, property, px, width)
import Game exposing (BasicListGame, basicListGameDecoder)
import Gen.Params.Home_ exposing (Params)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (alt, class, css, disabled, placeholder, src, type_, value)
import Html.Styled.Events exposing (onClick, onInput)
import Http exposing (Error)
import HttpHelper exposing (apiEndpoint, getErrorMessage)
import Maybe.Extra
import Page
import Pagination exposing (Pagination, paginationDecoder)
import RemoteData exposing (RemoteData(..), WebData)
import Request
import Shared
import UI exposing (centerColumn, spinner)
import Util exposing (delay)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page _ _ =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { pageData : WebData (Pagination BasicListGame)
    , favorites : List BasicListGame
    , search : String
    , pageNumber : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { pageData = RemoteData.Loading
      , favorites = []
      , search = ""
      , pageNumber = 1
      }
    , fetchGames 1 ""
    )



-- UPDATE


type Msg
    = RetryFetchGames
    | FetchNextPage
    | FetchPreviousPage
    | GamesReceived (WebData (Pagination BasicListGame))
    | AddToFavorites BasicListGame
    | RemoveFromFavorites BasicListGame
    | SearchInput String
    | DelayedSearchInput String


fetchGames : Int -> String -> Cmd Msg
fetchGames pageNumber search =
    Http.get
        { url = apiEndpoint "/games" [ ( "page", String.fromInt pageNumber ), ( "search", search ), ( "page_size", String.fromInt 15 ) ]
        , expect = Http.expectJson (RemoteData.fromResult >> GamesReceived) (paginationDecoder basicListGameDecoder)
        }


scheduleDelayedSearchInput : String -> Cmd Msg
scheduleDelayedSearchInput search =
    delay 750 (DelayedSearchInput search)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetryFetchGames ->
            ( { model | pageData = RemoteData.Loading }, fetchGames model.pageNumber model.search )

        FetchNextPage ->
            ( { model | pageData = RemoteData.Loading, pageNumber = model.pageNumber + 1 }
            , fetchGames (model.pageNumber + 1) model.search
            )

        FetchPreviousPage ->
            ( { model | pageData = RemoteData.Loading, pageNumber = model.pageNumber - 1 }
            , fetchGames (model.pageNumber - 1) model.search
            )

        GamesReceived response ->
            ( { model | pageData = response }
            , Cmd.none
            )

        AddToFavorites game ->
            ( { model | favorites = model.favorites ++ [ game ] }
            , Cmd.none
            )

        RemoveFromFavorites game ->
            ( { model | favorites = List.filter (\g -> g.id /= game.id) model.favorites }
            , Cmd.none
            )

        SearchInput search ->
            ( { model | search = search }, scheduleDelayedSearchInput search )

        DelayedSearchInput debouncedSearch ->
            if debouncedSearch == model.search then
                ( { model | pageData = RemoteData.Loading, search = debouncedSearch }
                , fetchGames 1 model.search
                )

            else
                ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


viewLoading : Html Msg
viewLoading =
    centerColumn "flex-grow-1" [ spinner 8 1.5 ]


viewError : Error -> Html Msg
viewError err =
    centerColumn "flex-grow-1"
        [ span [ class "text-danger mb-3" ]
            [ text ("Error -> " ++ getErrorMessage err)
            ]
        , button [ class "btn btn-primary", onClick RetryFetchGames ]
            [ text "Retry"
            ]
        ]


viewGameImage : BasicListGame -> String -> List Style -> Html Msg
viewGameImage game classes style =
    case game.background_image of
        Just image ->
            img
                [ src image
                , class classes
                , alt ("Cover of " ++ game.name)
                , css style
                ]
                []

        Nothing ->
            text ""


viewGame : List BasicListGame -> BasicListGame -> Html Msg
viewGame favorites game =
    div [ class "card" ]
        [ viewGameImage game
            "card-img-top"
            [ property "aspect-ratio" "16/9"
            , property "object-fit" "cover"
            ]
        , div [ class "card-body d-flex flex-column" ]
            [ h5 [ class "card-title" ]
                [ text game.name ]
            , h6
                [ class "card-subtitle mb-2 text-muted flex-grow-1" ]
                [ text (String.join "/" (List.map (\genre -> genre.name) game.genres))
                ]
            , case game.released of
                Just released ->
                    p [ class "card-text text-muted text-end" ] [ text ("From " ++ String.fromInt released.year) ]

                Nothing ->
                    text ""
            , button
                [ class "btn btn-primary"
                , disabled (List.member game favorites)
                , onClick (AddToFavorites game)
                ]
                [ text "Add to favorites"
                ]
            ]
        ]


viewSearch : String -> Html Msg
viewSearch search =
    input
        [ type_ "text"
        , class "form-control mb-3"
        , placeholder "Search"
        , value search
        , onInput SearchInput
        ]
        []


viewGames : List BasicListGame -> List BasicListGame -> Html Msg
viewGames favorites games =
    div
        [ class "mb-3"
        , css
            [ property "display" "grid"
            , property "grid-gap" "1rem"
            , property "grid-template-columns" "repeat(auto-fill, minmax(250px, 1fr))"
            ]
        ]
        (List.map
            (viewGame favorites)
            games
        )


viewPageBtns : Pagination a -> Int -> Html Msg
viewPageBtns pageData pageNumber =
    div [ class "d-flex justify-content-center align-items-center mb-3" ]
        [ button
            [ class "btn btn-primary"
            , disabled (Maybe.Extra.isNothing pageData.previous)
            , onClick FetchPreviousPage
            ]
            [ text "Previous" ]
        , strong [ class "mx-2" ]
            [ text ("Page " ++ String.fromInt pageNumber) ]
        , button
            [ class "btn btn-primary"
            , disabled (Maybe.Extra.isNothing pageData.next)
            , onClick FetchNextPage
            ]
            [ text "Next" ]
        ]


viewGamesList : Model -> List (Html Msg)
viewGamesList model =
    h1 [ class "text-center my-3" ] [ text "Games" ]
        :: (case model.pageData of
                NotAsked ->
                    [ text "" ]

                Loading ->
                    [ viewLoading ]

                Failure err ->
                    [ viewError err ]

                Success data ->
                    [ viewSearch model.search
                    , viewGames model.favorites data.results
                    , viewPageBtns data model.pageNumber
                    ]
           )


viewFavorite : BasicListGame -> Html Msg
viewFavorite game =
    li [ class "list-group-item d-flex align-items-center" ]
        [ viewGameImage game
            ""
            [ width (px 64)
            , height (px 64)
            , property "object-fit" "cover"
            ]
        , span [ class "ms-2 flex-grow-1" ] [ text game.name ]
        , button [ class "btn btn-close", onClick (RemoveFromFavorites game) ] []
        ]


viewFavorites : Model -> List (Html Msg)
viewFavorites model =
    [ h2 [ class "text-center mt-4 mb-3" ] [ text "Favorites" ]
    , ul [ class "list-group" ]
        (List.map viewFavorite model.favorites
            ++ (if List.isEmpty model.favorites then
                    [ li [ class "list-group-item" ] [ text "No games favorited yet" ] ]

                else
                    []
               )
        )
    ]


view : Model -> View Msg
view model =
    { title = "same-games-app | Elm"
    , body =
        [ div [ class "container h-100" ]
            [ div
                [ class "row h-100"
                ]
                [ div
                    [ class "col-12 col-md-8 d-flex flex-column"
                    ]
                    (viewGamesList model)
                , div
                    [ class "col-12 col-md-3"
                    ]
                    (viewFavorites model)
                ]
            ]
        ]
    }
