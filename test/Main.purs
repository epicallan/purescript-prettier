module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)
import Text.Prettier (check, defaultOptions, format)

main :: Eff (RunnerEffects ()) Unit
main = run [consoleReporter] do

  describe "Prettier" do

    describe "format" do
      it "should format with default options" do
        format defaultOptions "const a=1" `shouldEqual` "const a = 1;\n"

      it "should handle custom options" do
        format (defaultOptions { semi = false }) "const a=1" `shouldEqual` "const a = 1\n"

    describe "check" do
      it "should check if the file has been formatted with Prettier" do
        check defaultOptions "const a = 1;\n" `shouldEqual` true
        check (defaultOptions { semi = false }) "const a = 1;\n" `shouldEqual` false
