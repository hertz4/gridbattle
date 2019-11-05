local triangle = {
   extends = 'bullet',
   img = 'bullet',
   lifespan = 60,
   dx = 0.01,
   damage = 80,
}

function triangle:update ()
   self.dx = self.dx * 1.1
   self:move()
end

return triangle
