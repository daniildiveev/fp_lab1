module Euler.QuadPrimesSpec (spec) where

import qualified Euler.QuadPrimes as Q
import Test.Hspec

spec :: Spec
spec = describe "Euler Problem 27 (quad primes)" $ do
  it ("largestQuadPrimesRec result = " ++ show recTestValue) $
    recTestValue `shouldBe` (-59231)

  it ("largestQuadPrimesTail result = " ++ show tailTestValue) $
    tailTestValue `shouldBe` (-59231)

  it ("largestQuadPrimesModular result = " ++ show modularTestValue) $
    modularTestValue `shouldBe` (-59231)

  it ("largestQuadPrimesMap result = " ++ show mapTestValue) $
    mapTestValue `shouldBe` (-59231)

  it ("largestQuadPrimesListComp result = " ++ show listCompTestValue) $
    listCompTestValue `shouldBe` (-59231)

  it ("largestQuadPrimesInfinite result = " ++ show infiniteTestValue) $
    infiniteTestValue `shouldBe` (-59231)
 where
  recTestValue = Q.largestQuadPrimesRec
  tailTestValue = Q.largestQuadPrimesTail
  modularTestValue = Q.largestQuadPrimesModular
  mapTestValue = Q.largestQuadPrimesMap
  listCompTestValue = Q.largestQuadPrimesListComp
  infiniteTestValue = Q.largestQuadPrimesInfinite
