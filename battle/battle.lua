-- Center the stage unless specified
local scene = require "src/scene"
local Folder = require "src/Folder"
local depthdraw = require "src/depthdraw"
local ents = require "battle/ents"
local stage = require "battle/stage"
local folder = Folder.new{}

local savedata = require(RES_PATH .. "savedata")
local ui =  require(PATHS.battle .. "ui")

local bg
local cust_frames
local cust_time = 4*60

local selectchips = function ()
   scene.push(require(PATHS.battle .. "customize"), folder, ents.player.queue)
   cust_frames = 0
end

return {
   start = function (set)
      _G.GAME.xscale = BATTLE.xscale
      _G.GAME.yscale = BATTLE.yscale
      _G.GAME.xoff = BATTLE.xoff
      _G.GAME.yoff = BATTLE.yoff

      set = require(PATHS.sets .. set)
      folder:load(savedata.player.folder)

      stage.start(set.stage.turf)
      ents.start(set)
      bg = require(PATHS.bg .. set.bg)
      set.bg_args = set.bg_args or {}
      bg.start(unpack(set.bg_args))

      selectchips()
   end,

   update = function (_, input)
      if input then
	 local ending = ents.get_ending()
	 if ending then
	    scene.push(require "battle/results", ending)
	    return
	 end

	 if input.st == 1 then
	    scene.push((require "src/Menu"):new("pause"))
	    return
	 elseif cust_frames >= cust_time and (input.l==1 or input.r==1) then
	    selectchips()
	    return
	 end
	 cust_frames = cust_frames + 1
      end

      ents.update(input)
      stage.update()
   end,

   draw = function ()
      bg.draw()
      ents.draw() -- calls depthdraw
      stage.draw() -- calls depthdraw

      local cust_amount = cust_frames / cust_time
      ui.draw_under(ents.player, cust_amount, ents.get_enemy_names())
      depthdraw.draw()
      ui.draw_over(ents.player)
   end,

   exit = function ()
      ents.exit()
   end
}