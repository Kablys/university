module Ex3
where

import Data.Char
import Data.List

--1
subst :: String -> String -> String -> String
subst [] _ _ = []
subst startStr old new
  | old `isInfixOf` startStr = replace startStr
  | otherwise = startStr
  where
    replace [] = []
    replace str =
      let (prefix, rest) = splitAt (length old) str
      in
        if old == prefix
        then new ++ replace rest
        else head str : replace (tail str)

--2
isPalin :: String -> Bool
isPalin word = processedWord == reverse processedWord  
  where
    processedWord = [toLower x | x <- word, isLetter x]

--3
count :: String -> (Int, Int, Int)
count s = (length [ x | x <- s, not(isSeparator x)], length (words s),length (elemIndices '\n' s))

--4
justify :: String -> Int -> String
justify s i = addNewlines (filter (/='\n') s) i
  where
    addNewlines str index
      | index < 0 = error "Word to long"
      | length str < index = str
      | isSeparator ( str !! index ) =  prefix ++ "/n" ++ addNewlines subfix i 
      | otherwise = addNewlines str (index - 1)
      where
        (prefix,subfix) = splitAt (index+1) str

--5
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

overlaps :: Shape -> Shape -> Bool
overlaps (Circle p1 f1) (Circle p2 f2) = pointDist p1 p2 > (f1 + f2)
overlaps (Rectangle (Point x11 y11) (Point x12 y12)) (Rectangle (Point x21 y21) (Point x22 y22)) 
  = not ( y12 < y21 || y11 > y22 || x12 < x21 || x11 > x22 )
overlaps (Rectangle (Point x1 y1) (Point x2 y2)) (Circle (Point x3 y3 ) r)
  = y2 > (y3 + r) || y1 < (y3 - r) || x1 > (x3 + r) || x2 < (x3 - r)
  -- 
overlaps  c@(Circle _ _) r@(Rectangle _ _) = overlaps (Rectangle _ _) (Circle _ _)

pointDist :: Point -> Point -> Float 
pointDist (Point x1 y1) (Point x2 y2) = sqrt ((x1 - x2)**2 + (y1 - y2)**2 )


--6
data Status = Loaned | Free | Locked 
  deriving (Show, Eq)
data Book = Book String Integer 
  deriving (Show, Eq)
data Person = Person Integer 
  deriving (Show, Eq)
type Taken = (Person, Book)
type LibBook = (Book, Status)
loan :: Person -> Book -> ([Taken],[LibBook]) -> ([Taken],[LibBook])
loan p@(Person id) b@(Book name num) lib@(t,l) = if Free == snd onlyBook 
                                             then (map (\x -> if (==b)(snd x) then (p,snd x) else x) t,(b,Loaned) : otherBooks) 
                                             else lib
  where
  onlyBook = head (filter ((==b).fst) l)
  otherBooks = filter ((/=b).fst) l

