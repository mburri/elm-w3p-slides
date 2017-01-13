module Key exposing (Key(..), fromCode)


type Key
    = ArrowLeft
    | ArrowRight
    | ArrowUp
    | ArrowDown
    | Unknown


fromCode : Int -> Key
fromCode keyCode =
    case keyCode of
        37 ->
            ArrowLeft

        38 ->
            ArrowUp

        39 ->
            ArrowRight

        40 ->
            ArrowDown

        _ ->
            Unknown
