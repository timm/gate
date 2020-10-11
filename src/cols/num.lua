-- vim: ft=lua ts=2 sw=2 et:

--- Summarize a stream of numbers
-- while maintaining `mu,sd` $\mu$ mean, $\sigma$ standard deviation).
-- When \(a \ne 0\), there are two solutions to \(ax^2 + bx + c = 0\) and they are
-- $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$
-- <i class="fa fa-camera-retro"></i>  <!-- version 4's syntax -->

local uses=dofiled("lib/misc").uses
local col=dofiled("cols/col").col

local Num = {mu=0, m2=0, sd=0,
             lo=math.huge, hi= -math.huge}

--- Create
-- @string txt : optional
-- @number pos : optional
-- @return : a Num
function Num.new(txt,pos) 
  return col(uses(Num),txt,pos) end

--- Update
-- Not called directly (used inside use `col.add`).
-- @number x :
function Num:add(x)
  local   = x - self.mu
  self.mu = self.mu + d/self.n
  self.m2 = self.m2 + d*(x - self.mu)
  self.sd = (self.m2<0 or self.n<2) and 0 or (
            (self.m2/(self.n-1))^0.5)
  self.lo = math.min(x, self.lo)
  self.hi = math.max(x, self.hi) 
end

return Num 
