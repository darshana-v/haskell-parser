module LibSpec
  ( spec,
  )
where

import qualified Lib
import Test.Hspec (Spec, describe, it, shouldBe, shouldSatisfy)

spec :: Spec
spec = do
  describe "someFunc" $ do
    it "message mentions the MPCS" $ do
      Lib.msg `shouldBe` "Hello, MPCS 51400 World!"

  describe "runMyParser" $ do

    it "parses a word + digits successfully" $ do
      case Lib.runMyParser "Hello123" of
        Left err -> error $ "Expected success, but got error: " ++ show err
        Right val -> val `shouldBe` Lib.MyParsed { Lib.alphaPart = "Hello"
                                                 , Lib.maybeNum = Just 123
                                                 }

    it "parses a word with no digits as Just Nothing" $ do
      case Lib.runMyParser "ABC" of
        Left err -> error $ "Expected success, but got error: " ++ show err
        Right val -> val `shouldBe` Lib.MyParsed { Lib.alphaPart = "ABC"
                                                 , Lib.maybeNum = Nothing
                                                 }

    it "fails when input does not begin with alpha" $ do
      case Lib.runMyParser "123ABC" of
        Left _ -> True `shouldBe` True  -- pass
        Right _ -> error "Expected parse failure, but succeeded unexpectedly!"

    it "parses empty string with error" $ do
      Lib.runMyParser "" `shouldSatisfy` isLeft

-- Helper function to test for Left
isLeft :: Either a b -> Bool
isLeft (Left _)  = True
isLeft (Right _) = False
