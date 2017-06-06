module ApplicativeTests where

import Test.HUnit

listApplicativeIdentity = a @=? pure id <*> a
  where a = [1, 2, 3]

listApplicativeHomomorphism = [result] @=? [f] <*> [val]
  where f      = (+1)
        val    = 1
        result = f 1

listApplicativeInterchange = [f] <*> [val] @=? [($ val)] <*> [f]
  where f   = (+1)
        val = 1

listApplicativeComposition = [f1] <*> ([f2] <*> [val]) @=? [(.)] <*> [f1] <*> [f2] <*> [val]
  where f1  = (+1)
        f2  = (*2)
        val = 1
