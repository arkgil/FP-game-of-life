module Main (
    main
) where

import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.HUnit

import FunctorTests
import MonadTests

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [functors, monads]

functors =
    testGroup "Functors"
    [ testProperty "Functor preserves identity morphism"        propPreserveIdentityMorphism
    , testProperty "Functor preserves composition of morphisms" propPreserveCompositionOfMorphisms ]

monads =
    testGroup "Monads"
    [ testProperty "Left identity"  propMonadLeftIdentity
    , testProperty "Right identity" propMonadRightIdentity
    , testProperty "Associativity"  propMonadAssociativity ]
