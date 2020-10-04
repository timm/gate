local eg=dofiled("lib/eg").all
local oo=dofiled("lib/misc").oo
local add=dofiled("cols/col").add
local Num=dofiled("cols/num")

eg {num1=function(n)
   n=Num.new()
   for _,v in pairs {"a","a","a","a","b","b","c"} do add(s,v) end
   assert(s.seen.a == 4)
   assert(s.n == 7)
   assert(s.mode == "a")
end}
  






local eg=require("eg").all
local oo=require("lib").oo
local Sym=require("sym")
local col=require("col")


eg {num1=function(self)
   s=Sym.new
   for _,v in pairs {"a","a","a","a","b","b","c"} do
   Sym.new())
    assert(1.378 <= s:ent() and s:ent() <= 1.379)
  s=adds({"a","a","a","a","a","a","a"},Sym.new())
  assert(s:ent()==0)
end

function Eg.num()
  local l,r,c=math.log,math.random, math.cos
  local function norm(mu,sd)
    mu, sd = mu or 0, sd or 1
    return mu + sd*(-2*l(r()))^0.5*c(6.2831853*r()) 
  end
  local n=Num.new()
  local mu, sd=10,3
  for _ = 1,1000 do n:add(norm(10,3)) end
  assert(mu*.95<=n.mu and n.mu<=mu*1.05)
  assert(sd*.95<=n.sd and n.sd<=sd*1.05)
end


