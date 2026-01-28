local snake = {}
function snake:load()
    self.x = 0
    self.y = 0
end

function snake:update(dt)

end

function snake:draw()
    tileManager:drawTile(self.x,self.y,3)
end

function snake:keypressed(key)
   if key == "w" then
      self.y = self.y - 1
   elseif key == "s" then
      self.y = self.y + 1
   elseif key == "a" then
      self.x = self.x - 1
   elseif key == "d" then
      self.x = self.x + 1
   end
end

return snake