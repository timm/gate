local eg=dofiled("lib/eg").all
local lib=dofiled("lib/misc")

eg {lib1=function( t,n)
  t={}
  n=32
  for i=1,n do t[#t+1] = lib.norm(10,2)  end
  table.sort(t)
  assert(t[n/4] < t[3*n/4])
end}
