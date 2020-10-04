-- vim: ft=lua ts=2 sw=2 et:

--- Summarize a stream of numbers

local uses=dofiled("lib/misc").uses
local col=dofiled("cols/col").col

local Num = {mu=0, m2=0, sd=0,
             lo=math.huge, hi= -math.huge}

--- Create
function Num.new(txt,pos) 
  return col(uses(Num),txt,pos) end

--- Update
-- Not called directly (used inside use `col.add`).
function Num:add(x,    d) 
  d       = x - self.mu
  self.mu = self.mu + d/self.n
  self.m2 = self.m2 + d*(x - self.mu)
  self.sd = (self.m2<0 or self.n<2) and 0 or (
            (self.m2/(self.n-1))^0.5)
  self.lo = math.min(x, self.lo)
  self.hi = math.max(x, self.hi) 
end

return Num 
