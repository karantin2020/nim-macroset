import macros

# ---

macro `{}`*(T:typedesc, params:varargs[typed]): untyped =
  ## This macro converts a type and a variable array of
  ## expressions into an object constructor for that type.
  ## As example:
  ## 
  ## .. code-block:: nim
  ##   type
  ##     Foo = object
  ##       a: int
  ##       b: string
  ##
  ##   let f = Foo { 123, "four" }
  ## 

  # echo repr getType(T)
  let objType = getType(T)[1] # extracts the 'type name' symbol from `T`
  # echo repr getType(objType)
  let objRecs = getType(objType)[1] # extracts the 'object records' node from `T`
  assert objRecs.len == params.len # ensure number of records match incoming parameters
  
  # make the result an 'ObjConstr' node with `T` as it's first child
  result = newNimNode(nnkObjConstr).add(objType)
  
  # iterate through T's records and add an 'ExprColonExpr' node for each record/param pair
  for i in 0 .. <objRecs.len:
    let rec = objRecs[i] # current record
    let par = params[i] # current parameter
    assert sameType(rec, par) # ensure record and parameter are the same type
    result.add newNimNode(nnkExprColonExpr).add(rec, par)

# ---

