module MonadTests where

import Test.QuickCheck
import Test.QuickCheck.Function

propMonadLeftIdentity :: (Fun Int [Int]) -> Int -> Bool
propMonadLeftIdentity (Fun _ f) x = left == right
    where left  = (return x) >>= f
          right = f x

propMonadRightIdentity :: [Int] -> Bool
propMonadRightIdentity m = left == right
    where left  = m >>= return
          right = m

propMonadAssociativity :: (Fun Int [Int]) -> (Fun Int [Int]) -> [Int] -> Bool
propMonadAssociativity (Fun _ f) (Fun _ g) m = left == right
    where left  = (m >>= f) >>= g
          right = m >>= (\x -> f x >>= g)
