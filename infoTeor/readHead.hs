{-# LANGUAGE ScopedTypeVariables, ForeignFunctionInterface #-}
module Network.DNS.Common where

--import Control.Monad (when)

import Data.Word
import Data.Bits
import Data.List (intersperse)

import qualified Data.ByteString as B
import Data.ByteString.Internal (c2w, w2c)
import qualified Data.Binary.Put as P
import qualified Data.Binary.Strict.Get as G
import qualified Data.Binary.Strict.BitGet
data Header = Header { headId :: Word16
                     , headIsResponse :: Bool
                     , headOpCode :: QueryType
                     , headIsAuthoritative :: Bool
                     , headIsTruncated :: Bool
                     , headRecursionDesired :: Bool
                     , headRecursionAvailible :: Bool
                     , headResponseCode :: ResponseCode
                     , headQuestionCount :: Int
                     , headAnswerCount :: Int
                     , headNSCount :: Int
                     , headAdditionalCount :: Int }
                     deriving (Show, Eq)

parseHeader :: G.Get Header
parseHeader = do
  id <- G.getWord16be
  flags <- G.getByteString 2
  qdcount <- G.getWord16be >>= return . fromIntegral
  ancount <- G.getWord16be >>= return . fromIntegral
  nscount <- G.getWord16be >>= return . fromIntegral
  arcount <- G.getWord16be >>= return . fromIntegral

  let r = BG.runBitGet flags (do
    isquery <- BG.getBit
    opcode <- BG.getAsWord8 4 >>= parseEnum
    aa <- BG.getBit
    tc <- BG.getBit
    rd <- BG.getBit
    ra <- BG.getBit

    BG.getAsWord8 3
    rcode <- BG.getAsWord8 4 >>= parseEnum

    return $ Header id isquery opcode aa tc rd ra rcode qdcount ancount nscount arcount)

  case r of
       Left error -> fail error
       Right x -> return x
-- parseHeader = do
--   --id      <- G.getWord16be
--   flags   <- G.getByteString 3
--   qdcount <- fmap fromIntegral G.getWord16be
--   --ancount <- fmap fromIntegral G.getWord16be
--   --nscount <- fmap fromIntegral G.getWord16be
--   --arcount <- fmap fromIntegral G.getWord16be
--
--   let r = BG.runBitGet flags (do
--     el <- BG.getBit
--     size <- BG.getAsWord8 4
--     remSize <- BG.getAsWord8 4 >>= parseEnum
--     rem <- BG.getAsWord16 15 >>= parseEnum
--     --opcode <- BG.getAsWord8 4 >>= parseEnum
--
--     --BG.getAsWord8 3
--     --rcode <- BG.getAsWord8 4 >>= parseEnum
--
--     return $ el size remSize rem)

  case r of
    Left error -> fail error
    Right x -> return x
