
local sample={}

function sample.rnd(x) return math.floor((x+0.5)//1) end
function sample.r()    return math.random() end
function sample.u(x,y) return x+(y-x)*sample.r() end

function sample.tri(a,mode,b)
  local c   = (mode-a)/(b-a) -- convert mode to 0..1
  local u,v = sample.r(), sample.r()
  c= (1-c)*math.min(u,v) + c*math.max(u,v)
  return a+(b-a)*c -- inject back into range
end

function sample.weilbull(lo,hi,k,l)
  local x = sample.u(lo,hi)
  if x<0 then return 0 end
  return (k/l)*(x/l)^(k-1)*math.exp(-1*(x/l)^k)
end

function sample.norm(mu,sd) 
  local r = math.random
  mu = mu or 0
  sd = sd or 1
  return mu + sd * ((-2 * math.log(sample.r()))^0.5 
                        * math.cos(6.2831853*sample.r()))
end

function sample.bars(t)
  local total, tmp = 0, {}
  for key,one in pairs(t) do
    tmp[ #tmp+1 ] = {key=key, weight=one}
    total = total + one 
  end
  table.sort(tmp, function (x,y) return x.weight < y.weight end)
  return function ()
    local r = math.random()
    for _,x in pairs(tmp) do
      r = r - x.weight / total
      if r<=0 then return x.key end end end
end

function sample.interpolate(t)
  local bars= {}
  for i=2,#t do
    local x1= t[i-1][1]
    local x2= t[i  ][1]
    bars[{x1,x2}] = (x2-x1)*t[i-1][2]
  end
  local f=sample.bars(bars)
  return function()
    local bar=f()
    return sample.u(bar[1],bar[2])
  end
end

--z=f0(y1,y2...)
--y1=f1(x1),
--y2=f2(x2)

m={g=function(i) return i.a + i.b / i.c end, 
   x={a={lo=10,hi=20,  weilbull={5,1}},
      b={lo=10,hi=20,  norm={15,2}},
      c={lo=0,hi=20,   sample={{0,0},{1,10},{2,10},{20,0}}}}}


return sample
