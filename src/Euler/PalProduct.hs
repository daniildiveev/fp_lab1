module Euler.PalProduct
  ( isPal
   , largestPalRec
   , largestPalTail
  -- , largestPalModular
  -- , largestPalListComp
  -- , largestPalInfinite
  -- , largestPalPythonLike
  ) where

isPal :: Int -> Bool
isPal x = let s = show x in s == reverse s

largestPalRec :: Int
largestPalRec = go 999 999
  where
    go a b
      | a < 100    = 0
      | b < 100    = go (a - 1) 999
      | isPal p    = max p (go a (b - 1))
      | otherwise  = go a (b - 1)
      where
        p = a * b


largestPalTail :: Int
largestPalTail = go 999 999 0
  where
    go a b best
      | a < 100    = best
      | b < 100    = go (a - 1) 999 best
      | p <= best  = go a (b - 1) best
      | isPal p    = go a (b - 1) (max best p)
      | otherwise  = go a (b - 1) best
      where
        p = a * b
