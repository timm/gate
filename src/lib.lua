-- vim: ft=lua ts=2 sw=2 et:

--- Library Functions

local lib={}

--- Return a number that is not above or below `lo` or `hi`.
-- If outside that range, return one of `lo` and `hi`.
--  @number z
--  @number lo
--  @number hi
--  @return number
function lib.cap(z,lo,hi)    
  if     z < lo then return lo
  elseif z > hi then return hi
  else               return z end
end

--- Return a deep copy of `obj` (avoiding infinite loops).
-- @param obj 
-- @return the copy
function lib.copy(obj)
  local old,new
  if type(obj) ~= 'table' then return obj end
  if old and old[obj] then return old[obj] end
  old, new = old or {}, {}
  old[obj] = new
  for k, v in pairs(obj) do new[lib.copy(k, old)]=lib.copy(v, old) end
  return setmetatable(new, getmetatable(obj))
end

--- Return a real number within bounds `lo` and `hi`.
--  @number lo
--  @number hi
--  @return float
function lib.from(lo,hi) return lo+(hi-lo)*math.random() end

--- Round a number to a positive integer.
--  @number x
--  @return  int
function lib.int(x)        return (x+0.5)//1 end

--- Iterator: returns the key/values of a `table`,
-- sorted by they `key`.
-- @tab t
-- @return func
function lib.keys(t)
  local i,u = 0,{}
  for k,_ in pairs(t) do u[#u+1] = k end
  table.sort(u)
  return function () 
    if i < #u then 
      i = i+1
      return u[i], t[u[i]] end end 
end 

local l,r,c=math.log,math.random, math.cos
--- Sample from a normal distribution
-- @number mu : defaults to 0
-- @number sd : defaults to 1
-- @returns number
function lib.norm(mu,sd) 
  local r = math.random
  mu = mu or 0
  sd = sd or 1
  return mu + sd*(-2*l(r()))^0.5*c(6.2831853*r()) 
end

--- Print a table on one line
-- @tab t : table to print
-- @string pre : some text to prepend to the output (defaults to "")
function lib.o(t,pre)
  local s, sep = "", ""
  for _,v in pairs(t or {}) do s = s..sep..tostring(v); sep=", " end
  print((pre or "") .. '{' .. s .. '}')
end

--- Recursively print a table `t`, with indentation.
-- @tab t 
-- @string pre : what to write before the table
-- @string indent : defaults to `""` then grows with recursion.
function lib.oo(t,pre,    indent)
  local pre    = pre or ""
  local indent = indent or 0
  if indent < 10 then
    for k, v in lib.keys(t or {}) do
      if not (type(k)=='string' and k:match("^_")) then
        if not (type(v)=='function') then
          local fmt = pre..string.rep("|  ",indent)..tostring(k)..": "
          if type(v) == "table" then
            print(fmt)
            lib.oo(v, pre, indent+1)
          else
            print(fmt .. tostring(v)) end end end end end
end

--- Report rogue locals
function lib.rogues()
  local ignore= {
        the=true,      tostring=true,  tonumber=true, assert=true,
        rawlen=true,   pairs=true,     ipairs=true,
        pcall=true,    type=true,      print=true,
        rawequal=true, setmetatable=true, require=true, load=true,
        rawset=true,   next=true,      getmetatable=true,
        select=true,   error=true,     dofile=true, loadfile=true,
        jit=true,      utf8=true,      math=true, package=true,
        table=true,    coroutine=true, bit=true,  os=true,
        io=true,       bit32=true,     string=true,
        arg=true,      debug=true,     _VERSION=true, _G=true,
        collectgarbage=true, xpcall=true,    rawget=true,
  }
  for k,v in pairs( _G ) do
    if not ignore[k] then
      if k:match("^[^A-Z]") then
        print("-- ROGUE ["..k.."]")  end end end end

function lib.round(num, places)
  local mult = 10^(places or 0)
  return math.floor(num * mult + 0.5) / mult
end


--- Polymorphic dispatching
-- @fun klass : meta class
-- @tab inits : `key`/`value` initializations
function lib.uses(klass,has)
  local new = lib.copy(klass or {})
  for k,v in pairs(has or {}) do new[k] = v end
  setmetatable(new, klass)
  klass.__index = klass
  return new
end

--- Return a real number `z` wrapped within `lo` and `hi`.
--  @number z
--  @number lo
--  @number hi
--  @return number
function lib.within(z,lo,hi) 
  return (z>=lo and z<=hi) and z or lo+z%(hi-lo) end

return lib
