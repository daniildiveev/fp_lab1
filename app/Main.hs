module Main where

import Euler.PalProduct
import Euler.QuadPrimes

main :: IO ()
main = do
  putStrLn "=== Project Euler solutions ==="
  putStrLn $ "Problem 4 (largest palindrome product): " <> show largestPalListComp
  putStrLn $ "Problem 27 (quadratic primes):" <> show largestQuadPrimesListComp
