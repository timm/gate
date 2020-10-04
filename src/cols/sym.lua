-- vim: ft=lua ts=2 sw=2 et:

--- Summarize a stream of non-numbers
local uses=dofiled("lib/misc").uses
local col=dofiled("cols/col").col

local Sym = { most=0, seen={}}

--- Create
function Sym.new(txt,pos) 
  return col(uses(Sym),txt,pos) end

--- Update.
-- Not called directly (used inside use `col.add`).
function Sym:add(x,    new)
  self.seen[x] = (self.seen[x] or 0) + 1
  if self.seen[x] > self.most then 
    self.most,self.mode = self.seen[x],x end
end

return Sym 
