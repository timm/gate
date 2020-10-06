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

--eg {bar1=bar1, tri1=tri1, sample1=sample1}

m={y={f1={eval=function(z) return z.a/(z.b+z.c) * z.d end,
          more=true}},
   x={a=s.uniformed(1,20),
      b=s.normaled(15,2),
      c=s.tried(10,20,50),
      d=s.interpolated({{0,0},{1,10},{2,10},{20,0}})}}

--for i=lib.oo(s.f(m))

