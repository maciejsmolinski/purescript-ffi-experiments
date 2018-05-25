module Interop where

import Data.Show

import Control.Monad.Eff (Eff, kind Effect)
import Data.Unit (Unit)


foreign import message :: String

foreign import greet :: String -> String

foreign import user :: User

newtype User = MkUser { name :: String }

instance showUser :: Show User where
  show (MkUser { name }) = name

foreign import data RENDER :: Effect

foreign import render :: forall eff. String -> Eff (render :: RENDER | eff) Unit

