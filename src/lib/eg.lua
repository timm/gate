-- vim: ft=lua ts=2 sw=2 et:

local cl=dofiled "lib/color"

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

function eg.all(all) 
 for name,fun in pairs(all or eg.egs.demo) do
    eg.run(name,fun) end 
end 

eg.egs.demo = {}
function eg.egs.demo.one() assert(1==2) end
function eg.egs.demo.two() assert(1==1) end

return eg 
