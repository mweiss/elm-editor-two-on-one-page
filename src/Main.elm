module Main exposing (..)

import Browser
import Controls exposing (EditorMsg(..))
import Editor
import FontAwesome.Styles
import Html exposing (Html, a, h1, p, text)
import Html.Attributes exposing (href, title)
import Json.Decode exposing (Value)
import Links exposing (rteToolkit)
import RichText.Definitions as Specs
import RichText.Editor as RTE
import Session exposing (Session)


import Html exposing (..)
import Session exposing (Session(..))


type alias Model =
    { editor1 : Editor.Model
    , editor2 : Editor.Model
    }


type Msg
    = EditorMsg1 Editor.EditorMsg
    | EditorMsg2 Editor.EditorMsg


config =
    RTE.config
        { decorations = Editor.decorations
        , commandMap = Editor.commandBindings Specs.markdown
        , spec = Specs.markdown
        , toMsg = InternalMsg
        }


fontAwesomeStyle : Html msg
fontAwesomeStyle =
    -- Fix to Issue #20:
    -- Wrap font awesome styles in a div because of dangerous extensions: https://discourse.elm-lang.org/t/runtime-errors-caused-by-chrome-extensions/
    Html.div []
        [ FontAwesome.Styles.css ]

view : Model -> (Html Msg)
view model =
    div []
        (fontAwesomeStyle ::
        [ p []
            [ text """Here's a quick demo of two editors on the same page"""
            ]
        , h2 [] [text "Editor 1"]
        , Html.map EditorMsg1 (Editor.view config model.editor1)
        , h2 [] [text "Editor 2"]
        , Html.map EditorMsg2 (Editor.view config model.editor2)
        ])


init : Value -> ( Model, Cmd Msg )
init _ =
    ( { editor1 = Editor.init Editor.initialState
      , editor2 = Editor.init Editor.initialState
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditorMsg1 editorMsg ->
            let
                ( e, _ ) =
                    Editor.update config editorMsg model.editor1
            in
            ( { model | editor1 = e }, Cmd.none )
        EditorMsg2 editorMsg ->
            let
                ( e, _ ) =
                    Editor.update config editorMsg model.editor2
            in
            ( { model | editor2 = e }, Cmd.none )



subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none


main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
