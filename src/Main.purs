module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Interop (message, greet)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log message
  log $ greet "from Purescript"
