local lib=dofiled("lib/misc")

local sim={}
function sim.rnd(x) return (x+0.5)//1 end
function sim.r()    return math.random() end
function sim.u(x,y) return x+(y-x)*r() end

d={{.0,.0},{.1,.1},{.2,.4 },{.3,.8},
   {.4,.4},{.5,.1},{.8,.05}}

function sim.tri(a,mode,b)
  local c   = (mode-a)/(b-a) -- convert mode to 0..1
  local u,v = sim.r(), sim.r()
  c= (1-c)*math.min(u,v) + c*math.max(u,v)
  return a+(b-a)*c -- inject back into range
end

function sim.sample(d)
  local a,x1,x2,y1,y2,m,b
  a = sim.r(#d-1)
  x1,y1= d[a  ][1], d[a  ][2]
  x2,y2= d[a+1][1], d[a+1][2]
  m    = (y2-y1)/(x2-x1)
  b    = y1 - m*x1
  return m*sim.u(x1,x2) + b
end

--- Report height on a normal curve. If above
-- or below mean plus-or-minus 4 standard deviations,
-- then return 0.
-- @number x 
-- @number mu
-- @number sd
-- @return  number
function sim.weilbull(lo,hi,k,l)
  local x = sim.u(lo,hi)
  if x<0 then return 0 end
  return (k/l)*(x/l)^(k-1)*math.exp(-1*(x/l)^k)
end

--- Sample from a normal distribution
-- @number mu : defaults to 0
-- @number sd : defaults to 1
-- @returns number
function lib.norm(mu,sd) 
  local r = math.random
   mu = mu or 0
   sd = sd or 1
   return mu + sd*(-2*math.log(sim.r()))^0.5*\
                   math.cos(6.2831853*sim.r()) 
  end
end

-- A function has ranges, a function and a populate

local fun={}

fun.ranges={
     x={a={0,10},
        b={0,10},
        c={0,10}}}




function fun.one()
  local i = {x={}, y={}}
  for k,v in pairs(fun.ranges) do 
     if v[1] ~= 0 then
       i.y[k]=fun.eval(v) end end
  return i
end
