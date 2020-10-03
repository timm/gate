-- vim : ft=lua ts=2 sw=2 et:

--- Library Functions

keys=nil

--- Return a number that is not above or below `lo` or `hi`.
-- If outside that range, return one of `lo` and `hi`.
--  @number z
--  @number lo
--  @number hi
--  @return number
function cap(z,lo,hi)    
  if     z < lo then return lo
  elseif z > hi then return hi
  else               return z end
end

--- Return a deep copy of `obj` (avoiding infinite loops).
-- @tab t 
-- @return the copy
function copy(obj)
  local old,new
  if type(obj) ~= 'table' then return obj end
  if old and old[obj] then return old[obj] end
  old, new = old or {}, {}
  old[obj] = new
  for k, v in pairs(obj) do new[copy(k, old)]=copy(v, old) end
  return setmetatable(new, getmetatable(obj))
end

--- Return a real number within bounds `lo` and `hi`.
--  @number lo
--  @number hi
--  @return float
function from(lo,hi) return lo+(hi-lo)*math.random() end

--- Round a number to a positive integer.
--  @number x
--  @return  int
function int(x)        return (x+0.5)//1 end

--- Iterator: returns the key/values of a `table`,
-- sorted by they `key`.
-- @tab t
-- @return func
function keys(t)
  local i,u = 0,{}
  for k,_ in pairs(t) do u[#u+1] = k end
  table.sort(u)
  return function () 
    if i < #u then 
      i = i+1
      return u[i], t[u[i]] end end 
end 

--- Recursively print a table `t`, with indentation.
-- @tab t 
-- @string pre : what to write before the table
-- @string indent : defaults to `""` then grows with recursion.
function oo(t,pre,    indent)
  local pre    = pre or ""
  local indent = indent or 0
  if indent < 10 then
    for k, v in keys(t or {}) do
      if not (type(k)=='string' and k:match("^_")) then
        if not (type(v)=='function') then
          local fmt = pre..string.rep("|  ",indent)..tostring(k)..": "
          if type(v) == "table" then
            print(fmt)
            oo(v, pre, indent+1)
          else
            print(fmt .. tostring(v)) end end end end end
end

--- Return a real number `z` wrapped within `lo` and `hi`.
--  @number z
--  @number lo
--  @number hi
--  @return number
function within(z,lo,hi) 
  return (z>=lo and z<=hi) and z or lo+z%(hi-lo) end
