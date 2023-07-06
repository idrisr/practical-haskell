module Main where

import MyLib (ack)
import System.Environment
import Control.Monad
import Data.Char

isLegit :: String -> Bool
isLegit = all isDigit

toDigit :: Char -> Maybe Int
toDigit '0' = Just 0
toDigit '1' = Just 1
toDigit '2' = Just 2
toDigit '3' = Just 3
toDigit '4' = Just 4
toDigit '5' = Just 5
toDigit '6' = Just 6
toDigit '7' = Just 7
toDigit '8' = Just 8
toDigit '9' = Just 9
toDigit _ = Nothing

convert :: String -> Maybe [Int]
convert = mapM toDigit

convert2 :: [Int] -> Int
convert2 xs = sum zs
    where ys = zip (reverse xs) [(0::Int)..]
          zs = map (\(a, b) -> a * 10^b) ys

main :: IO ()
main = do
    args <- getArgs
    unless (length args == 2) $ do
        mapM_ putStrLn
            ["Usage:" , "\t./ackermann m n" ]
        error "please supply 2 arguments"
    let (m, n) = case args of
            (a:b:_) | all isLegit [a, b] -> (a, b)
            _ -> error "please provide legit ints"
        x = fmap convert2 . convert $ m
        y = fmap convert2 . convert $ n
    print $ ack <$> x <*> y
