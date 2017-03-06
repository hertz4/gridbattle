local input = require "src/input"
local stage = require "src/battle/stage"
local queue = require "src/battle/queue"

local ent = {
   draw = function (self, x, y)
      queue.draw(self.queue, x+self.ox, y-15)
   end,

   states = {
      idle = {row = 1, anim = {1}, speed = 1000, iasa = 0},
      shoot = {row = 3, anim = {1,2}, speed = 20, length = 2},
      throw = {row = 4, anim = {1,2}, speed = 20, length = 2},
      move = {
         row = 2, anim = {1,2}, speed = 5, length = 5, iasa = 3,
         act = function (self)
            if self.time == 5 then
               self.x, self.y = self.goalx, self.goaly
            end
         end,
      },
   },

   queue = {},
}

return {
   ent = ent,
   variants = {
      player = {
         img = "ben",
         sheet = {0,0,50,60,2,6},
         ox = 24, oy = 54,
         act = function (self)
            local move = function  (dx, dy)
               local goalx, goaly = self.x+dx, self.y+dy
               if stage.isfree(goalx, goaly, self.side) then
                  stage.free(self.x, self.y)
                  self.goalx, self.goaly = goalx, goaly
                  stage.occupy(self, goalx, goaly)
                  self.enter_state = "move"
               end
            end

            if input.a==1     then queue.use_chip(self)
            elseif input.du>0 then move(0, -1)
            elseif input.dd>0 then move(0, 1)
            elseif input.dl>0 then move(-1, 0)
            elseif input.dr>0 then move(1, 0)
            end
         end,
      }
   }
}