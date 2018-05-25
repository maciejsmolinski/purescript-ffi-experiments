module Interop where

import Control.Monad.Eff (Eff, kind Effect)
import Data.Unit (Unit)


foreign import data RENDER :: Effect

foreign import render :: forall eff. String -> Eff (render :: RENDER | eff) Unit

