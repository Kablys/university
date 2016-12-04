module Ex1
where

import Test.QuickCheck
-- 1 
nAnd :: Bool -> Bool -> Bool
nAnd x y = not (x && y)

nAnd' :: Bool -> Bool -> Bool
nAnd' x y
  | x == True && y == True = False
  | otherwise             = True

nAnd'' :: Bool -> Bool -> Bool
nAnd'' False False = True
nAnd'' False True = True
nAnd'' True False = True
nAnd'' True True = False


-- 2 
prop_nAnd :: Bool -> Bool -> Bool
prop_nAnd x y =
  nAnd x y == nAnd' x y && nAnd' x y == nAnd'' x y

prop_nAnd' :: Bool -> Bool -> Bool
prop_nAnd' x y =
  nAnd x y /= (x && y)

-- 3
nDigits :: Integer -> Int
nDigits x = length (show (abs x))
-- is paskaitos
nDigits' :: Integer -> Int
nDigits' n
  | (n >= (-9)) && (n <= 9) = 1
  | otherwise = nDigits (n `div` 10) + 1


-- 4
nRoots :: Float -> Float -> Float -> Int
nRoots a b c
  | a == 0.0 = error "the first argument should be non-zero!"
  | b ** 2 > 4.0*a*c = 2
  | b ** 2 == 4.0*a*c = 1
  | b ** 2 < 4.0*a*c = 0
  | otherwise = error "You missed something in ex 5"

-- 5 
smallerRoot :: Float -> Float -> Float -> Float
smallerRoot a b c
  | n == 2 = minimum [(((-b) - part)/(2*a)), (((-b) + part)/(2*a))]
  | n == 1 = (-b)/(2*a)
  | n == 0 = error "Result does not exists"
  where
    n = nRoots a b c
    part = sqrt(b ** 2 - 4.0*a*c)

largerRoot :: Float -> Float -> Float -> Float
largerRoot a b c
  | n == 2 = maximum [(((-b) - part)/(2*a)), (((-b) + part)/(2*a))]
  | n == 1 = (-b)/(2*a)
  | n == 0 = error "Result does not exists"
  where
    n = nRoots a b c
    part = sqrt(b ** 2 - 4.0*a*c)
-- 6
power2 :: Integer -> Integer
power2 n
  | n <= 0 = 0
  | n == 1 = 2
  | n > 0 = 2 * power2(n-1)
  | otherwise = error "You missed something in ex 6"
-- 7
mult :: Integer -> Integer -> Integer
mult n m
  | n == 0 || m == 0 = 0
  | m > 0 = n + mult n (m-1)
  | n > 0 && m < 0 = mult m n
  | n < 0 && m < 0 = mult (-n) (-m)
  | otherwise = error "You missed something in ex 7"

-- 8
-- fact x = product [1..x]
fact :: Integer -> Integer
fact x
  | x < 0 = error "Negative argument"
  | x == 0 = 1
  | x > 0 = x * fact (x-1)
prod :: Integer -> Integer -> Integer
prod m n
  | m <= 0 || n <= 0 = error "negative rage"
  | m <= n = fact n `div` fact (m-1)
  | m > n = error "Wrong range"
  | otherwise = error "You misssed something in ex 8"
