module Section exposing (Section, view, previousSlide, nextSlide)

import Slide exposing (Slide)
import Html exposing (Html)


type alias Section =
    { previous : List Slide
    , current : Slide
    , next : List Slide
    }


nextSlide : Section -> Section
nextSlide section =
    case List.head section.next of
        Just slide ->
            { section
                | previous = [ section.current ] ++ section.previous
                , current = slide
                , next = Maybe.withDefault [] (List.tail section.next)
            }

        Nothing ->
            section


previousSlide : Section -> Section
previousSlide section =
    case List.head section.previous of
        Just slide ->
            { section
                | previous = Maybe.withDefault [] (List.tail section.previous)
                , current = slide
                , next = [ section.current ] ++ section.next
            }

        Nothing ->
            section


view : Section -> Html msg
view section =
    Slide.view section.current
