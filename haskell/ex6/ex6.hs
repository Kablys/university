module Ex6 where

--import Queue
import qualified Data.Set as S

-- 1 Done
data GTree a = Leaf a | Gnode [GTree a]

gDepth :: GTree a -> Integer
gDepth (Leaf _) = 1
gDepth (Gnode l) = 1 + maximum (map gDepth l)

gElem :: (Eq a) => GTree a -> a -> Bool
gElem (Leaf b) a = b == a
gElem (Gnode l) a = True `elem` map (`gElem` a) l

gMap :: GTree a -> (a -> b) -> GTree b
gMap (Leaf b) f = Leaf (f b)
gMap (Gnode l) f = Gnode (map (`gMap` f) l)
-- 2
data Result a = OK a | Error String deriving (Show)
composeResult :: (a -> Result b) -> (b -> Result c) -> (a -> Result c)
composeResult fb fc = getOut.fb
  where getOut (OK a) = fc a
        getOut (Error s) = Error s
-- 3
-- Kitame faile
-- 4
type Relation a b = S.Set (a,b)
dom :: Ord a => Relation a b -> S.Set a
dom = S.map fst
ran :: Ord b => Relation a b -> S.Set b
ran = S.map snd
image :: (Ord a,Ord b) => S.Set a -> Relation a b -> S.Set b
image s r = ran (S.filter (\x -> fst x `S.member` s) r)

-- 5 Done
primes :: [Integer]
primes = sieve [2 ..]
  where sieve (x:xs) = x : sieve [y | y <- xs, y `mod` x > 0]

isPrime :: Integer -> Bool
isPrime n = n `elem` [ x + y | x <- p n, y <- p n]
  where p x = takeWhile (< n) primes

goldbach :: Integer -> Bool
goldbach n = and [isPrime x | x <- [4,6 .. n]]
-- 6 Done
fibb :: [Int]
fibb = 0 : 1 : [ a + b | (a, b) <- zip fibb (tail fibb)]
