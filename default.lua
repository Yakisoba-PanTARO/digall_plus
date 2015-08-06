------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall_plus
------------------------------------------------------------

local function default_impl
   (pos, node, digger, range, original_pos, directions)
   for _, dir in ipairs(directions) do
      local pos2 = {
         x = pos.x + dir.x,
         y = pos.y + dir.y,
         z = pos.z + dir.z,
      }
      local node2 = minetest.get_node(pos2)
      if (node2.name == node.name and
          (math.abs(original_pos.x - pos2.x) <= range.x) and
          (math.abs(original_pos.y - pos2.y) <= range.y) and
          (math.abs(original_pos.z - pos2.z) <= range.z)) then
         minetest.node_dig(pos2, node2, digger)
         default_impl(pos2, node2, digger, range, original_pos, directions)
      end
   end
end

------------------------------------------------------------
digall.register_algorithm(
   "digall_plus:default_upper", {
      description = "Default Upper Algorithm",
      default_args = {{x = 3, y = 3, z = 3}},
      func = function(pos, node, digger, range)
         default_impl(pos, node, digger, range, pos, {
                         { x =  0, y =  0, z = -1 },
                         { x =  0, y =  0, z =  1 },
                         { x =  0, y =  1, z =  0 },
                         { x = -1, y =  0, z =  0 },
                         { x =  1, y =  0, z =  0 },
         })
      end,
})
digall.register_algorithm(
   "digall_plus:default_lower", {
      description = "Default Lower Algorithm",
      default_args = {{x = 3, y = 3, z = 3}},
      func = function(pos, node, digger, range)
         default_impl(pos, node, digger, range, pos, {
                         { x =  0, y =  0, z = -1 },
                         { x =  0, y =  0, z =  1 },
                         { x =  0, y = -1, z =  0 },
                         { x = -1, y =  0, z =  0 },
                         { x =  1, y =  0, z =  0 },
         })
      end
})
