module Presentation exposing (Model, init, update, view, subscriptions)

import Html exposing (Html, text)
import Html.Attributes exposing (class)
import Key exposing (Key(..), fromCode)
import Keyboard exposing (KeyCode)
import Markdown
import Slide exposing (Slide)
import Section exposing (Section)


type alias Model =
    { previousSections : List Section
    , currentSection : Section
    , nextSections : List Section
    }


init : Model
init =
    let
        start =
            Section [] titleSlide []

        section1 =
            Section [] whatIsElm []

        section2 =
            Section [] slide2 [ slide3 ]
    in
        { previousSections = []
        , currentSection = start
        , nextSections = [ section1, section2 ]
        }


type Msg
    = KeyDown KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown keyCode ->
            ( handleKeyDown keyCode model, Cmd.none )


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


titleSlide : Slide
titleSlide =
    Slide.withContent
        """
![Puzzle ITC Logo](assets/puzzle_tagline_bg_rgb.svg)


## W3P Kafi - Elm
"""


whatIsElm : Slide
whatIsElm =
    Slide.withContent """
#Elm
A delightful language for reliable webapps.

Generate JavaScript with great performance and no runtime exceptions.

http://elm-lang.org/



"""


slide2 : Slide
slide2 =
    Slide.withContent """

# Second slide

  1. do soem elm

   ![](assets/maintanable-usable-1.png)
"""


slide3 : Slide
slide3 =
    Slide.withContent """

# Third slide

  it was really easy...

      ~~~elm
        add: Int -> Int -> Int
        add x y = x + y
      ~~~
"""
