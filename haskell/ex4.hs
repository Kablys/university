module Ex4
where

import Test.QuickCheck
import Data.Char
-- 1 Done
length' :: [a] -> Integer
length' = sum.map(const 1)
prop_length :: [a] -> Bool
prop_length l = toInteger(length l) == length' l
-- 2 Done
any' :: (a->Bool) -> [a] -> Bool
any'' :: (a->Bool) -> [a] -> Bool
any' f = not.null.filter f
any'' f = foldr(||) False .map f

all' :: (a->Bool) -> [a] -> Bool
all'' :: (a->Bool) -> [a] -> Bool
all' f l = length (filter f l) == length l
all'' f = foldr(&&) True .map f 

prop_any :: (Char->Bool) -> [Char] -> Bool
prop_any f l = (any' f l )== (any'' f l)
-- 3 Done
unzip' :: [(a,b)] -> ([a],[b])
unzip' = foldr (\list acc -> ( fst list:fst acc, snd list:snd acc) ) ([],[])
prop_unzip :: (Eq a, Eq b) => [(a,b)] -> Bool
prop_unzip x = unzip x == unzip' x
-- 4 Done
ff :: Integer -> [Integer] -> Integer
ff maxNum = foldl1(\acc num -> if maxNum > (acc + num) then num + acc else acc).map(*10).filter( > 0)
-- 5 Done
flip' :: (a->b->c) -> (b->a->c)
flip' f = \x y -> f y x
--6
total :: (Integer -> Integer) -> (Integer -> Integer)
total f = sum.map f . parts
  where parts n = [0 .. n]

total' :: (Integer -> Integer) -> (Integer -> Integer)
total' f = foldr (\x acc -> f x + acc) 0 .parts 
  where parts n = [0 .. n]

total'' :: (Integer -> Integer) -> (Integer -> Integer)
total'' f n = foldr (\x acc -> f x + acc) 0 [0 .. n] 

--prop_total :: (Integer -> Integer) -> Integer -> Bool
--prop_total f n = (total f) n == (total' f) n
