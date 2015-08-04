------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall_plus
------------------------------------------------------------

local function default_plus(pos, node, digger, range, directions)
   for _, dir in ipairs(directions) do
      local pos2 = {
         x = pos.x + dir.x,
         y = pos.y + dir.y,
         z = pos.z + dir.z,
      }
      local range2 = {
         x = range.x - math.abs(dir.x),
         y = range.y - math.abs(dir.y),
         z = range.z - math.abs(dir.z),
      }
      local node2 = minetest.get_node(pos2)
      if node2.name == node.name and
      (range2.x >= 0 and range2.y >= 0 and range2.z >= 0) then
         minetest.node_dig(pos2, node2, digger)
         default_plus(pos2, node2, digger, range2, directions)
      end
   end
end

------------------------------------------------------------
digall.register_algorithm(
   "digall_plus:default_upper", function(pos, node, digger, range)
      default_plus(pos, node, digger, range, {
                      { x =  0, y =  0, z = -1 },
                      { x =  0, y =  0, z =  1 },
                      { x =  0, y =  1, z =  0 },
                      { x = -1, y =  0, z =  0 },
                      { x =  1, y =  0, z =  0 },
      })
end)
digall.register_algorithm(
   "degall_plus:default_lower", function(pos, node, digger, range)
      default_plus(pos, node, digger, range, {
                      { x =  0, y =  0, z = -1 },
                      { x =  0, y =  0, z =  1 },
                      { x =  0, y = -1, z =  0 },
                      { x = -1, y =  0, z =  0 },
                      { x =  1, y =  0, z =  0 },
      })
end)
   
