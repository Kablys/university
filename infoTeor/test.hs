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
import qualified Data.Binary.Strict.BitGet as BG

--import Network.DNS.Types

--foreign import ccall unsafe "htonl" htonl :: Word32 -> Word32

-- | Types of DNS queries. RFC 1035, 4.1.1.
data QueryType = QUERY | IQUERY | SERVERSTATUS deriving (Show, Eq, Enum, Bounded)

-- | Parse an enum from a Word8 in a monad and fail if the value is out of range.
--   It's assumed that the enum is defined at every value between the min and max
--   bound
parseEnum :: forall m a. (Enum a, Bounded a, Monad m) => Word8 -> m a
parseEnum x' = r where
  r = if x < low || x > high
         then fail "Enum out of bounds"
         else return $ toEnum x
  low = fromEnum (minBound :: a)
  high = fromEnum (maxBound :: a)
  x = fromIntegral x'

-- | A DNS protocol header. RFC 1035, 4.1.1.
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

serialiseHeader :: Header -> P.Put
serialiseHeader header = do
  P.putWord16be $ headId header

  let flags1 = (v (headIsResponse header) `shiftL` 7) .|.
               (fromEnum (headOpCode header) `shiftL` 3) .|.
               (v (headIsAuthoritative header) `shiftL` 2) .|.
               (v (headIsTruncated header) `shiftL` 1) .|.
               (v (headRecursionDesired header))
      flags2 = (v (headRecursionAvailible header) `shiftL` 7) .|.
               (fromEnum (headResponseCode header))
      v True = 1
      v False = 0

  P.putWord8 $ fromIntegral flags1
  P.putWord8 $ fromIntegral flags2
  P.putWord16be $ fromIntegral $ headQuestionCount header
  P.putWord16be $ fromIntegral $ headAnswerCount header
  P.putWord16be $ fromIntegral $ headNSCount header
  P.putWord16be $ fromIntegral $ headAdditionalCount header

-- | Break a DNS name (e.g. www.google.com) into a list of labels
splitDNSName :: String -> [String]
splitDNSName = filter (not . null) . split '.' where
  split c xs = head : tail where
    (head, rest) = span (/= c) xs
    tail = case rest of
                [] -> []
                (_:xs) -> split c xs

-- | Convert a split name into the length-prefixed DNS wire format.
--   FIXME: should work with the IDNA system. Returns Nothing if the
--   name couldn't be serialised.
--   FIXME: catch invalid charactors and > 255 parts
serialiseDNSName :: [String] -> Maybe B.ByteString
serialiseDNSName x
  | length x > 255 = fail ""
  | otherwise = mapM f x >>= return . (flip B.snoc) 0 . B.concat where
      f x
        | length x > 63 = fail ""
        | otherwise = return $ B.cons lengthByte s where
            lengthByte = fromIntegral $ length x
            s = B.pack $ map c2w x

-- | Convert a list of labels to a normal string by interspersing periods
fromDNSName :: [String] -> String
fromDNSName = concat . intersperse "."

parseDNSName :: B.ByteString -> G.Get [String]
parseDNSName packet = do
  let getLabel 16 = fail "Pointer loop in DNS name"
      getLabel depth = do
        b <- G.getWord8
        -- if it's a pointer we need to decode it
        if b .&. 0xc0 == 0xc0
           then do b2 <- G.getWord8
                   let offset = ((fromIntegral $ b .&. 0x3f) `shiftL` 8) .|. fromIntegral b2
                   if offset >= B.length packet
                      then fail "Invalid DNS label pointer"
                      else case G.runGet (getLabel (depth + 1)) $ B.drop offset packet of
                                (Left error, _) -> fail error
                                (Right l, _) -> return l
           else if b == 0
                   then return []
                   else do l <- G.getByteString $ fromIntegral b
                           rest <- getLabel depth
                           return $ (map w2c $ B.unpack l) : rest
  getLabel (0 :: Int)

serialiseQuestion :: B.ByteString  -- ^ the encoded name (see @serialiseDNSName@)
                  -> DNSType  -- ^ the type of the question
                  -> P.Put
serialiseQuestion s ty = do
  P.putByteString s
  P.putWord16be $ fromIntegral $ fromEnum ty
  P.putWord16be 1

parseQuestion :: B.ByteString -> G.Get (String, DNSType)
parseQuestion packet = do
  name <- parseDNSName packet
  ty <- parseDNSType
  G.getWord16be

  return (fromDNSName name, ty)

parseDNSType :: G.Get DNSType
parseDNSType = do
  ty <- G.getWord16be >>= return . toEnum . fromIntegral
  case ty of
       UnknownDNSType -> fail "Unknown DNS type in question"
       _ -> return ty

deserialiseQuestion :: B.ByteString -> G.Get ([String], DNSType)
deserialiseQuestion packet = do
  name <- parseDNSName packet
  ty <- parseDNSType
  G.getWord16be

  return (name, ty)

parseGenericRR :: B.ByteString -> G.Get ([String], DNSType, Word32, B.ByteString)
parseGenericRR packet = do
  name <- parseDNSName packet
  ty <- parseDNSType
  clas <- G.getWord16be
  when (clas /= 1) $ fail "Bad class in RR"
  ttl <- G.getWord32be
  rlen <- G.getWord16be
  bytes <- G.getByteString $ fromIntegral rlen

  return (name, ty, ttl, bytes)

type Entry = ([String], Word32, RR)

parseRR :: B.ByteString -> G.Get Entry
parseRR packet = do
  (name, ty, ttl, bytes) <- parseGenericRR packet
  let parseMany :: G.Get a -> G.Get [a]
      parseMany parser = do
        emptyp <- G.isEmpty
        if emptyp
           then return []
           else do v <- parser
                   rest <- parseMany parser
                   return $ v : rest
      parseIP = G.getWord32be >>= return . htonl
      parseA = parseMany parseIP
      parseAAAA = parseMany $ do
        a <- parseIP
        b <- parseIP
        c <- parseIP
        d <- parseIP
        return (a, b, c, d)

      parseName = parseDNSName packet
      parseMX = parseMany $ do
        pref <- G.getWord16be
        name <- parseDNSName packet
        return (fromIntegral pref, name)

      parseSOA = do
        name <- parseDNSName packet
        rname <- parseDNSName packet
        serial <- G.getWord32be
        refresh <- G.getWord32be
        retry <- G.getWord32be
        expire <- G.getWord32be
        minimum <- G.getWord32be

        return $ RRSOA name rname serial refresh retry expire minimum

      parseTXT = do
        length <- G.getWord8
        G.getByteString (fromIntegral length) >>= return

  let parse = case ty of
                   A -> parseA >>= return . RRA
                   NS -> parseName >>= return . RRNS
                   CNAME -> parseName >>= return . RRCNAME
                   SOA -> parseSOA
                   PTR -> parseName >>= return . RRPTR
                   MX -> parseMX >>= return . RRMX
                   TXT -> parseTXT >>= return . RRTXT
                   AAAA -> parseAAAA >>= return . RRAAAA
  let (err, _) = G.runGet parse bytes
  case err of
       Left error -> fail error
       Right rr -> return (name, ttl, rr)

data Packet = Packet Header [(String, DNSType)] [Entry] [Entry] [Entry]
            deriving (Show)

parsePacket :: B.ByteString -> Either String Packet
parsePacket input = fst $ G.runGet (do
  header <- parseHeader
  a <- sequence $ replicate (headQuestionCount header) $ parseQuestion input
  b <- sequence $ replicate (headAnswerCount header) $ parseRR input
  c <- sequence $ replicate (headNSCount header) $ parseRR input
  d <- sequence $ replicate (headAdditionalCount header) $ parseRR input

  return $ Packet header a b c d) input
