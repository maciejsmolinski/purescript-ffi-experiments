module Interop where

import Control.Monad.Eff (Eff, kind Effect)
import Data.Unit (Unit)


foreign import data HTML :: Effect

foreign import render :: forall eff. String -> Eff (html :: HTML | eff) Unit

foreign import append :: forall eff. String -> Eff (html :: HTML | eff) Unit

foreign import succeed :: forall eff. (String -> Eff eff Unit) -> (String -> Eff eff Unit) -> Eff eff Unit

foreign import fail :: forall eff. (String -> Eff eff Unit) -> (String -> Eff eff Unit) -> Eff eff Unit