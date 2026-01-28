local mapManager = {}

function mapManager:load()
    self.currentMap = {}
end

function mapManager:loadMap(mapData)
    self.currentMap = mapData

    snake.x = mapData.startPos.x
    snake.y = mapData.startPos.y-1
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