do 
  local use,top
  use={}
  function dofiled(f)
    top = top or debug.getinfo(dofiled).short_src:match("(.*[/\\])")
    f = top .. f .. ".lua"
    if not use[f] then
      print(f)
      use[f] = dofile(f)
    end
    return use[f] 
  end 
end 

return  {
  all = {},
  ch  = {less  = "<",
         klass = "!",
         more  = ">",
         num   = ":",
         skip  = "?"}
}
