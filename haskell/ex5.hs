module Ex5
where

import Data.List
--1
iter :: Integer -> (a -> a) -> (a -> a)
iter 0 f = f
iter n f = f . iter (n-1) f

iter' :: Integer -> (a -> a) -> (a -> a)
iter' 0 f = f
iter' n f = foldr (.) f ( replicate (fromIntegral n-1) f)
--2
splits :: [a] -> [([a],[a])]
splits ls = map (\x -> (take x ls,drop x ls)) [0 .. length ls]

--3
type RegExp = String -> Bool

option :: RegExp -> RegExp
option p x = length (filter ( == True )[ p n | n <- subsequences x]) < 2

plus :: RegExp -> RegExp
plus p x = or [ p n | n <- subsequences x]

--4
type Set a = a -> Bool

empty :: Set a
empty = const False

add :: Eq a => a -> Set a -> Set a
add el set x = x == el || set x

remove :: Eq a => a -> Set a -> Set a
remove el set x = (x /= el) && set x

union :: Set a -> Set a -> Set a
union set1 set2 x = set1 x || set2 x

intersection :: Set a -> Set a -> Set a
intersection set1 set2 x = set1 x && set2 x

subtract :: Set a -> Set a -> Set a
subtract set1 set2 x = set1 x && not (set2 x)

complement :: Set a -> Set a
complement set x = not (set x)

--5

average :: (Real a, Fractional b) => [a] -> b
average xs
  | null xs = 0
  | otherwise = realToFrac (sum xs) / genericLength xs

data NumList a = Nlist [a]

-- instance (Real a, Fractional a) => Eq (NumList a) where
--   (Nlist x) == (Nlist y) = avg x == avg y
--     where
--       avg z = realToFrac (sum y) / genericLength y
      --  sum x `div` genericLength x
instance (Real a) => Ord (NumList a) where
  (Nlist x) `compare` (Nlist y) = average x `compare` average y
--6
instance (Ord b, Num a, Num b) => Num (a-> b) where
    a + b = \x -> a x + b x
    a * b = \x -> a x * b x
    negate a x = -(a x)
    abs a x = if a x < 0 then negate (a x) else a x
    signum a x
      | a x < 0 = -1
      | a x > 0 = 1
      | otherwise = 0
    fromInteger = const . fromInteger
