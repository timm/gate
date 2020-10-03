-- vim : ft=lua ts=2 sw=2 et:

--- Colorize output string 

color={}

--- Print a string, colored green.
-- @string txt
-- @return nil
function color.green(...)  color.color(32,...) end

--- Print a string, colored red.
-- @string txt
-- @return nil
function color.red(...) color.color(31,...) end   
  
function color.color(n,...)
  print('\27[1m\27['.. n ..'m'..string.format(...)..'\27[0m') end

return color

