local lib=dofiled("lib/misc")
local eg=dofiled("lib/eg").all
local s=dofiled("lib/sample")

eg {
bar1 = function(    f,a)
    a,f = {}, s.bars {a=1,b=2,c=4}
    for i=1,20 do a[#a+1]= f() end
    table.sort(a)
    print(table.concat(a))
end,

tri1=function(   a)
  a={}
  for i=1,256 do a[#a+1] = s.rnd(s.tri(1,3,10)) end
  table.sort(a)
  print(table.concat(a))
end,

weil=function(   a)
  a={}
  for i=1,256 do 
    a[#a+1] = lib.round(s.weilbull(1,5,1,1),2)
  end
  table.sort(a)
  print(table.concat(a," "))
end,

sample1=function(   f,a)
  a,f={},s.interpolate{{1,5},{2,5},{3,5},{4,5},{5,5}}
  for i=1,2048 do 
     local x = s.rnd(f())
     a[x] = (a[x] or 0) + 1 
  end
  for i,j in pairs(a) do print(i,j) end
end
}




