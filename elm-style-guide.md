# Elm Code Style Guide

A set of code style best practices used in Codex's Elm codebase. Inspired by the
[various style guides](#References) (Elm or otherwise). This is a living document
subject to additions and alterations over time!

Maintaining good style is a _constant_ effort. If you're working in a module that
breaks the style rules listed here, fix it. Don't kick the can down the road for
someone else (or future you).

---

## Contents

* [Formatting](#Formatting)
* [Functions](#Functions) 
  * [Composition & Piping](#Composition%20%26%20Piping)
* [Imports](#Imports)
* [Modules & Naming](#Modules%20%26%20Naming)
* [Tooling](#Tooling)

---

## Formatting

* Try and maintain a line length of <= 80. This isn't always possible so we're
  not religious about it, but overly long lines can get unruly fast.

  > In vscode I have gutters at 80, 100, and 120 columns. - Andy

* Prefer `case .. of` over `if`, it's easier to expand on if conditions change
  in the future and is apparently [more efficient](https://github.com/NoRedInk/elm-style-guide#use-caseof-over-if-where-possible).

* Always drop the function body on to a new line.

* Type annotate all top-level functions and constants.

## Functions

* Avoid point-free style in top-level functions; give arguments a name.

* Avoid single-letter arguments except in the most simple of cases.

  ```elm
  -- ❎ Bad
  add : a -> Index a -> ( ID, Index a )
  add a m =
    ...

  -- ✅ Good
  add : a -> Index a -> ( ID, Index a )
  add item index =
    ...

  -- OK
  addOne : Int -> Int
  addOne n =
    n + 1
  ```

* For multiple functions in a module, name arguments consistently when values are
  logically the same thing. In a module manipulating integer ids, don't use `int`
  in some functions and `id` in others.

  ```elm
  -- ❎ Bad
  insert : ID -> a -> Index a -> Index a
  insert (ID int) =
    ...

  get : ID -> Index a -> Maybe a
  get (ID id) =
    ...

  -- ✅ Good
  insert : ID -> a -> Index a -> Index a
  insert (ID id) =
    ...

  get : ID -> Index a -> Maybe a
  get (ID id) =
    ...
  ```

* If you find you need to add a type annotation to a `let` binding try and pull
  it out to the top-level scope.

* Avoid nesting control structures in any one function. Whenever we need to branch
  our code, consider if it should exist as its own "thing".

  For example, a nested `case ... of` suggests that we're really concerned about
  two separate things, and we can probably pull that nested case into its own
  function with a descriptive name.

  ### Composition & Piping

  * Prefer composition over anonymous functions except when trying to compose
    \>1-arity functions - don't try and be fancy. 

  * Always pipe-forward (this applies to composition too). One exception to this
    is when constructing HTML where it makes sense to maintain consistency by keeping
    the element first.

    ```elm
    -- ❎ Bad
    foo <| bar <| baz qux
      ...

    -- ✅ Good
    qux
      |> baz
      |> bar
      |> foo


    Html.div [ ... ]
      [ Html.p [ ... ]
        [ ... ]
      , Html.ul [ ... ]
        <| List.map viewListItem items
      ]
    ```

  * Start a pipe with the "raw" value.

    ```elm
    -- ❎ Bad
    foo qux
      |> bar
      |> baz
      ...

    -- ✅ Good
    qux
      |> foo
      |> bar
      |> baz
    ```

  * Prefer piping across multiple lines.

    Elm is already pretty vertical anyway. Dropping each pipe in a new line makes
    it easier to see how the value is transformed.

  * Prefer composition in a single line.

    Composition can quickly lead to a cryptic mess, this isn't Haskell. Preferring
    composition on a single line encourages us to keep things simple.

## Imports

* _Always_ prefer fully qualified imports. If you must alias an import, avoid
  single letter or abbreviated names such as `D` or `Attr`.

  ```elm
  -- ❎ Bad
  import Html.Attributes as Attr
  import Json.Decode as D

  -- ✅ Good
  import Html.Attributes

  -- OK
  import Json.Decode as Decode
  ```


* Avoid bringing functions and types into the global namespace in favour of using
  the qualified version. An exception to this rule is made for types that share 
  the same name as the module they live in.

  This rule is **especially** important for functions likely to be defined in
  multiple modules such as `map` or `foldl`. Always use the qualified version of
  these functions.

* Order imports alphabetically. Your editor should have a way to do this for you,
  for example in vscode you can open the command palette (<kbd>ctrl</kbd> + <kbd>shift
  </kbd> + <kbd>P</kbd>) and type "Sort Lines Ascending".

  Sorting alphabetically means sub-modules will always be grouped together, and
  makes it easier to quickly scan the list of imports to see what is included.

## Modules & Naming

* Name types and functions assuming they will always be prefixed with the module
  namespace. This produces a "literate" API and encourages using qualified imports.

  ```elm
  -- ❎ Bad
  module User exposing (UserId)

  type UserId = ...

  -- ✅ Good
  module User exposing (Id)

  type Id = ...
  ```

* Split module exports across multiple lines instead of a single long line listing
  all exports.

## Tooling

* Use [elm-format](https://www.npmjs.com/package/elm-format) before opening a
  PR. This style guide would be much longer without it!

* Try and satisfy [elm-analyse](https://stil4m.github.io/elm-analyse/#) before
  opening a PR. We have a custom configuration that suppresses some warnings that
  clash with this style guide.

---

## References

* The official Elm style guide: https://elm-lang.org/docs/style-guide
* NoRedInk/elm-style-guide: https://github.com/NoRedInk/elm-style-guide
* ohanhi/elm-style-guide: https://github.com/ohanhi/elm-style-guide
* Credo: https://hexdocs.pm/credo/overview.html
