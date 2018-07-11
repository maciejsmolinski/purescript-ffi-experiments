module Interpreter where

import Prelude

data Program a = Get (a -> Program a)
                | Put a (Unit -> Program a)
                | Done a


program :: Program String
program = Get $ \value -> Put value (\_ -> Done value)

interpret :: Program String -> String
interpret (Get fn) = "Get, " <> interpret (fn "string")
interpret (Put val fn) = "Put " <> val <> ", " <> interpret (fn unit)
interpret (Done a) = "Done " <> a <> ","