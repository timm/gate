local eg=dofiled("lib/eg").all
local oo=dofiled("lib/misc").oo
local add=dofiled("cols/col").add
local Sym=dofiled("cols/sym")

eg {sym1=function(s)
   s=Sym.new()
   for _,v in pairs {"a","a","a","a","b","b","c"} do add(s,v) end
   assert(s.seen.a == 4)
   assert(s.n == 7)
   assert(s.mode == "a")
end}
  
