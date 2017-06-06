module Main (
    main
) where

import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.HUnit

import FunctorTests

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
    testGroup "Functors"
    [ testProperty "Functor preserves identity morphism"        propPreserveIdentityMorphism
    , testProperty "Functor preserves composition of morphisms" propPreserveCompositionOfMorphisms ]
