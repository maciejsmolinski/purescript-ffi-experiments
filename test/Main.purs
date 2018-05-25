module Test.Main where

import Prelude
import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Test.Interop as TI
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)

main :: forall eff. Eff (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR | eff) Unit
main = do
  runTest do
    TI.main
