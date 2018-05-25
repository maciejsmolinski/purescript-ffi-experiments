module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import DOM (DOM)
import Interop (User(..), greet, message, user, render, RENDER) as I
import PS as PS

greetUser :: I.User -> String
greetUser = I.greet <<< show

main :: forall e. Eff (console :: CONSOLE, render :: I.RENDER, dom :: DOM | e) Unit
main = do
  log I.message
  log $ I.greet "from Purescript"
  log $ greetUser I.user
  log $ greetUser $ I.MkUser { name: "PureScriptOne" }
  I.render "Message rendered using PureScript FFI"
  PS.render "Message rendered using PureScript-DOM"