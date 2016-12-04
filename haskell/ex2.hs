module Ex2
where

import Test.QuickCheck
import Data.Char
-- 1 
average :: [Float] -> Float
average [] = error "Neveikia tusciam sarasui"
average x = sum x / fromIntegral(length x)

-- 2
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

prop_divides :: Integer -> Bool
prop_divides x = divides x == divides' x

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
-- Jei gerai supratau ismesti simbolius kurie nere raides
capitalise :: String -> String
capitalise s = [toUpper x | x <- s, x `elem`  (['A'..'Z']++['a' .. 'z'])]

filTran :: (Char -> Bool) -> (Char -> Char) -> String -> String
filTran f t s = [t x | x <- s, f x]

prop_filTran :: String -> Bool
prop_filTran x = capitalise x == filTran (flip elem (['A'..'Z']++['a' .. 'z'])) toUpper x
--toUpper :: Char -> Char
--toUpper c
--  | ord c > 96 && ord c < 123 = chr (ord c - 32)
--  | otherwise = c

-- 5
itemTotal :: [(String, Float)] -> [(String, Float)]
itemTotal [] = []
itemTotal item = foldr1 (\x y -> (headName,snd x + snd y)) (filter inList  item):itemTotal (filter outList item)
  where
    headName = fst(head item)
    inList x = headName == fst x
    outList x = headName /= fst x


itemDiscount :: String -> Integer ->[(String, Float)] -> [(String, Float)]
itemDiscount name percent list
  | percent > 100 || percent < 1 = error "Netinkama nuolaidos reiksme"
  | otherwise = map (\i -> if fst i == name then (name, snd i * (fromIntegral percent /100)) else i) list
