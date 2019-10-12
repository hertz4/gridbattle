local scene = require 'src/scene'
local World = require 'world/World'

return {
   y = 40, spacing = 16,
   font = 'title',
   bg_img = 'title',
   {'battle',
    a = function ()
       scene.push_fade({}, (require 'battle/battle'), 'test')
   end},
   {'pvp',
    a = function ()
       scene.push_fade({}, (require 'battle/battle'), 'pvp')
   end},
   {'folder editor',
    a = function ()
       scene.push_fade({}, require 'foldedit/editor',
          'test-collection', 'test')
   end},
   {'worldmap test',
    a = function ()
       local world = World.from_map_path('res/world/testmap/map1.lua')
       scene.push_fade({}, world)
   end},
   {'config',
    a = function ()
       scene.push_fade({}, (require 'src/Menu'):new('settings'))
   end},
   {'exit', a = love.event.quit},
}
