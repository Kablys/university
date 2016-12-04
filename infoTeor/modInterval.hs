module ModInterval where

--import System.Environment
--import System.Posix
import System.IO

import Control.Monad (replicateM)

import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString as BS

import qualified Data.Binary.Strict.BitGet as BSG
import qualified Data.Binary.BitPut as BP
import qualified Data.Binary.Get as BG

import Data.Word
import Data.List
import Numeric
import Data.Char


-- TODO convert to Word16
modIndex :: Int -> [Int] -> ([Int], Int)
modIndex val index = (map inc index, newZero)
  where
    val' = 
    newZero = index !! val'
    inc x
      | x == newZero = 0
      | x > newZero = x
      | otherwise = x + 1


encode :: [Int] -> [Int] -> [Int]
encode _ [] = []
encode index (x:xs) = val : encode newIndex xs
  where
    (newIndex, val) = modIndex x index

modIndex' :: Int -> [Int] -> ([Int], Int)
modIndex' val index = (index', newZero')
  where
    Just newZero' = val `elemIndex` index
    (index',_) = modIndex newZero' index

decode :: [Int] -> [Int] -> [Int]
decode _ [] = []
decode index (x:xs) = val : decode newIndex xs
  where
    (newIndex, val) = modIndex' x index

-- +---+---+---+---+---+---+---+---+---+------+
-- | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9-24 |
-- +---+---+---+---+---+---+---+---+---+------+
-- | E |      SIZE     |    REMSIZE    |  REM |
-- +---+---------------+---------------+------+
--
-- 1  E 0-delta 1-gamma
-- 4  SIZE 2-16 kiek bitu naudojama
-- 4  REMSIZE 1-15 kiek bitu prideti gale
-- 15 REM bitai kuriuos reiks prideti i gala. REMSIZE pirmu bitu
--Test: readHeader >>= buildHeader
data Header = Header { getCode :: Bool
                     , getSize :: Word8
                     , getRemSize :: Word8
                     , getRem :: Word16 } deriving (Show)
-- TODO Skirtingu tipu monados, jus minejote Get, runBitGet
buildHeader :: Monad m => Header -> m BL.ByteString
buildHeader header = do
  let h = BP.runBitPut (do
      BP.putBit (getCode header)
      BP.putNBits 4 (getSize header)
      BP.putNBits 4 (getRemSize header)
      BP.putNBits 15 (getRem header)
      return ())
  return h

readHeader :: IO Header
readHeader = do
  contents <- BS.readFile "./testHeader"
  let h = BSG.runBitGet contents (do
      code <- BSG.getBit
      size <- BSG.getAsWord8 4
      remSize <- BSG.getAsWord8 4
      remain <- BSG.getAsWord16 15
      return $ Header code size remSize remain)
  case h of
    Left e -> fail e
    Right x -> return x


--lazyGet :: IO [Word16]
lazyGet steps size = do
  input <- BS.readFile "testHeader"
  let h = BSG.runBitGet input (replicateM steps (BSG.getAsWord16 size))
  case h of
    Left e -> fail e
    Right x -> return x


encodeFile = do
  -- read -> to Word16 -> to Interval ->  to Ellias -> write
  --contents <- BL.readFile "./testHeader"
  fileSize <- withFile "./testHeader" ReadMode hFileSize
  let size = 12
      steps = (fromInteger fileSize * 8) `div` size
  print (steps, size)
  source <- lazyGet steps size
  --print source
  let abcIndex sizeI = [2^sizeI-1,2^sizeI-2..0]
      source' = fmap fromIntegral source :: [Int]
  print (decode (abcIndex size) ( encode (abcIndex size) source'))
  return source

-- gamma u 0 = 1, u 1 = 010, u 2 = 011, u 3 = 00100
-- other v 0 = 11, v 1 = 01010, v 2 = 01011, v 3 = 011100 .
--elias :: Int -> [Word8]
--elias =  [zero ++ bin | zero <- map e [0 .. 3], bin <- map toBin [0 .. 3]]
elias n = map (\x -> zeros x ++ bin x) [0 .. n]
 where zeros x = replicate (floor (logBase 2 (fromIntegral(x+1)))) '0'
       bin x = showIntAtBase 2 intToDigit (x+1) ""
--WTF
--elias = map e [0 .. 3]
-- where e x = replicate (floor (logBase 2 (x+1))) '0' ++ toBin x
--       toBin y = showIntAtBase 2 intToDigit y ""

--modInt encode|en SIZE(2-16) TYPE(elias 1 arba 2) SOURCE DEST
--modInt decode|de SOURCE DEST --All needed info should be in header

-- main :: IO ()
-- main = do
--   arg <- getArgs
--   case arg of
--     [] -> error "no args"
--     ("en":a)-> print "en"
--       --conntent <- BL.read
--       --putStrLn conntent
--     ("de":a)-> print "de"
--     ("head":a)-> do
--       contents <- BL.readFile "./testHeader"
--       print "head"
--     ("test":a)-> print (decode (abcIndex 3) ( encode (abcIndex 3) [0,2,3,0,0,1,0,2,0,2,3])) --(map ord "test"))
--                    where abcIndex size = [size,size-1..0]
--     _ -> error "wrong args"
