local sheet_data = {
   size = {x=50, y=60},
   img_size = {x=100, y=600},
   strips = {
      idle = {
	 pos = {x=0, y=0},
	 num = 2,
      },
      move = {
	 pos = {x=0, y=60},
	 num = 2,
      },
      shoot = {
	 pos = {x=0, y=120},
	 num = 1,
      }
   }
}

local anims = {
   idle = {1,1,1,1,1,2,2,2,2,2},
   move = {1,1,1,1,1,2,2,2,2,2},
   shoot = {1,1,1,1,1,1,1,1,1,1},
}

sheet = Sheet.new(sheet_data)

Player = Actor:new(o)

local states = {
   idle = {
      anim = anims.idle,
   },
   move = {
      anim = anims.move,
      now = Player.move,
   },
   shoot = {
      anim = anims.shoot,
      now = Player.shoot,
   }
}

function Player:act()
   if     input.check("a")     then self:shoot()
   elseif input.check("up")    then self:move{x=self.space.x,   y=self.space.y-1}
   elseif input.check("down")  then self:move{x=self.space.x,   y=self.space.y+1}
   elseif input.check("left")  then self:move{x=self.space.x-1, y=self.space.y}
   elseif input.check("right") then self:move{x=self.space.x+1, y=self.space.y}
   end
end

function Player:start()
   return states.idle
end

function Player:move(space_goal)
   input.stale("pad") -- Require a re-press
   if stage.canGo(space_goal, self.side) then
      stage.free(self.space)
      stage.occupy(space_goal)
      -- TODO: make moving not instant
      self.space = space_goal
      self.pos = stage.pos(self.space)
      return states.move
   else
      return self.state
   end
end

function Player:shoot()
   self.state = states.shoot
   input.stale("a")
end

return Player
