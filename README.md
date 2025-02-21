# Haskell Parser Project

This is a parser project in Haskell, demonstrating monadic parsing concepts with Parsec.

## Overview

- **app/Main.hs**

  - Contains the main entry point.
  - Prints a greeting and demonstrates the parser with various hardcoded strings.
  - Optionally parses the first command-line argument passed in.

- **src/Lib.hs**

  - Defines `msg :: String` (our greeting).
  - Exports `runMyParser :: String -> Either ParseError MyParsed`, which runs a simple parser on an input string.
  - Implements helper functions (`alphaString`, `integer`, etc.) to parse alphabetic words plus optional digits, returning `MyParsed` objects.

- **test/Spec.hs & test/LibSpec.hs**
  - Uses **Hspec** for tests.
  - Currently includes a minimal test that checks the `msg` string.
  - You can add additional tests to verify parser correctness under various scenarios.

### Setup

1. **Check Dependencies**  
   Make sure you have [Stack](https://docs.haskellstack.org/en/stable/README/) or GHC/cabal installed.  
   The `package.yaml` (or `.cabal`) declares dependencies on `parsec` and `hspec`.

2. **Build**

   ```
   stack build
   ```

   This will fetch and build all required dependencies.

3. **Run**

   ```
   stack run
   ```

   You’ll see:

   - The greeting: "Hello, MPCS 51400 World!"
   - A series of hardcoded parse attempts (e.g. "Hello123", "ABC", etc.)
   - Optionally, if you do stack run "Example999", you’ll see parse results for "Example999".

4. **Test**
   Runs Hspec tests in test/.
   By default, we have a test confirming Lib.msg == "Hello, MPCS 51400 World!".
   You can add more tests as needed (see below).

5. **Modify**

- Tweak the parser in Lib.hs to handle more sophisticated grammars.
- Add more sample parse cases to Main.hs or more tests in test/.
