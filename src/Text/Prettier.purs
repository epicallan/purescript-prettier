module Text.Prettier (
  TrailingComma(..),
  Parser(..),
  Options,
  defaultOptions,
  format,
  check,
  formatWithCursor,
  formatImpl,
  checkImpl
) where

import Prelude
import Data.Maybe (Maybe(..), maybe)

data TrailingComma
  = None
  | Es5
  | All

data Parser
  = Babylon
  | Flow
  | TypeScript
  | CSS
  | LESS
  | SCSS
  | MarkDown
  | JSON
  | GraphQL

type Options = {
  printWidth :: Int,
  tabWidth :: Int,
  useTabs :: Boolean,
  semi :: Boolean,
  singleQuote :: Boolean,
  trailingComma :: TrailingComma,
  bracketSpacing :: Boolean,
  jsxBracketSameLine :: Boolean,
  rangeStart :: Int,
  rangeEnd :: Maybe Int,
  parser :: Parser
}

defaultOptions :: Options
defaultOptions = {
  printWidth: 80,
  tabWidth: 2,
  useTabs: false,
  semi: true,
  singleQuote: false,
  trailingComma: None,
  bracketSpacing: true,
  jsxBracketSameLine: false,
  rangeStart: 0,
  rangeEnd: Nothing,
  parser: Babylon
}

fromTrailingComma :: TrailingComma -> String
fromTrailingComma None = "none"
fromTrailingComma Es5 = "es5"
fromTrailingComma All = "all"

foreign import infinity :: Int

fromRangeEnd :: Maybe Int -> Int
fromRangeEnd = maybe infinity identity

fromParser :: Parser -> String
fromParser Babylon = "babylon"
fromParser Flow = "flow"
fromParser TypeScript = "typescript"
fromParser CSS = "css"
fromParser LESS = "less"
fromParser SCSS = "scss"
fromParser JSON = "json"
fromParser MarkDown = "markdown"
fromParser GraphQL = "graphql"

foreign import formatImpl :: (TrailingComma -> String) -> (Maybe Int -> Int) -> (Parser -> String) -> Options -> String -> String

format :: Options -> String -> String
format options source = formatImpl fromTrailingComma fromRangeEnd fromParser options source

foreign import checkImpl :: (TrailingComma -> String) -> (Maybe Int -> Int) -> (Parser -> String) -> Options -> String -> Boolean

check :: Options -> String -> Boolean
check options source = checkImpl fromTrailingComma fromRangeEnd fromParser options source

foreign import formatWithCursorImpl :: (TrailingComma -> String) -> (Maybe Int -> Int) -> (Parser -> String) -> Options -> String -> String

formatWithCursor :: Options -> String -> String
formatWithCursor options source = formatWithCursorImpl fromTrailingComma fromRangeEnd fromParser options source
