local cl=require "color"

local eg={}
eg.try=0
eg.fail=0
eg.egs={}

function eg.run(name,f,seed)
  local t1,t2,t2
  eg.try = eg.try + 1
  t1 = os.clock()
  math.randomseed(seed or 1)
  local passed,err = pcall(f)
  t3= os.date("%X :")
  if passed then
    t2= os.clock()
    cl.green("%s PASS! "..name.." \t: %8.6f secs",t3,t2-t1)
  else
    eg.fail = eg.fail + 1
    local y,n = eg.try, eg.fail
    cl.red("%s FAIL! "..name.." \t: %s [%.0f] %%",
           t3, err:gsub("^.*: ",""), 100*y/(y+n)) end
end

function eg.within(x,y,z)
  assert(x <= y and y <= z, 'outside range ['..x..' to '..']')
end

function eg.all() 
  for group,funs in pairs(eg.egs) do
    print(group)
    for name,fun in pairs(funs) do
      eg.run(group ..":".. name,fun) end end 
end

eg.egs.all={}
function eg.egs.all.one() assert(1==2) end

eg.all()

return eg 
