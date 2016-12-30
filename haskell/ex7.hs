module Ex7 where

import Data.Map.Strict (Map, (!), keys, fromList)

-- 1
data Stream a = Cons a (Stream a)
streamtoList :: Stream a -> [a]
streamtoList (Cons a s) = a:streamtoList s
streamIterate :: (a -> a) -> a -> Stream a
streamIterate f a = Cons el $ streamIterate f el
  where el = f a
streamInterleave :: Stream a -> Stream a -> Stream a
streamInterleave (Cons a1 s1) (Cons a2 s2) = Cons a1 $ Cons a2 $ streamInterleave s1 s2
-- 2
-- Del 3 uzduoties iskeliau
lineToInteger :: IO Integer
lineToInteger = do
  line <- getLine
  return $ read line

sumInts :: Integer -> IO Integer
sumInts val = do
  --line <- getLine
  --let num = read line
  num <- lineToInteger 
  if num == 0
    then
      return val
    else
      sumInts $ val + num 
-- 3
whileIO :: IO a -> (a -> Bool) -> (a -> a -> a) -> a -> IO a
whileIO a term f val = do
  get <- a
  if term get
    then
      return val
    else
      whileIO a term f $ f val get

sumInts' :: Integer -> IO Integer
sumInts' = whileIO lineToInteger (0 ==) (+)

--prop_sumInts :: Integer -> Bool
--prop_sumInts int = sumInts' int == sumInts int 

-- 4
data Expr a = Lit a | EVar Var | Op (Ops a) [Expr a]
type Ops a = [a] -> a
type Var = Char
type Valuation a = Map Char a
eval :: Valuation a -> Expr a -> a
eval _ (Lit a) = a
eval val (EVar var) = val ! var  
eval val (Op op xs) = op (map (eval val) xs)

-- 5 Koks sito uzdavinio pavadinimas
changeInCoins :: Integer -> [Int]
changeInCoins val = interp val' coins
    where
      val' = fromIntegral val :: Int
      coins = [50,20,10,5,2,1]
      interp _ [] = []
      interp x (y:ys) = amount : interp rest ys
        where
          (amount, rest) = divMod x y
-- 6
changeInCoins2 :: Map Integer Integer -> Integer -> Maybe (Map Integer Integer )
changeInCoins2 ref val = fmap fromList (sequence (interp val coins))
    where
      coins = reverse $ keys ref
      interp x []
        | x == 0 = []
        | otherwise = [Nothing] 
      interp x (y:ys) = Just (y, amount) : interp rest ys
        where
          (amount, rest) = divMod x y

