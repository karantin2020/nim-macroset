# Package

version       = "0.1.0"
author        = "karantin2020"
description   = "Set of general purpose macros"
license       = "MIT"

srcDir = "src"

# Dependencies

requires "nim >= 0.12.1"

task tests, "Run the macroset tests":
  withDir "tests":
    exec "nim c -r tests"

task docs, "Make docs":
  exec "nim doc -o:./docs/macroset.html ./src/macroset.nim"