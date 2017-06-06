module FunctorTests where

import Test.QuickCheck
import Test.QuickCheck.Function

propPreserveIdentityMorphism :: Maybe Int -> Bool
propPreserveIdentityMorphism functor = left == right
    where left  = fmap id functor
          right = id functor

propPreserveCompositionOfMorphisms :: (Fun Int Int) -> (Fun Int Int) -> Maybe Int -> Bool
propPreserveCompositionOfMorphisms (Fun _ f) (Fun _ g) functor = left == right
    where left  = fmap (f . g) functor
          right = fmap f (fmap g functor)
