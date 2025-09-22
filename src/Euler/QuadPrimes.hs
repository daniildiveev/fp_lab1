module Euler.QuadPrimes (
  largestQuadPrimesRec,
  largestQuadPrimesTail,
  largestQuadPrimesModular,
  largestQuadPrimesMap,
  largestQuadPrimesListComp,
  largestQuadPrimesInfinite,
) where

import Data.List (maximumBy)
import Data.Ord (comparing)

productFst2 :: (Int, Int, Int) -> Int
productFst2 (x, y, _) = x * y

isPrime :: Int -> Bool
isPrime x
  | x < 2 = False
  | otherwise = loopDiv 2
 where
  limit :: Int
  limit = floor (sqrt (fromIntegral x :: Double))

  loopDiv d
    | d > limit = True
    | x `mod` d == 0 = False
    | otherwise = loopDiv (d + 1)

as :: [Int]
as = [-1000 .. 1000]

bs :: [Int]
bs = [x | x <- [-997 .. 997], isPrime (abs x)]

formulaValue :: Int -> Int -> Int -> Int
formulaValue a b n = n * n + a * n + b

-- REGULAR RECURSION --
primeRun :: Int -> Int -> Int
primeRun a b = loopRun 0
 where
  loopRun n
    | isPrime (formulaValue a b n) = 1 + loopRun (n + 1)
    | otherwise = 0

largestQuadPrimesRec :: Int
largestQuadPrimesRec = loopA as (0, 0, 0)
 where
  loopA [] best = productFst2 best
  loopA (a : asRest) best = loopA asRest (loopB a bs best)

  loopB _ [] best = best
  loopB a (b : bsRest) best@(_, _, len) =
    let l = primeRun a b
     in if l > len
          then loopB a bsRest (a, b, l)
          else loopB a bsRest best

-- TAIL RECURSION --
primeRunTail :: Int -> Int -> Int
primeRunTail a b = loopRunTail 0 0
 where
  loopRunTail n acc
    | isPrime (formulaValue a b n) = loopRunTail (n + 1) (acc + 1)
    | otherwise = acc

largestQuadPrimesTail :: Int
largestQuadPrimesTail = loopA as (0, 0, 0)
 where
  loopA [] best = productFst2 best
  loopA (a : asRest) best = loopA asRest (loopB a bs best)

  loopB _ [] best = best
  loopB a (b : bsRest) best@(_, _, len) =
    let l = primeRunTail a b
     in if l > len
          then loopB a bsRest (a, b, l)
          else loopB a bsRest best

-- MODULAR REALIZATION --
largestQuadPrimesModular :: Int
largestQuadPrimesModular =
  let allRuns = [(a, b, primeRun a b) | a <- as, b <- bs]
      best = maximumBy (comparing (\(_, _, len) -> len)) allRuns
   in productFst2 best

-- MAPPING GENERATION --
largestQuadPrimesMap :: Int
largestQuadPrimesMap =
  let pairs = [(a, b) | a <- as, b <- bs]
      results = map (\(a, b) -> (a, b, primeRun a b)) pairs
      best = maximumBy (comparing (\(_, _, len) -> len)) results
   in productFst2 best

-- LIST COMPREHENSION --
largestQuadPrimesListComp :: Int
largestQuadPrimesListComp =
  let best =
        maximumBy
          (comparing (\(_, _, len) -> len))
          [(a, b, primeRun a b) | a <- as, b <- bs]
   in productFst2 best

-- INFINITE LISTS --
runLen :: Int -> Int -> Int
runLen a b = length . takeWhile isPrime $ [formulaValue a b n | n <- [0 ..]]

largestQuadPrimesInfinite :: Int
largestQuadPrimesInfinite =
  let triples = [(a, b, runLen a b) | a <- as, b <- bs]
      best = maximumBy (comparing (\(_, _, len) -> len)) triples
   in productFst2 best
