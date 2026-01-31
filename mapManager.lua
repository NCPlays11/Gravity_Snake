local mapManager = {}

function mapManager:load()
    self.currentMap = {}
end

function mapManager:loadMap(mapData)
    self.currentMap = mapData

    snake.x = mapData.startPos.x
    snake.y = mapData.startPos.y-1
    tileManager.gridHeight = #mapData.map
    
    local highest = 0
    for indx, row in pairs(mapData.map) do
        if #row > highest then
            highest = #row
        end
    end
    tileManager.gridWidth = highest
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