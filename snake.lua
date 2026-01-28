local snake = {}
function snake:load()
    self.x = 200
    self.y = 250
end

function snake:update(dt)

end

function snake:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, 50, 50)
end

function snake:keypressed(key)
   if key == "w" then
      self.y = self.y - 50
   elseif key == "s" then
      self.y = self.y + 50
   elseif key == "a" then
      self.x = self.x - 50
   elseif key == "d" then
      self.x = self.x + 50
   end
end

return snake