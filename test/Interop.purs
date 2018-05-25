module Test.Interop where

import Test.Unit (TestSuite, describe, it)
import Test.Unit.Assert (shouldEqual)

main :: forall eff. TestSuite (eff)
main = do
  describe "interop" do

    it "should have a dummy test" do
      true `shouldEqual` true
