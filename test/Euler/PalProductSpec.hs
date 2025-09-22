module Euler.PalProductSpec (spec) where

import qualified Euler.PalProduct as P
import Test.Hspec

spec :: Spec
spec = describe "Euler Problem 4 (palindrome product)" $ do
  it ("largestPalRec result = " ++ show recTestValue) $
    recTestValue `shouldBe` 906609

  it ("largestPalTail result = " ++ show tailTestValue) $
    tailTestValue `shouldBe` 906609

  it ("largestPalModular result = " ++ show modularTestValue) $
    modularTestValue `shouldBe` 906609

  it ("largestPalMap result = " ++ show mapTestValue) $
    mapTestValue `shouldBe` 906609

  it ("largestPalListComp result = " ++ show listCompTestValue) $
    listCompTestValue `shouldBe` 906609

  it ("largestPalInfinite result = " ++ show infiniteTestValue) $
    infiniteTestValue `shouldBe` 906609
 where
  recTestValue = P.largestPalRec
  tailTestValue = P.largestPalTail
  modularTestValue = P.largestPalModular
  mapTestValue = P.largestPalMap
  listCompTestValue = P.largestPalListComp
  infiniteTestValue = P.largestPalInfinite
