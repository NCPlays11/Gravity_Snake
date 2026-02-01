local mapManager = {}

function mapManager:load()
    self.currentMap = {}
end

function mapManager:loadMap(mapData)
    self.currentMap = mapData

    snake.x = mapData.startPos.x
    snake.y = mapData.startPos.y
    snake.tail = mapData.startTail
    tileManager.gridHeight = #mapData.map
    
    local highest = 0
    for indx, row in pairs(mapData.map) do
        if #row > highest then
            highest = #row
        end
    end
    tileManager.gridWidth = highest
end

function mapManager:update(dt)
    for indy, row in pairs(self.currentMap.map) do
        for indx, tile in pairs(row) do
            if tile == 6 then
                local canFall = false
                if mapManager:getTileFromPos(indx-1,indy)==0 then
                   canFall = true
                end

                if canFall then
                    if indx-1 == snake.x and indy==snake.y then
                        canFall = false
                    end

                    for i, tail in pairs(snake.tail) do
                        if indx-1 == tail.x and indy==tail.y then
                            canFall = false
                        end
                    end
                end

                if canFall then
                    self.currentMap.map[indy][indx]=0
                    self.currentMap.map[indy+1][indx]=6
                end
            end
        end
    end
end

function mapManager:getTileFromPos(x,y)
    local row = self.currentMap.map[y+1]
    if not row then return else
        return row[x+1]
    end
end

function mapManager:draw()
    for indy, row in ipairs(self.currentMap.map) do
        for indx, tile in ipairs(row) do
            if tile ~= 0 then
                tileManager:drawTile(indx-1, indy-1,tile)
            end
        end
    end
end

return mapManager