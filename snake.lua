local snake = {}
function snake:load()
    self.x = 0
    self.y = 0
    self.tail = {}
    self.currentPos = {}
    self.prevDirection = 1
    self.moving = false
    self.falling = false

    -- 1 - →
    -- 2 - ↓
    -- 3 - ↑
    -- 4 - ←
end

function snake:update(dt)
   if self.moving and not self.falling then
      local onGround = false

      local _underTile = tileManager.tileData[mapManager:getTileFromPos(self.x,self.y+1)]
      if _underTile and _underTile.canCollide then
         onGround = true
      end

      for indx, tail in pairs(self.tail) do
         local _underTile = tileManager.tileData[mapManager:getTileFromPos(tail.x,tail.y+1)]
         if _underTile and _underTile.canCollide then
            onGround = true
            break
         end
      end

      if onGround then
         self.moving = false
         self._fallingSpeed = 4
      else
         self.falling = true
         self._fallingProg = 0
         self._fallingSpeed = self._fallingSpeed or 4
      end
   end

   if self.falling then
      self._fallingProg = self._fallingProg + dt*self._fallingSpeed
      self._fallingSpeed = self._fallingSpeed + dt*100

      if self._fallingProg >= 1 then
         self.y = self.y+1
         for indx, tail in pairs(self.tail) do
            tail.y = tail.y + 1
         end

         self.falling = false
         self._fallingProg = nil
      end
   end
end

function snake:draw()
    tileManager:drawTile(self.x,self.y+(self._fallingProg or 0),3)

    for indx, tail in pairs(self.tail) do
      tileManager:drawTile(tail.x,tail.y+(self._fallingProg or 0),4)
    end
end

function snake:keypressed(key)
    local canMove = true
    if not self.moving then
      local nextPos = {x=self.x,y=self.y}
      local posDiff = {x=0,y=0}

      if key == "w" then
         nextPos.y = self.y - 1
         posDiff.y=-1
      elseif key == "s" then
         nextPos.y = self.y + 1
         posDiff.y=1
      elseif key == "a" then
         nextPos.x = self.x - 1
         posDiff.x=-1
      elseif key == "d" then
         nextPos.x = self.x + 1
         posDiff.x=1
      end

      if key == "w" or key == "a" or key == "s" or key == "d" then
         self.currentPos = {x=self.x,y=self.y}

         local found = false

         for indx, tail in pairs(self.tail) do
               if tail.x == nextPos.x and tail.y == nextPos.y then
                  found = true
                  break
               end
         end
         local tile = tileManager.tileData[mapManager:getTileFromPos(nextPos.x,nextPos.y)] 
         local ateApple = false
         local ateRottenApple = false
         if tile and tile.canCollide then
            if tile.id==2 then
               mapManager.currentMap.map[nextPos.y+1][nextPos.x+1]=0
               ateApple = true
            elseif tile.id == 5 then
               mapManager.currentMap.map[nextPos.y+1][nextPos.x+1]=0
               ateRottenApple = true
            elseif tile.id == 6 then
               if mapManager:getTileFromPos(nextPos.x+posDiff.x,nextPos.y+posDiff.y)==0 then
                  mapManager.currentMap.map[nextPos.y+1][nextPos.x+1]=0
                  mapManager.currentMap.map[nextPos.y+1+posDiff.y][nextPos.x+1+posDiff.x]=6
               else
                  found = true
               end
            else
               found = true
            end
         end
         if found then canMove = false else
            if not ateApple then table.remove(self.tail, 1) end
            if ateRottenApple then table.remove(self.tail, 1) end
            table.insert(self.tail, self.currentPos)
         end
      end

      if canMove then
         self.x = nextPos.x
         self.y = nextPos.y
         self.moving = true
         if key == "w" then
               self.prevDirection = 3
         elseif key == "s" then
               self.prevDirection = 2
         elseif key == "a" then
               self.prevDirection = 4
         elseif key == "d" then
               self.prevDirection = 1
         end
      end
   end
end

return snake