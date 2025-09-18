module Euler.PalProduct (
  largestPalRec,
  largestPalTail,
  largestPalModular,
  largestPalMap,
  largestPalListComp,
  largestPalInfinite,
) where

isPal :: Int -> Bool
isPal x = let s = show x in s == reverse s

-- REGULAR RECURSION --
largestPalRec :: Int
largestPalRec = go 999 999
 where
  go a b
    | a < 100 = 0
    | b < 100 = go (a - 1) 999
    | isPal p = max p (go a (b - 1))
    | otherwise = go a (b - 1)
   where
    p = a * b

-- TAIL RECURSION --
largestPalTail :: Int
largestPalTail = go 999 999 0
 where
  go a b best
    | a < 100 = best
    | b < 100 = go (a - 1) 999 best
    | p <= best = go a (b - 1) best
    | isPal p = go a (b - 1) (max best p)
    | otherwise = go a (b - 1) best
   where
    p = a * b

-- MODULAR REALIZATION --
largestPalModular :: Int
largestPalModular =
  let products = [a * b | a <- [100 .. 999], b <- [100 .. 999]] -- explicit products generation
      pals = filter isPal products -- explicit filtering
   in foldr max 0 pals -- explicit fold

-- MAPPING GENERATION --
largestPalMap :: Int
largestPalMap =
  let products = [(a, b) | a <- [100 .. 999], b <- [100 .. 999], isPal (a * b)]
   in maximum $ map (uncurry (*)) products -- возможно перемудрил, как будто единственный интересный способ использовать здесь map

-- LIST COMPREHENSION --
largestPalListComp :: Int
largestPalListComp =
  maximum [a * b | a <- [100 .. 999], b <- [100 .. 999], isPal (a * b)]

-- INFINITE LISTS --
largestPalInfinite :: Int
largestPalInfinite =
  let as = takeWhile (<= 999) [100 ..]
      bs = takeWhile (<= 999) [100 ..]
   in maximum $ filter isPal [a * b | a <- as, b <- bs]
