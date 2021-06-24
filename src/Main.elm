module Main exposing (main)

import Browser
import Browser.Dom exposing (Element)
import Browser.Navigation
import Element exposing (Element)
import Element.Background
import Element.Font
import Html exposing (Html)
import Url exposing (Url)


type alias Flags =
    ()


type alias Model =
    ()


type alias Msg =
    ()


{-| Use Browser.application so we don't have to write any JS
-}
main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( (), Cmd.none )


onUrlChange : Url -> Msg
onUrlChange _ =
    ()


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest _ =
    ()


view : Model -> Browser.Document Msg
view model =
    { title = "Is Elm Dead Yet?"
    , body = [ Element.layout [] <| viewBody model ]
    }


viewBody : Model -> Element Msg
viewBody _ =
    Element.column
        [ Element.width Element.fill
        , Element.height Element.fill
        , Element.Background.color (Element.rgb255 108 227 199)
        ]
        [ Element.el
            [ Element.centerX
            , Element.centerY
            , Element.Font.color (Element.rgb255 25 25 25)
            , Element.Font.size 150
            , Element.padding 30
            ]
            (Element.text "NO!")
        , Element.newTabLink
            [ Element.centerX
            , Element.Font.color (Element.rgb255 25 25 25)
            , Element.Font.size 20
            , Element.padding 10
            , Element.Font.underline
            ]
            { url = "https://elmlang.slack.com/archives/C0LUAGWRK"
            , label = Element.text "Here are some Elm jobs"
            }
        , Element.newTabLink
            [ Element.centerX
            , Element.Font.color (Element.rgb255 25 25 25)
            , Element.Font.size 20
            , Element.padding 10
            , Element.Font.underline
            ]
            { url = "https://github.com/jah2488/elm-companies"
            , label = Element.text "Here are some companies that use Elm in production"
            }
        , Element.newTabLink
            [ Element.centerX
            , Element.Font.color (Element.rgb255 60 60 60)
            , Element.Font.size 15
            , Element.padding 20
            , Element.Font.underline
            ]
            { url = "https://github.com/jwbrew/is-elm-dead-yet"
            , label = Element.text "Have something to say on the matter? Contributions encouraged."
            }
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
