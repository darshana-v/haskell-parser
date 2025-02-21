module Main where

import System.Environment (getArgs)
import qualified Lib

main :: IO ()
main = do
    putStrLn Lib.msg

    -- We'll do several parser test-cases right in main:
    putStrLn "\n--- Demo: Hardcoded Parser Tests ---"
    printParse "Hello123"
    printParse "ABC"
    printParse "XYZ999 test"
    printParse "   leadingSpaces"
    printParse "NoDigitsHere"
    printParse "invalid??"
    printParse ""

    -- Also parse the first command-line argument if any
    putStrLn "\n--- Demo: Parsing First CLI Argument (if any) ---"
    args <- getArgs
    case args of
      []        -> putStrLn "No input provided. Try: stack run \"Hello123\""
      (inp : _) -> printParse inp


-- Helper function: runs the parser on a string and prints result
printParse :: String -> IO ()
printParse inp = do
    putStrLn $ "\nParsing: " ++ show inp
    let result = Lib.runMyParser inp
    case result of
      Left err  -> putStrLn $ " -> Parser failed: " ++ show err
      Right val -> putStrLn $ " -> Parsed successfully: " ++ show val
