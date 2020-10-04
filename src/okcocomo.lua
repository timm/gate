lib=require "lib"
eg=require "eg"
cocomo=require "cocomo"

eg.all {
one = function(self) 
  local function say() 
    print("")
    --lib.o(i.x)
    lib.oo {effort= self.y.effort,
            loc   = self.x.loc,
            risk  = self.y.risk,
            pcap  = self.x.pcap}
  end
  self = cocomo.ready()
  cocomo.new(self, {pcap=4})
  self = cocomo.ready(self)
  say()

  cocomo.set(self, {pcap=1})
  self = cocomo.ready(self)
  say()
end}
