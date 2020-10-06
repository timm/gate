local eg=dofiled("lib/eg").all
local lib=dofiled("lib/misc")

eg {lib1=function( t,n)
  t={}
  n=32
  for i=1,n do t[#t+1] = lib.norm(10,2)  end
  table.sort(t)
  assert(t[n/4] < t[3*n/4])
end,

lib2= function(   t)
  t={}
  for x=0,2.5,0.2 do
     t[#t+1] = lib.round(lib.normweilbull(x,1.5,1),1)
   end
   print(table.concat(t,","))
end}
