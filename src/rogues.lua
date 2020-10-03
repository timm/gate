local ignore= {
      the=true,            tostring=true,  tonumber=true, assert=true,
      rawlen=true,         pairs=true,     ipairs=true,
      collectgarbage=true, xpcall=true, rawget=true,
      pcall=true,          type=true,      print=true,
      rawequal=true,       setmetatable=true, require=true, load=true,
      rawset=true,         next=true, getmetatable=true,
      select=true,         error=true,     dofile=true, loadfile=true,
      jit=true,            utf8=true,      math=true, package=true,
      table=true,          coroutine=true, bit=true, os=true,
      io=true,             bit32=true,        string=true,
      arg=true,            debug=true, _VERSION=true, _G=true,
}

return function()
   for k,v in pairs( _G ) do
     if not ignore[k] then
       if k:match("^[^A-Z]") then
         print("-- ROGUE ["..k.."]")  end end end end
