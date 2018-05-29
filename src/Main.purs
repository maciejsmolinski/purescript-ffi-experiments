module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Interop as I
import PS as PS


onSuccess :: forall eff. String -> Eff (console :: CONSOLE | eff) Unit
onSuccess value = log $ "Succeeded with " <> value

onFailure :: forall eff. String -> Eff (console :: CONSOLE | eff) Unit
onFailure value = log $ "Failed with " <> value

main :: forall e. Eff (html :: I.HTML, dom :: PS.DOM, console :: CONSOLE | e) Unit
main = do
  I.render "Message rendered with PureScript FFI"
  PS.render "Message rendered with PureScript-DOM"
  I.append "Message appended with PureScript FFI"
  PS.append "Message appended with PureScript-DOM"
  I.succeed onSuccess onFailure
  I.fail onSuccess onFailure
