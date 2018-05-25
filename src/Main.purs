module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Interop (User(..), greet, message, user, render, RENDER)

greetUser :: User -> String
greetUser = greet <<< show

main :: forall e. Eff (console :: CONSOLE, render :: RENDER | e) Unit
main = do
  log message
  log $ greet "from Purescript"
  log $ greetUser user
  log $ greetUser $ MkUser { name: "PureScriptOne" }
  render "Message from PureScript!"
