-- vim: ft=lua ts=2 sw=2 et:

--- Effort and rist estimation
-- For moldes defined in `risk.lua` and `coc.lua`.

local lib= require "lib"
local risk0= require "risk"
local coc0 =  require "coc"

local from,within,int = lib.from, lib.within, lib.int
local cocomo={}

--- Define the internal `cocomo` data structure:
-- `x` slots (for business-level decisions) and
-- `y` slots (for things derived from those decisions, 
-- like `self.effort` and `self.risk')
function cocomo.new(self,coc)
  self = self or {x={}, y={}}
  self.about = self.about or coc
  return self
end

--- Change the keys `x1,x2...` 
-- in  a model, (and wipe anyting computed from `x`).
-- @tab  self : a `cocomo` table
-- @tab  t : a list of key,value pairs that we will update.
-- @return tab : an updated `cocomo` table
function cocomo.set(self, t)
  for x,v in pairs(t) do self.x[x] = v end
  self.y={}
  return self
end

--- Compute effort
-- @tab  self : what we know about a project
-- @tab  coc : background knowledge about `self`
-- @return number : the effort
function cocomo.effort(self,coc)
  local em,sf=1,0
  for k,t in pairs(coc) do
    if     t[1] == "+" then em = em * self.y[k] 
    elseif t[1] == "-" then em = em * self.y[k] 
    elseif t[1] == "*" then sf = sf + self.y[k] end
  end 
  return self.y.a*self.x.loc^(self.y.b + 0.01*sf) * em 
end
  
--- Compute risk
-- @tab  self : what we know about a project
-- @tab  coc : background knowledge about `self`
-- @return number : the risk
function cocomo.risks(self,risk)
  local n=0
  for a1,t in pairs(risk) do
    for a2,m in pairs(t) do
      n  = n  + m[self.x[a1]][self.x[a2]] end end
  return n 
end

--- Return a `y` value from `x`
-- @tab  w : type of column (\*,+,-,1)
-- @number  x 
-- @return number 
function cocomo.y(w,x)
  if w=="1" then return x end
  if w=="+" then return (x-3)*from( 0.073,  0.21 ) + 1 end
  if w=="-" then return (x-3)*from(-0.187, -0.078) + 1 end
  return                (x-6)*from(-1.56,  -1.014) 
end
 
--- Mutatble objects, pairs of `{x,y}`
-- Ensures that `y` is up to date with the `x` variables.
function cocomo.ready(self,coc,risk)
  local y,effort,ready,lo,hi
  coc  = coc or coc0
  risk = risk  or risk0
  self = cocomo.new(self,coc)
  for k,t in pairs(coc) do 
    lo = t[2] or 1
    hi = t[3] or 5
    self.x[k] = int(self.x[k] and within(self.x[k],lo,hi) or 
                 from(lo,hi))
    self.y[k] = self.y[k] or cocomo.y(t[1], self.x[k])
  end 
  self.y.a = self.y.a or from(2.3, 9.18)
  self.y.b = self.y.b or (.85 - 1.1)/(9.18-2.2)*self.y.a+.9+(1.2-.8)/2
  self.y.effort = self.y.effort or cocomo.effort(self,coc)
  self.y.risk = self.y.risk or cocomo.risks(self,risk)
  return self
end

return cocomo
