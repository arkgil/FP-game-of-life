module FunctorTests where

import Test.QuickCheck

propPreserveIdentityMorphism :: Maybe Int -> Bool
propPreserveIdentityMorphism functor = left == right
    where left  = fmap id functor
          right = id functor

propPreserveCompositionOfMorphisms :: (Int -> Int) -> (Int -> Int) -> Maybe Int -> Bool
propPreserveCompositionOfMorphisms f g functor = left == right
    where left  = fmap (f . g) functor
          right = fmap f (fmap g functor)
