module Euler.QuadPrimesSpec (spec) where

import qualified Euler.QuadPrimes as Q
import Test.Hspec

spec :: Spec
spec = describe "Euler Problem 27 (quad primes)" $ do
  it ("largestQuadPrimesRec result = " ++ show recTestValue) $
    recTestValue `shouldBe` (-59231)

  it ("largestQuadPrimesTail result = " ++ show tailTestValue) $
    tailTestValue `shouldBe` (-59231)
  where
    recTestValue  = Q.largestQuadPrimesRec
    tailTestValue = Q.largestQuadPrimesTail
