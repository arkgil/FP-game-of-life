module Main (
    main
) where

import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.HUnit

import FunctorTests
import ApplicativeTests
import MonadTests

main :: IO ()
main = defaultMain tests

tests :: TestTree

tests = testGroup "Tests" [functors, applicatives, monads]

functors =
    testGroup "Functors"
    [ testProperty "Functor preserves identity morphism"        propPreserveIdentityMorphism
    , testProperty "Functor preserves composition of morphisms" propPreserveCompositionOfMorphisms ]

monads =
    testGroup "Monads"
    [ testProperty "Left identity"  propMonadLeftIdentity
    , testProperty "Right identity" propMonadRightIdentity
    , testProperty "Associativity"  propMonadAssociativity ]

applicatives =
  testGroup "Applicatives"
  [testCase     "Identity of list applicative"      listApplicativeIdentity
  , testCase     "Homomorphism of list applicative" listApplicativeHomomorphism
  , testCase     "Interchange of list applicative"  listApplicativeInterchange
  , testCase     "Composition of list applicative"  listApplicativeComposition ]
