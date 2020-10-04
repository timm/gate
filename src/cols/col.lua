-- vim: ft=lua ts=2 sw=2 et:

--- Mixin functions for columns
local the = dofiled("the")
local col = {}

--- The initialization mixin.
-- Sett up  a new column `c`'s
-- `txt` name and `pos`ition
-- @tab self : some column
-- @string  txt : optional, defaults to ""
-- @number  pos : optional, defaults to 0
-- @return self
function col.col(self, txt,pos)
  self.n   = 0
  self.txt = txt or ""
  self.pos = pos or 0
  self.w   = self.txt:find(the.ch.less) and -1 or 1
  return self
end

--- The update mixin.
-- Add `x` to `i` (and if `i.also` exists,
-- also add there)
-- @tab self : some column
-- @tparam any thing
-- @return self
function col.add(self, x)
  if x==the.ch.skip then return x end
  self.n = self.n+1
  self:add(x)
  if self.also then add(self.also, x) end
  return self
end

return col
