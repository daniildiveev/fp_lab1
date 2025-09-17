module Euler.PalProductSpec (spec) where

import qualified Euler.PalProduct as P
import Test.Hspec

spec :: Spec
spec = describe "Euler Problem 4 (palindrome product)" $ do
  it "largestPalRec gives 906609" $
    P.largestPalRec `shouldBe` 906609

  it "largestPalTail gives 906609" $
    P.largestPalTail `shouldBe` 906609

-- it "largestPalListComp gives 906609" $
--   P.largestPalListComp `shouldBe` 906609
