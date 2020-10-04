local eg=require("eg").all
local oo=require("lib").oo
local add=require("col").add
local Sym=require("sym")

eg {sym1=function(s)
   s=Sym.new()
   for _,v in pairs {"a","a","a","a","b","b","c"} do add(s,v) end
   assert(s.seen.a == 4)
   assert(s.n == 7)
   assert(s.mode == "a")
end}
  
