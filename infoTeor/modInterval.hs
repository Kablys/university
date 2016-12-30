module Main where

--import System.Environment
--import System.Posix
import System.IO

import Control.Monad (replicateM)

import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString as BS

import qualified Data.Binary.Strict.BitGet as BSG
import qualified Data.Binary.BitPut as BP
--import qualified Data.Binary.Get as BG

import Data.Word
import Data.List
import Numeric
import Data.Char (intToDigit, digitToInt)

import Debug.Trace


-- TODO convert to Word16
modIndex :: Int -> [Int] -> ([Int], Int)
modIndex val index = (map inc index, newZero)
  where
    -- test genericIndex
    --newZero = genericIndex index !! val
    newZero = index !! val
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
  contents <- BS.readFile "100kAs.txt"
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
lazyGet steps size remainder = do
  input <- BS.readFile "100kAs.txt"
  --traceM("Input " ++ show input)
  let h = BSG.runBitGet input (do
      file <- replicateM steps (BSG.getAsWord16 size)
      rm <- BSG.getAsWord16 remainder
      return (file, rm))
  case h of
    Left e -> fail e
    Right x -> return x

lazyPut content head2 = do
  let hSize = fromIntegral (getSize head2) :: Int
      hRSize = fromIntegral (getRemSize head2) :: Int
      --hRem = if hRSize == 0 then BL.empty else BP.runBitPut (BP.putNBits (hRSize) (getRem head2))
      out = BP.runBitPut (do
        mapM_ (BP.putNBits hSize) content 
        BP.putNBits (hRSize) (getRem head2))
  return out
  

-- TODO get Rem
encodeFile = do
  fileSize <-  withFile "100kAs.txt" ReadMode hFileSize
  let size = 2 
      size' = fromIntegral size :: Word8
      steps = (fromInteger fileSize * 8) `div` size
      remainder = (fromInteger fileSize * 8) `mod` size
      remainder' = fromIntegral remainder :: Word8
  (source, rm) <- lazyGet steps size remainder
  head <- buildHeader (Header False size' remainder' rm)  
 -- traceM("Header " ++ show head)
 -- traceM("File size " ++ show fileSize ++ " bytes, Step " ++ show steps ++ " size " ++ show size ++ " remainder " ++ show remainder)
  --traceM("Source " ++ show source)
  let abcIndex sizeI = [2^sizeI-1,2^sizeI-2..0]
      source' = fmap fromIntegral source :: [Int]
  return (source', head)


-- 1 gamma u 0 = 1, u 1 = 010, u 2 = 011, u 3 = 00100
-- 2 other(i think delta) v 0 = 11, v 1 = 01010, v 2 = 01011, v 3 = 011100 .
elias x = zeros x ++ bin x
-- TODO skaiciuoti 2^x jeigu daugiau pasiimti = n - 1, jeigu sutampa = n
  where zeros y = replicate (floor (logBase 2 (fromIntegral(y+1)))) '0'
        bin y = showIntAtBase 2 intToDigit (y+1) ""

-- TODO scanr arba nors filter pakeisti
eliasde str = filter (>=0) . map ((flip (-)1).toDec) $ unfoldr (\x -> if null x
                               then Nothing 
                               else Just (getOne x)) str
  where 
    getOne s = splitAt (n s + 1) (drop (n s) s)
    n s = length (takeWhile ( == '0') s)
    toDec = foldl' (\acc x -> acc * 2 + digitToInt x) 0

elToFile str = do
  let out = BP.runBitPut (mapM_ (\bit -> if bit == '1' then BP.putBit True else BP.putBit False) str)
  return out

elFromFile contents = do -- deocodeRead
  let size = (BS.length contents - 3) * 8 -- 3 = size of header
      file = BSG.runBitGet contents (do 
        code <- BSG.getBit
        size' <- BSG.getAsWord8 4
        remSize <- BSG.getAsWord8 4
        remain <- BSG.getAsWord16 15
        let head = Header code size' remSize remain
        --traceM ("test" ++ show head)
        --head <- readHeader
        f <- replicateM size BSG.getBit
        --traceM ("f   " ++ show f)
        return $ (f, head))
      toStr = map (\bool -> if bool then '1' else '0')
  case file of
    Left e -> fail e
    Right (x,y) -> return ((toStr x), y)


test = do
  let abcIndex sizeI = [2^sizeI-1,2^sizeI-2..0]
  (file, head) <- encodeFile
  let size = 2
      encoded = encode (abcIndex size) file
      el =  map elias encoded
  out <- elToFile (concat el)
  let outHead = BL.append head out
      
  --traceM("size " ++ show size ++ " Interval encoded " ++ show encoded)
  --traceM("Elias encoded " ++ show el)
  --traceM("Output:" ++ show out)
  --traceM("with head" ++ show outHead)
  (enFile, head2) <- elFromFile (BL.toStrict outHead)
  let hSize = fromIntegral (getSize head2) :: Int
      hRSize = fromIntegral (getRemSize head2) :: Int
      hRem = if hRSize == 0 then BL.empty else BP.runBitPut (BP.putNBits (hRSize) (getRem head2))
  --traceM("encoded file " ++ show enFile)
  -- TODO give getCode head2 result
  let elde = eliasde enFile
  --traceM ("elias decoded" ++ show elde)
  let decoded = decode (abcIndex hSize) elde
  --traceM ("decoded interval: " ++ show decoded)
  outD <- lazyPut decoded head2
  BL.writeFile "out.txt" outD
  --let outDHead = BL.append out hRem

  --traceM ("Decoded " ++ show outD)
  --traceM ("Decoded with rem" ++ show outDHead)
  
  return () -- (BL.toStrict out)

--modInt encode|en SIZE(2-16) TYPE(elias 1 arba 2) SOURCE DEST
--modInt decode|de SOURCE DEST --All needed info should be in header

-- main :: IO ()
main = test 
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
