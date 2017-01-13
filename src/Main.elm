module Main exposing (..)

import Html exposing (Html)
import Presentation exposing (Model, init, update, subscriptions, view, create)
import Section exposing (Section, empty)
import Json.Decode


main =
    Html.program
        { init = ( initPresentation, Cmd.none )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


initPresentation : Model
initPresentation =
    create current next


current : Section
current =
    Section.fromList titleSection


next : List Section
next =
    List.map Section.fromList
        [ introduction
        , whatIsElm
        , whyElm
        , theElmPlatform
        , elmByExample
        , reduxComparison
        , elmContactsApp
        ]


titleSection : List String
titleSection =
    [ """ ![Puzzle ITC Logo](assets/puzzle_tagline_bg_rgb.svg) """ ]


introduction : List String
introduction =
    [ """ W3P - Kafi

#Elm
A delightful language for reliable webapps.

Generate JavaScript with great performance and no runtime exceptions.

http://elm-lang.org/

"""
    , """ ##Agenda

* What is Elm?
* Why Elm?
* The Elm Platform
* The Elm Architecture
* Redux and The Elm Architecture
* Angular2 Components vs. Elm-Modules
* Summary
"""
    ]


whatIsElm : List String
whatIsElm =
    [ """ ## What is Elm?

Elm is a *functional programming language* that *compiles* to JavaScript and *runs in the browser*

"""
    , """ ### Why is it awesome?

* functional (pure, immutable)
* strongly typed (with type inference)
* awesome compiler
* debugger included
* enforced semantic versioning for packages
"""
    , """ ### Is it fast enough?

* yes
* http://elm-lang.org/blog/blazing-fast-html-round-two
"""
    ]


whyElm : List String
whyElm =
    [ """ ## Why Elm? """
    , """ ### Undefined ...

... is not a function
"""
    , """ ### Main Problems in Software Development

* Maintainability
* Reliability
"""
    , """ ### Maintanability vs. Ease of Use

![](assets/maintanable-usable-1.png)
"""
    , """ ### Maintainability vs. Ease of Use

![](assets/maintanable-usable-2.png)
"""
    , """ ### Maintainability vs. Ease of Use

![](assets/maintanable-usable-3.png)
"""
    ]


theElmPlatform : List String
theElmPlatform =
    [ """ ## The Elm Platform
"""
    , """ ### Installation

~~~
npm install -g elm
~~~
"""
    , """ ### cli tools

* elm-make
* elm-package
* elm-reactor
* elm-repl
"""
    , """ ### Notable Community Tool

* elm-format
* elm-upgrade (0.17 -> 0.18)
* elm-live (flexible dev server with live reloading)
"""
    ]


elmByExample : List String
elmByExample =
    [ """ ## Elm by Example

* Language basics
* Hello World
* Hello Elm Architecture
    """
    , """ ### Language basics - values

~~~elm
> x = 1
1 : number

> x = 1.1
1.1 : Float

> x = "hello world"
"hello world" : String

> x = [1, 2, 3, 4]
[1,2,3,4] : List number

> x = ["a", "b", "c"]
["a","b","c"] : List String

> point = { x = 2, y = 3 }
{ x = 2, y = 3 } : { x : number, y : number1 }

> x = True
True : Bool

> 1 == 1
True : Bool
~~~
    """
    , """ ### Language basics - Functions

~~~elm
> add a b = a + b
<function> : number -> number -> number

> add 1 2
3 : number

> doubleMe n = n * 2
<function> : number -> number

> doubleMe 3
6 : number


~~~
"""
    , """ ### Language basics - Lists

~~~elm
> names = ["Jon", "Robert", "Eddard"]
["Jon","Robert","Eddard"] : List String

> List.isEmpty names
False : Bool

> List.length names
3 : Int

> List.head names
Just "Jon" : Maybe.Maybe String

> numbers = [1, 2, 3, 4]
[1,2,3,4] : List number

> List.sort numbers
[1,2,3,4] : List number

> List.map doubleMe numbers
[2,4,6,8] : List number

~~~
"""
    , """ ### Language basics - Records

~~~elm
> point = { x = 2, y = 3 }
{ x = 2, y = 3 } : { x : number, y : number1 }

> point.x
2 : number

> .y point
3 : number

> List.map .x [point, point, point]
[2,2,2] : List number

~~~
"""
    , """ ### Language basics - Tuples

~~~elm
> validate name =
      if name == "Jon" then
          (True, "name is jon")
      else
          (False, "error on validating name")

> validate "Jon"
(True,"name is jon") : ( Bool, String )

> validate "Robert"
(False,"error on validating name") : ( Bool, String )

~~~
"""
    , """ ### Language basics - Types

~~~elm
> type alias Point = { x: Int, y: Int }
> Point
<function> : Int -> Int -> Point

> type Shape = Dot Point | Line Point Point

> Dot
<function> : Point -> Shape

> Line
<function> : Point -> Point -> Shape

> point1 = Point 3 4
{ x = 3, y = 4 } : Point

> point2 = Point 5 2
{ x = 5, y = 2 } : Point

> dot = Dot point1
Dot { x = 3, y = 4 } : Shape

> line = Line point2 point
Line { x = 5, y = 2 } { x = 3, y = 4 } : Shape

> line
Line { x = 5, y = 2 } { x = 3, y = 4 } : Shape

~~~
"""
    , """ ### Language basics - If Expressions

~~~elm
> isOver9000 score = if score > 9000 then "yes" else "sorry..."
<function> : number -> String

> isOver9000 100
"sorry..." : String

> isOver9000 100000
"yes" : String
~~~

* else branch is not optional!
"""
    , """ ### Language basics - Loops

* Sorry, no loops in Elm!
"""
    , """ ### Language basics - why types are awesome

Es6

~~~javascript
const add = (x, y) => { return x + y }
add(1, 2)      // => 3

add(1, "2")    // => ?

x = add(1)     // => ?
~~~

Elm

~~~elm
> add a b = a + b
<function> : number -> number -> number

> add 1 2
3 : number

> add 1
<function> : number -> number

> add 1 "2"
???
~~~
"""
    , """ ### Compiler - Useful error messages

~~~elm
> add a b = a + b
<function> : number -> number -> number

> add 1 "2"

-- TYPE MISMATCH --------------------------------------------- repl-temp-000.elm

The 2nd argument to function `add` is causing a mismatch.

4|   add 1 "2"
           ^^^
Function `add` is expecting the 2nd argument to be:

    number

But it is:

    String

Hint: I always figure out the type of arguments from left to right. If an
argument is acceptable when I check it, I assume it is "correct" in subsequent
checks. So the problem may actually be in how previous arguments interact with
the 2nd.
~~~
"""
    , """ ### Hello World - adding numbers!

~~~elm
import Html exposing (text)

add: Int -> Int -> Int
add a b =
    a + b


x: Int
x =
    add 1 2

main: Html Msg
main =
  text (toString x)

~~~
"""
    ]


theElmArchitecture : List String
theElmArchitecture =
    [ """ ## The Elm Architecture
    """
    , """ ### Elm-Architecture Overview

"Framework" baked into to language - no package - no fatigue!

* Model
   * Define the shape of your state
* Update
   * Return a new state
* View
   * Turn your model into Html
    """
    , """ ### Elm-Architecture Skeleton

~~~elm

-- Model

type alias Model = ...

init: Model
init =
    ...



-- Update

type Msg = ...

update: Msg -> Model -> Model
update msg model =
    ...


-- View

view: Model -> Html Msg
view model =
    ...

~~~
"""
    , """ ### Pass it to the runtime

~~~elm
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
~~~
    """
    , """ ### Elm-Architecture - Counter App

Demo

* time travel debugger included!

"""
    , """ ### Counter App - Source Code

Things to notice:

* elm-format
* Msg is a union type
* update must cover all possible messages
* no special syntax for the view
* easy (and save) to add new features (reset)
   * trust the compiler
"""
    ]


reduxComparison : List String
reduxComparison =
    [ """ ## Redux

"Redux evolves the ideas of Flux, but avoids its complexity by taking cues from Elm."

https://github.com/reactjs/redux
        """
    , """ ### Counter App in React-Redux

https://github.com/reactjs/redux/blob/master/examples/counter-vanilla/index.html

* Actions + Constants => Msg
* Reducers  => update + Model
* Containers => View
        """
    ]


elmContactsApp : List String
elmContactsApp =
    [ """ ##elm-contacts-app
    """
    , """ ##elm-contacts-app

No Components!
    """
    ]


template : List String
template =
    [ """
    """
    , """
    """
    ]
