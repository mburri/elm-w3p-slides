module Presentation exposing (Model, init, update, view, subscriptions, create)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Key exposing (Key(..), fromCode)
import Keyboard exposing (KeyCode)
import Markdown
import Slide exposing (Slide)
import Section exposing (Section)
import Http
import HttpBuilder
import Debug
import Json.Decode as Decode


type alias Model =
    { previousSections : List Section
    , currentSection : Section
    , nextSections : List Section
    }


init : Model
init =
    { previousSections = []
    , currentSection = Section.empty
    , nextSections = []
    }


create : Section -> List Section -> Model
create current next =
    { previousSections = []
    , currentSection = current
    , nextSections = next
    }


type Msg
    = KeyDown KeyCode
    | NewPresentation (List (List String))
    | GetPresentationFailed Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown keyCode ->
            ( handleKeyDown keyCode model, Cmd.none )

        NewPresentation content ->
            ( fromContent content, Cmd.none )

        GetPresentationFailed error ->
            let
                _ =
                    Debug.log "uups" error
            in
                ( model, Cmd.none )


fromContent : List (List String) -> Model
fromContent content =
    { previousSections = []
    , currentSection =
        List.head content
            |> Maybe.withDefault []
            |> Section.fromList
    , nextSections =
        List.tail content
            |> Maybe.withDefault []
            |> nextSectionsFromList
    }


nextSectionsFromList : List (List String) -> List Section
nextSectionsFromList sections =
    List.map Section.fromList sections


handleKeyDown : KeyCode -> Model -> Model
handleKeyDown keyCode model =
    case fromCode keyCode of
        ArrowRight ->
            next model

        ArrowLeft ->
            previous model

        ArrowUp ->
            { model | currentSection = Section.previousSlide model.currentSection }

        ArrowDown ->
            { model | currentSection = Section.nextSlide model.currentSection }

        _ ->
            model


next : Model -> Model
next model =
    case List.head model.nextSections of
        Just section ->
            { model
                | previousSections = [ model.currentSection ] ++ model.previousSections
                , currentSection = section
                , nextSections = Maybe.withDefault [] (List.tail model.nextSections)
            }

        Nothing ->
            model


previous : Model -> Model
previous model =
    case List.head model.previousSections of
        Just section ->
            { model
                | previousSections = Maybe.withDefault [] (List.tail model.previousSections)
                , currentSection = section
                , nextSections = [ model.currentSection ] ++ model.nextSections
            }

        Nothing ->
            model


view : Model -> Html Msg
view model =
    Section.view model.currentSection


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Keyboard.downs KeyDown ]



{--getJson : Cmd Msg
getJson =
    let
        url =
            "slides/presentation.json"
    in
        HttpBuilder.get url
            |> HttpBuilder.withExpect (Http.expectJson decodePresentation)
            |> HttpBuilder.send handleGetPresentationComplete


handleGetPresentationComplete : Result Http.Error (List (List String)) -> Msg
handleGetPresentationComplete result =
    case result of
        Ok presentation ->
            NewPresentation presentation

        Err error ->
            GetPresentationFailed error


decodePresentation : Decode.Decoder (List (List String))
decodePresentation =
    Decode.list decodeSections


decodeSections : Decode.Decoder (List String)
decodeSections =
    Decode.list decodeSlide


decodeSlide : Decode.Decoder String
decodeSlide =
    Decode.string
--}
