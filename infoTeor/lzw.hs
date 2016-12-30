module Lzw where

import Data.List
import Data.List.Split (chunksOf)
import Data.Maybe

import System.IO  (hFlush, stdout)

import Debug.Trace

import Test.QuickCheck

--chars = [' '..'~']   -- Becuase ' ' = 0x20 and '~' = 0x7F.

-- Limpel-Ziv-Welch encoding
-- Parametrai 0 - n zodyno ilgis
--              0 - failas sutelpa iki galo
--              n - iki kiek plesti zodyna
--            0 - 1 kaip elgtis kai pasiekiami
--              0 - uzsaldyti
--              1 - is naujo
-- Header  |0 1 2 3 4 5 6|7
--         |    ilgis    |elgesys
-- ilgis   nuo 256 iki 32768 (8-15 bit)
-- elgesys bool

-- Old simple minimal implementation
oldEncodeLZW :: (Eq t) => [t] -> [t] -> [Int]
oldEncodeLZW alphabet = work (map (:[]) alphabet)
  where
    work _ []  = []
    work table lst = fromJust (elemIndex tok table) : work (table ++ [tok ++ [head rst]] ) rst
      where
        chunk pre lst = last . takeWhile (pre . fst) . tail $ zip (inits lst) (tails lst)
        (tok, rst) = chunk (`elem` table) lst

oldDecodeLZW :: [t] -> [Int] -> [t]
oldDecodeLZW alphabet xs = concat output
  where
    output = map (table !!) xs
    table = map (:[]) alphabet ++ zipWith (++) output (map (take 1) (tail output))

-- New implementation
encodeLZW :: (Eq t) => Bool -> Int -> [t] -> [t] -> [Int]
encodeLZW freeze bSize alphabet = work (map (:[]) alphabet)
  where
    size = 2 ^ bSize
    work _ []  = []
    work table lst
      | length table == size && freeze = fromJust (elemIndex tok table) : work table rst
      | length table == size && not freeze = fromJust (elemIndex tok table) : work (map (:[]) alphabet) rst
      | length table > size = error "Table got to big"
      | otherwise = fromJust (elemIndex tok table) : work (table ++
                                                            [tok ++ [head rst]] -- current + next token
                                                           ) rst
      where
        chunk pre lst = last . takeWhile (pre . fst)
                             . tail $ zip (inits lst) (tails lst)
        (tok, rst) = chunk (`elem` table) lst

decodeLZW :: Bool -> Int -> [t] -> [Int] -> [t]
decodeLZW freeze bSize alphabet xs 
  |not freeze = concat $ fmap (decodeLZW (not freeze) bSize alphabet) xSplit
  |otherwise = concat output
  where
    size = (2 ^ bSize) - (2 ^ 8)
    xSplit = chunksOf size xs

    output = map (table !!) xs
    table = map (:[]) alphabet ++ zipWith (++) 
                                            output 
                                            (map (take 1) (tail output))


prop_ende :: Bool -> String -> Bool
prop_ende testMode testData = testData == decodeLZW testMode 9 abc ( encodeLZW testMode 9 abc testData )
  where abc = ['\0' .. '\255']
--prop_ende :: Bool -> Int -> String -> Bool
--prop_ende testMode testSize testData = testData == (decodeLZW abc $ encodeLZW testMode testSize abc testData)
--  where abc = ['\0' .. '\255']
main :: IO ()
main = do x <- readFile "100kAs.txt"
          let size = 9 
              e = encodeLZW False size a x
              --d =
              l = length x `div` 80
              a = ['\0' .. '\255']
              eq b c
                | b == c    = putChar '=' >> hFlush stdout
                | otherwise = error "data error"
              cmp = zipWith eq x . decodeLZW False size a . encodeLZW False size a $ x
              vl = map head $ unfoldr (\cm -> case cm of
                                                [] -> Nothing
                                                _ -> Just (splitAt l cm)) cmp
          --writeFile "outlzw.txt" $ concat $ map (\y -> ' ':show y) e
          sequence_ vl
