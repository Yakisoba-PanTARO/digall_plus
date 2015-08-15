------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall_plus
------------------------------------------------------------

------------------------------------------------------------
-- digall_plus:default_*はdigall:defaultの強化版です。
------------------------------------------------------------

local function default_upper(pos, node, digger, range)
   digall.default_algorithm_impl(
      pos, node, digger, function(pos1, node1, pos2, node2, digger)
         if (node1.name == node2.name             and
             math.abs(pos.x - pos2.x) <= range.x  and
             math.abs(pos.y - pos2.y) <= range.y  and
             math.abs(pos.z - pos2.z) <= range.z  and
             pos2.y - pos.y >= 0)                 then
            return true
         end
         return false
   end)
end

local function default_upper_without_range(pos, node, digger)
   digall.default_algorithm_impl(
      pos, node, digger, function(pos1, node1, pos2, node2, digger)
         return (node1.name == node2.name and pos2.y - pos.y >= 0)
   end)
end

local function default_lower(pos, node, digger, range)
   digall.default_algorithm_impl(
      pos, node, digger, function(pos1, node1, pos2, node2, digger)
         if (node1.name == node2.name             and
             math.abs(pos.x - pos2.x) <= range.x  and
             math.abs(pos.y - pos2.y) <= range.y  and
             math.abs(pos.z - pos2.z) <= range.z  and
             pos2.y - pos.y <= 0)                 then
            return true
         end
         return false
   end)
end

local function default_lower_without_range(pos, node, digger)
   digall.default_algorithm_impl(
      pos, node, digger, function(pos1, node1, pos2, node2, digger)
         return (node1.name == node2.name and pos2.y - pos.y <= 0)
   end)
end

------------------------------------------------------------
-- REGISTER ALGORITHMS
------------------------------------------------------------
digall.register_algorithm(
   "digall_plus:default_upper", {
      description = "Default Upper Algorithm",
      default_args = {{x = 3, y = 3, z = 3}},
      func = default_upper,
})

digall.register_algorithm(
   "digall_plus:default_upper_without_range", {
      description = "Default Upper Algorithm Without Range",
      func = default_upper_without_range,
})

digall.register_algorithm(
   "digall_plus:default_lower", {
      description = "Default Lower Algorithm",
      default_args = {{x = 3, y = 3, z = 3}},
      func = default_lower,
})

digall.register_algorithm(
   "digall_plus:default_lower_without_range", {
      description = "Default Lower Algorithm Without Range",
      func = default_lower_without_range,
})
