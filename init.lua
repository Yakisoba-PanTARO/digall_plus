------------------------------------------------------------
-- Copyright (c) 2015 Yakisoba-PanTARO 
-- https://github.com/Yakisoba-PanTARO/digall_plus
------------------------------------------------------------

local function dig_triangle_impl(pos, node, facedir, digger, radius)
   if radius < 1 then
      return
   end
   local poss = {}
   -- X軸方向に広げて掘る場合
   if facedir == 0 or facedir == 2 then
      poss = {
         { x = pos.x + 1, y = pos.y, z = pos.z },
         { x = pos.x - 1, y = pos.y, z = pos.z },
         { x = pos.x, y = pos.y + 1, z = pos.z },
      }
   -- Z軸方向に広げて掘る場合
   elseif facedir == 1 or facedir == 3 then
      poss = {
         { x = pos.x, y = pos.y, z = pos.z + 1 },
         { x = pos.x, y = pos.y, z = pos.z - 1 },
         { x = pos.x, y = pos.y + 1, z = pos.z },
      }
   end
   for _, p in ipairs(poss) do
      local n = minetest.get_node(p)
      minetest.node_dig(p, n, digger)
      dig_triangle_impl(p, n, facedir, digger, radius-1)
   end
end

local function dig_triangle(pos, node, digger, radius)
   local dir = digger:get_look_dir()
   local facedir = minetest.dir_to_facedir(dir)
   dig_triangle_impl(pos, node, facedir, digger, radius)
end

local function dig_triangle_tunnel(pos, node, digger, radius, depth)
   if depth < 1 then
      return
   end
   local dir = digger:get_look_dir()
   local facedir = minetest.dir_to_facedir(dir)
   dig_triangle_impl(pos, node, facedir, digger, radius)
   local pos2 = {
      x = pos.x + dir.x,
      y = pos.y, -- Y軸に関しては不変
      z = pos.z + dir.z,
   }
   local node2 = minetest.get_node(pos2)
   dig_triangle_tunnel(pos2, node2, digger, radius, depth-1)
end

--[[
local function dig_semicircle_impl(
      pos, node, facedir, digger, radius, origin)
   if (((origin.x - pos.x)^2 + (origin.y - pos.y)^2
         + (origin.z - pos.z)^2) > radius^2) then
      return
   end
   minetest.node_dig(pos, node, digger)
   local poss = {}
   -- X軸方向に広げて掘る場合
   if facedir == 0 or facedir == 2 then
      poss = {
         { x = pos.x + 1, y = pos.y, z = pos.z },
         { x = pos.x - 1, y = pos.y, z = pos.z },
         { x = pos.x, y = pos.y + 1, z = pos.z },
      }
   -- Z軸方向に広げて掘る場合
   elseif facedir == 1 or facedir == 3 then
      poss = {
         { x = pos.x, y = pos.y, z = pos.z + 1 },
         { x = pos.x, y = pos.y, z = pos.z - 1 },
         { x = pos.x, y = pos.y + 1, z = pos.z },
      }
   end
   for _, p in ipairs(poss) do
      local n = minetest.get_node(p)
      dig_semicircle_impl(p, n, facedir, digger, radius, origin)
   end
end

local function dig_semicircle(pos, node, digger, radius)
   local dir = digger:get_look_dir()
   local facedir = minetest.dir_to_facedir(dir)
   dig_semicircle_impl(pos, node, facedir, digger, radius, pos)
end

local function dig_semicircle_tunnel(pos, node, digger, radius, depth)
   if depth < 0 then
      return
   end
   local dir = digger:get_look_dir()
   local facedir = minetest.dir_to_facedir(dir)
   dig_semicircle_impl(pos, node, facedir, digger, radius, pos)
   local pos2 = {
      x = pos.x + dir.x,
      y = pos.y, -- Y軸に関しては不変
      z = pos.z + dir.z,
   }
   local node2 = minetest.get_node(pos2)
   dig_semicircle_tunnel(pos2, node2, digger, radius, depth-1)
end
]]--
------------------------------------------------------------
digall.register_algorithm(
   "digall_plus:triangle", dig_triangle)
digall.register_algorithm(
   "digall_plus:triangle_tunnel", dig_triangle_tunnel)
--[[
digall.register_algorithm(
   "digall_plus:semicircle", dig_semicircle)
digall.register_algorithm(
   "digall_plus:semicircle_tunnel", dig_semicircle_tunnel)
]]--
