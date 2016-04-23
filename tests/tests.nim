import os, osproc, unittest, ../src/macroset

const path = splitPath(currentSourcePath()).head & "/../src/macroset"

test "can compile macroset":
  check execCmdEx("nim c " & path).exitCode == QuitSuccess


test "object macro constructor is equal to object constructor":
  type
    Foo = object
      a: int
      b: string
  let f = Foo { 123, "four" }
  let g = Foo(a:123, b:"four")  
  check(f == g)

