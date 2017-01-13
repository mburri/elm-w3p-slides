module Slide exposing (Slide(..), empty, withContent, view)

import Markdown exposing (defaultOptions)
import Html exposing (Html, div)
import Html.Attributes exposing (class)


type Slide
    = Slide { content : String }


options =
    { defaultOptions | smartypants = False }


empty : Slide
empty =
    Slide { content = "" }


withContent : String -> Slide
withContent content =
    Slide { content = content }


view : Slide -> Html msg
view (Slide { content }) =
    div [ class "slide" ]
        [ Markdown.toHtmlWith options [ class "slide center" ] content
        ]
