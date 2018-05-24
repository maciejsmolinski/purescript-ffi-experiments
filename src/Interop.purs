module Interop where

import Data.Show

foreign import message :: String

foreign import greet :: String -> String

foreign import user :: User

newtype User = MkUser { name :: String }

instance showUser :: Show User where
  show (MkUser { name }) = name