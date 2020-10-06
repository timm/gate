local s={}

local r = math.random

function s.tri(a,mode,b)
  local c   = (mode-a)/(b-a) -- convert mode to 0..1
  local u,v = r(), r()
  c= (1-c)*math.min(u,v) + c*math.max(u,v)
  return a+(b-a)*c -- inject back into range
end

function s.norm(mu,sd) 
  mu = mu or 0
  sd = sd or 1
  return mu + sd * ((-2 * math.log(r()))^0.5 
                        * math.cos(2*math.pi*r()))
end

function s.bars(t)
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

function s.interpolate(t)
  local bars= {}
  for i=2,#t do
    local x1= t[i-1][1]
    local x2= t[i  ][1]
    bars[{x1,x2}] = (x2-x1)*t[i-1][2]
  end
  local f=s.bars(bars)
  return function()
    local bar=f()
    local x1,x2 = bar[1],bar[2]
    return x1 + (x2-x1)*math.random()
  end
end

function s.g(xy)
  xy.y={}
  for k,x in pairs(xy.x) do xy.x[x]=xy.meta.x[k].cap(x)     end
  for k,y in pairs(xy.y) do xy.y[k]=xy.meta.y[k].eval(xy.x) end
  return xy
end

function s.f(model)
  local xy =  {meta=meta,x={},y={}}
  for k,x in pairs(model.x) do xy.x[k] = x.eval() end
  for k,y in pairs(model.y) do xy.y[k] = y.eval(out.x) end
  return xy
end

function s.cap(x,lo,hi)  return x<lo and lo or x>hi and hi or x end
function s.wrap(x,lo,hi) return lo + x % (hi-lo) end

function s.uniformed(lo,hi,cap)
  return {f= "uniform", 
          cap = cap and s.cap or s.wrap,
          eval= function() return lo+(hi-lo)*math.random() end,
          lo= lo, hi= hi} end

function s.normaled(mu,sd,cap)
  return {f="normal", 
          cap = cap and s.cap or s.wrap,
          eval=function() return s.norm(mu,sd) end,
          lo=mu-3*sd, hi=mu+3*sd,mu=mu,sd=sd} end

function s.tried(lo,mode,hi,cap)
  return {f="triangular", 
          cap = cap and s.cap or s.wrap,
          eval=function() return s.tri(lo,mode,hi)  end,
          lo=lo, hi=hi,mode=mode} end

function s.interpolated(bars,cap)
  return {f="normal", 
          cap = cap and s.cap or s.wrap,
          eval= s.interpolate(bars) ,
          lo=bars[1][1], hi=bars[#bars][1] } end

return s
