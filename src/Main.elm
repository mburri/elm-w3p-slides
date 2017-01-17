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
    Section.fromList introduction


next : List Section
next =
    List.map Section.fromList
        [ introduction
        , problems
        , theElmWay
        , theElmPlatform
        , elmSyntax
        , theElmArchitecture
        , elmContactsApp
        , uncoveredStuff
        , summary
        ]


introduction : List String
introduction =
    [ """

![Puzzle ITC Logo](assets/puzzle_tagline_bg_rgb.svg)

W3P - Kafi

#Elm
A delightful language for reliable webapps.

Generate JavaScript with great performance and no runtime exceptions.

http://elm-lang.org/

"""
    , """ ##Agenda

* My Problems
* The Elm Way
* The Elm Platform
* Elm Syntax
* The Elm Architecture
* Angular2 Components vs. Elm-Modules
* Things I did not cover today
* Summary
"""
    ]


problems : List String
problems =
    [ """
##My Problems...

(I'm biased!)

"""
    , """
### Sequence Diagramm of an object-oriented enterprise architecure

![](assets/problems2.gif)

"""
    , """
### Side Effects

~~~java
    protected void storeData(HttpServletRequest request, Kursp010SessionData d) {
        getWorkflowContainer(request).setAttribute(KURSP010_DATA, d);
        request.setAttribute(KURSP010_DATA, d);
        d.setEmpty(false);
    }
~~~
(c) ndbjs

* ```getWorkflowContainer()``` from somewhere...
    * ... and modify it
* change an input parameter ```request```
* change input parameter ```d```

* where does the workflowcontainer come from?
* ```request``` and ```d``` might be null

"""
    , """
###Runtime Exceptions
![](assets/problems1.gif)

"""
    , """
### Runtime Exceptions

* Stacktraces from Hell...
* NPE

~~~javascript
undefined is not a function
~~~

"""
    , """
### Dynamic Types

(Sorry hupf)

~~~javascript
function add(a, b) {
    return a + b
}

add(1, 2)      // 3
add({}, [])    // ?
add(batman, robin)
~~~

"""
    , """
![](assets/batmanrobin.jpg)
"""
    , """
### Unit Tests to the rescue!(?)

Tests for:
* Arguments might be null, undefined
* Unexpected input (String instead of int...)
* Mocking objects and methods


* ... and finally test the application logic!

"""
    , """
### Javascript Fatigue

* Framework of the day...
* angular, angular2, angular5, ember, cyclejs, capuccino, mojito, ...
* NgRx, Ng2-redux, rxjs, redux, mobx, ...
* vue, react, ...
* immutable.js, ramda, lodash, underscore, ...
* grunt, gulp, bower, webpack, broccoly, artichocke, ...
* mocha, chai, jasmine, tape, QUnit...
* ...

"""
    , """
### Versioning in java and npm-land

* SemVer?
    * Sometimes...
    * see breaking changes in angular2 release candidates

=> Broken builds!

"""
    ]


theElmWay : List String
theElmWay =
    [ """
##The Elm Way

How does elm help with these problems?
"""
    , """
### Elm is a real Functional Language

* every function is pure
* every value is immutable
* side effects are handled by the runtime

=> Reliable Code that is easy to reason about
"""
    , """
### No Runtime Exceptions

* No ```null```
* No ```undefined is not a function```

* NoRedInk, 80'000 LOC in Prod, 0 Runtime Exceptions in 1 Year
"""
    , """
### The Compiler...

... is your friend, not your enemy!

* Friendly error messages
   * helps you add features more quickly
   * helps you refactor your code
"""
    , """
### It scales!

* Well-architected code that stays well-architected as your app grows
"""
    , """
### Enforced semver

Automatically enforced semantic versioning for all Elm packages
"""
    , """
### Software development is fun again!

Compiler + No Runtime Exceptions

= If it compiles, it works!
"""
    ]


theElmPlatform : List String
theElmPlatform =
    [ """ ## The Elm Platform

Getting started
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
    , """
### elm-make

* compiles elm to javascript, html, css
* helps you to write your app
* friendly error messages
* project setup
   * elm-package.json
   * elm-stuff/


~~~
elm-make          // generates elm-package.json

elm-make Main.elm // generates index.html with javascript

elm-make Main.elm --output app.js --debug // generates app.js, with debugger

~~~

"""
    , """
### elm-package

* package manager (installation and publishing)
* project setup
   * elm-package.json
   * elm-stuff/

~~~
elm-package install     // install packages from elm-package.json

elm-package install elm-lang/navigation

elm-package diff elm-lang/html 4.0.0 5.0.0
~~~

* enforces SemVer!
    * No breaking changes in patch or minor releases!
"""
    , """
### elm-repl

* try it out

"""
    , """
### elm-reactor

* local dev server
* quick start
* but no custom index.html (yet)
"""
    , """
### Try it online

http://elm-lang.org/examples/hello-html

"""
    ]


elmSyntax : List String
elmSyntax =
    [ """ ## Elm Syntax

(I skip most of this for now...)
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

> add 1.2 2.3
3.5 : Float

> reverseToUpper a = String.reverse(String.toUpper a)
<function> : String -> String

> reverseToUpper "max"
"XAM" : String

~~~
"""
    , """ ### Language basics - Lists

~~~elm
> names = "Jon" :: ["Robert", "Eddard"]
["Jon","Robert","Eddard"] : List String

> List.isEmpty names
False : Bool

> List.length names
3 : Int


> numbers = [3, 2, 1, 4]
[3, 2, 1, 4] : List number

> List.sort numbers
[1,2,3,4] : List number

> numbers
[3,2,1,4] : List number

List.map
<function> : (a -> b) -> List a -> List b

> List.map doubleMe numbers
[6,4,2,8] : List number

~~~
"""
    , """ ### Language basics - Records

~~~elm
> point = { x = 2, y = 3 }
{ x = 2, y = 3 } : { x : number, y : number }

> point.x
2 : number

> .y point
3 : number

> List.map .x [point, point, point]
[2,2,2] : List number

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

> List.filter
<function> : (a -> Bool) -> List a -> List a
~~~
"""
    , """ ### Pipes

~~~elm
> 1 |> add 2
3: number

String.reverse(String.toUpper("hello world"))
"DLROW OLLEH" : String

> "hello world" |> String.toUpper |> String.reverse
"DLROW OLLEH" : String
~~~

"""
    , """ ### Maybe and Results

~~~elm
> List.head
<function> : List a -> Maybe.Maybe a

> List.head []
Nothing : Maybe.Maybe a

> List.head [1, 2, 3, 4]
Just 1 : Maybe.Maybe number

> List.filter
<function> : (a -> Bool) -> List a -> List a

> String.toInt
<function:toInt> : String -> Result.Result String Int

> String.toInt "123"
Ok 123 : Result.Result String Int

> String.toInt "abc"
Err "could not convert string 'abc' to an Int" : Result.Result String Int
~~~
"""
    , """
### Pattern matching

~~~elm
case String.toInt userInput of
    Ok value ->
        { model | age = value }
    Err error ->
        { model | message = error }

~~~
"""
    , """ ### Language basics - why types are awesome

Es6

~~~javascript
const add = (x, y) => { return x + y }
add(1, 2)      // => 3

x = add(1)     // => ?

add(1, "2")    // => ?
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
    ]


theElmArchitecture : List String
theElmArchitecture =
    [ """ ## The Elm Architecture
    """
    , """ ### Elm-Architecture Overview
![](assets/handling-user-input_01.png)

[source](http://freecontent.manning.com/wp-content/uploads/handling-user-input_01.png)
"""
    , """ ### Elm-Architecture Overview
* Model
   * Define the shape of your state

* Update
   * Return a new state based on Msg and Model

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
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
~~~
    """
    , """ ### Counter App
"""
    , """ ### Counter App - Model
~~~elm
type alias Model =
    { count : Int
    }


init : Model
init =
    Model 0

~~~
"""
    , """ ### Counter App - Update
~~~elm
type Msg
    = Increment
    | Decrement

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

~~~
"""
    , """ ### Counter App - View
~~~elm
view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "counters" ]
        , button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        ]

~~~
"""
    , """ ### Counter App

* Demo

* Add a reset button

"""
    , """ ### Redux?

* Redux is a predictable state container for JavaScript apps.

"Redux evolves the ideas of Flux, but avoids its complexity by taking cues from Elm."

* The whole state of your app is stored in an object tree inside a single store.
* The only way to change the state tree is to emit an action, an object describing what happened.
* To specify how the actions transform the state tree, you write pure reducers.

https://github.com/reactjs/redux
        """
    , """ ### Counter App in React-Redux

https://github.com/reactjs/redux/tree/master/examples/counter

* Action        => Msg
* Reducers      => Update
* Store         => Model
* Components    => View
        """
    ]


elmContactsApp : List String
elmContactsApp =
    [ """ ##elm-contacts-app

Demo
    """
    , """
###NG2 Contacts-List Component

~~~javascript
import { Component, Input } from '@angular/core';
import { ContactModel } from './contact.model';

@Component({
  selector: 'contacts-list',
  template: `
    <table>
      <thead><tr><th>First name</th><th>Last name</th><th>Phone</th></tr></thead>
      <tbody>
        <tr *ngFor="let contact of contacts">
          <td><a [routerLink]="['/contacts', contact.id]">{{contact.first_name}}</a></td>
          <td><a [routerLink]="['/contacts', contact.id]">{{contact.last_name}}</a></td>
          <td><a [routerLink]="['/contacts', contact.id]">{{contact.phone}}</a></td>
        </tr>
      </tbody>
    </table>`
})
export class ContactsListComponent {
  @Input() contacts: ContactModel[];
}

~~~
    """
    , """
###Elm Contacts-List

~~~elm
module View.ContactsList exposing (view)

import Html exposing (Html, table, tbody, tr, td, text)
import Html.Attributes exposing (value, class, type_)
import Html.Events exposing (onClick, onInput)
import Model.Contact exposing (Contact)
import Update.Messages exposing (..)

view : List Contact -> Html Msg
view contacts =
    table []
        [ tbody []
            (List.map viewContact contacts)
        ]


viewContact : Contact -> Html Msg
viewContact contact =
    tr [ onClick <| Select contact ]
        [ td []
            [ text contact.firstname ]
        , td []
            [ text contact.lastname ]
        , td []
            [ text contact.phone ]
        ]
~~~
    """
    , """ ###elm-contacts-app

* Do not think in Components!
* ... but in functions
    """
    , """ ###yagni

* You ain't gonna need it!

    """
    , """
###Keep it simple

* Start with
   * One ```Model```
   * One ```Msg``` type
   * One ```update``` function
   * One ```view``` function
"""
      {--, """
### Refactor when things get too big

* Refactoring is easy and save in elm (thanks to the compiler and pure, immutable functions)
"""
    , """
### When ```view``` gets too big

* ```view``` is the first one to get really big
* Split out functions, e.g:

~~~elm
viewContactList: List Contact -> Html Msg
viewContactList contacts =
    ...
~~~
"""
    , """
### When ```Model``` gets too big

* Split the Record into smaller records
~~~elm
type alias Model =
    { firstname: String
    , lastName: String
    , phone: String
    }
~~~

becomes...

~~~elm
type alias Contact =
    { firstname: String
    , lastName: String
    , phone: String
    }

type alias Model =
    { selectedContact: Contact}
~~~
"""
    , """
### When ```update``` gets too big

* Use helper functions
"""--}
    , """
### When everything gets too big

* It's probably no problem!
* Elm is great at finding problems and making refactors easy
"""
    ]


uncoveredStuff : List String
uncoveredStuff =
    [ """
##Things I did not cover today """
    , """
### Performance

* Elm uses Virtual Dom to diff the view
* Seems to outperform React, Angular2 and Ember
http://elm-lang.org/blog/blazing-fast-html-round-two

    """
    , """
### Ports

* Talk to Javascript, not add Javascript Code in the middle of Elm
* Elm guarantees (no Runtime Exception in Elm) still holds up
* Javascript-as-a-Service


"""
    , """
### Make impossible State impossible

~~~elm
type alias Section =
    { allSlides: List Slide
    , current: Maybe Slide
    -- , currentIndex: Int
    }
~~~

* current slide may not be in the list of all slides!

~~~elm
type alias Section =
    { previous: List Slide
    , current: Slide
    , next: List Slide}
~~~

* not exclusive to elm!
* more boilerplate code, but more reliable and maintainable
* Less unit tests

    """
    , """
###Unit Tests

* [elm-community/elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
* Fuzz Tests included!
"""
    ]


summary : List String
summary =
    [ """
## Summary ... my Experience with Elm

(Disclaimer: I'm not an expert!)
    """
    , """
### It's confusing - sometimes

* Json Decoders (turn Json into Elm Data)
* Documentation (Package Docs)
* It's different (Syntax, Thinking)
* Changes from elm 0.17 to elm 0.18


"""
    , """
### It's a great Experience...

* Great Guide http://guide.elm-lang.org
* New Concepts
* Makes you a better programmer
* Helps to understand and learn Angular2, React-Redux Codebases
* It's fun!

"""
    , """
### but...

* Switching back to (Legacy) Java and Javascript (even Typescript) is...

![](assets/omg.jpg)
"""
    ]
