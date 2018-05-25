module Test.Interop where

import Prelude

import Interop as I
import Test.Unit (TestSuite, describe, it)
import Test.Unit.Assert (shouldEqual)

main :: forall eff. TestSuite (eff)
main = do
  describe "interop" do

    it "should have a message" do
      I.message `shouldEqual` "Hello from JS!"

    it "should return Hello <msg> from the greet method" do
      (I.greet "World") `shouldEqual` "Hello World"

    it "should hold a default User instance" do
      case (I.user) of
        (I.MkUser { name }) -> name `shouldEqual` "JavaScriptOne"

