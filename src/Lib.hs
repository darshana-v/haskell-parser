module Lib where

-- 1) Parsec imports
import Text.Parsec hiding (parse, satisfy)         -- hide Parsec's parse and satisfy
import qualified Text.Parsec as P         -- import it qualified
import Text.Parsec.String (Parser)
import Control.Applicative ((<|>))        -- for choice
import Data.Char (isAlpha, isDigit)

-- 2) Hello World msg
msg :: String
msg = "Hello, MPCS 51400 World!"

-------------------------------------------------------------------------------
-- 3) Simplify parse, char, etc. for demonstration (optional helpers)
-------------------------------------------------------------------------------

-- We define a simpler 'parse' function specialized to String input:
parse :: Parser a -> String -> Either ParseError a
parse p = P.parse p ""

-- Likewise, we can define or re-export simpler versions of standard parsers:
char :: Char -> Parser Char
char = P.char

string :: String -> Parser String
string = P.string

satisfy :: (Char -> Bool) -> Parser Char
satisfy = P.satisfy

-- Many other combinators (like `many1`, `choice`, `(<|>)`, etc.)
-- are already provided by the Parsec library or Control.Applicative.

-------------------------------------------------------------------------------
-- 4) Example: a mini parser that parses:
--    1) One or more alphabetic letters (a "word")
--    2) Optionally, a sequence of digits (an "integer")
--    We'll return them in a small data structure.
-------------------------------------------------------------------------------

-- A small data type to hold parsed results
data MyParsed = MyParsed
  { alphaPart :: String
  , maybeNum  :: Maybe Int
  } deriving (Show, Eq)

-- Parser for a contiguous alphabetic string
alphaString :: Parser String
alphaString = many1 (satisfy isAlpha)
  -- many1 means "one or more"

-- Parser for an integer
integer :: Parser Int
integer = do
  digits <- many1 (satisfy isDigit)
  return (read digits)

-- Our combined parser: parse an alphabetic word, then optionally some digits
myParser :: Parser MyParsed
myParser = do
  ws <- alphaString
  -- optionally parse digits, using the combinator <|>
  mNum <- optionMaybe integer
  return (MyParsed ws mNum)

{-
  Alternatively, we could do:

  myParser = MyParsed <$> alphaString <*> optionMaybe integer

  which uses Applicative style.
-}

-------------------------------------------------------------------------------
-- 5) A convenient function to run our parser
-------------------------------------------------------------------------------

-- Run 'myParser' on a given String
runMyParser :: String -> Either ParseError MyParsed
runMyParser input = parse myParser input
