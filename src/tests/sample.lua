local lib=dofiled("lib/misc")
local eg=dofiled("lib/eg").all
local s=dofiled("lib/sample")

local function rnd(x) return (x+0.5)//1 end

function bar1(    f,a)
  a,f = {}, s.bars {a=1,b=2,c=4}
  for i=1,20 do a[#a+1]= f() end
  table.sort(a)
  print(table.concat(a))
end

function tri1(   a)
  a={}
  for i=1,256 do a[#a+1] = rnd(s.tri(1,3,10)) end
  table.sort(a)
  print(table.concat(a))
end

function sample1(   f,a)
  a,f={},s.interpolate{{1,5},{2,20},{3,5},{4,5},{8,5}}
  for i=1,2048 do 
     local x = rnd(f())
     a[x] = (a[x] or 0) + 1 
  end
  for i,j in pairs(a) do print(i,j) end
end

local u  = s.uniformed
local n  = s.normaled
local t  = s.tried
local i  = s.interpolated
local w  = s.wrap
local c  = s.controllable
local b  = function(z) return w(c(z)) end

m={y={f1 = {eval = function(z) 
                     return z.a/(z.b+z.c) * z.d end,
            more = true}},
   x={a  = b(u(1,20)),
      b  = b(n(15,2)),
      c  = b(t(10,20,50)),
      d  = b(i({{0,0},{1,10},{2,10},{20,0}}))}}

lib.oo(s.f(m))

function walk(xy,k)
  xs = xy.meta.x
  lo,hi = xs[k].lo, xs[k].hi
  for i= lo,hi,(hi-lo)/10 do
    update(xyxxx
    asdasd)
    
end
function mws(m)
  local xs={}
  for k,x in pairs(m.x) do if x.use then xs[#xs+1]=k end end
end
