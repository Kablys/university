module Ex2
where

import Data.Char
-- 1 
average :: [Float] -> Float
average [] = error "Neveikia tusciam sarasui"
average x = sum x / fromIntegral(length x)

-- 2
-- Kaip su neigemais skaiciais
divides :: Integer -> [Integer]
divides 0 = []
divides n = reverse (an:dividesX (an-1))
  where dividesX x
          |x == 0 = []
          |rem an x == 0 = x:dividesX (x-1)
          |otherwise = dividesX (x-1)
        an = abs n

divides' :: Integer -> [Integer]
divides' n = [x | let an = abs n, x <- [1 .. an], rem an x == 0]

isPrime :: Integer -> Bool
isPrime n = length (divides n) <= 2


-- 3 
-- Kaip su tuscia elgtis
prefix :: String -> String -> Bool
prefix _ [] = False
prefix [] _ = True
prefix (x:xs) (y:ys) = (x == y) && prefix xs ys

--Kaip is prefix reikalavimo supratau 1 argumentas turi buti 2 dalis
substring :: String -> String -> Bool
substring _ [] = False
substring x y
  | x == y = True
  | prefix x y = True
  | substring x (tail y) = True 
  | otherwise = False

-- 4
capitalise :: String -> String
capitalise s = [toUpper x | x <- s, x `elem`  (['A'..'Z']++['a' .. 'z'])]
filTran :: (Char -> Bool) -> (Char -> Char) -> String -> String
filTran f t s = [t x | x <- s, f x]
