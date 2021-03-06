local particle = {}

function particle:init ()
   local dr = math.random() * 4 + 2
   local theta = math.random() * 2 * math.pi
   self.velocity = point(math.sin(theta), math.cos(theta)) * dr
   self.dz = math.random() * 5
end

function particle:update ()
   if self.z < -200 then self.remove_from_battle = true end
   self:move()
end

function particle:draw ()
   local x, y = self:screen_pos():unpack()
   love.graphics.setColor(unpack(self.color))
   love.graphics.circle('fill', x, y, math.max(0, 5 + self.z*5/200), 4)
   love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end

function particle:die ()
   self.remove_from_battle = true
end

return particle
