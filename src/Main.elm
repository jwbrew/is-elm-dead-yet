module Main exposing (main)

import Browser
import Browser.Navigation
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
view _ =
    { title = "Is Elm Dead Yet?", body = [ Html.text "NO" ] }


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
