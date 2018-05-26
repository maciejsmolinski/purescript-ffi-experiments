module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Interop as I
import PS as PS

main :: forall e. Eff (html :: I.HTML, dom :: PS.DOM | e) Unit
main = do
  I.render "Message rendered using PureScript FFI"
  PS.render "Message rendered using PureScript-DOM"
  I.append "Message appended using PureScript FFI"