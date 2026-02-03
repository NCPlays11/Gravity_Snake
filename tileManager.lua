local tileManager = {}

function tileManager:load()
    self.gridWidth = 5
    self.gridHeight = 5
    self.gridWidthPx = 0
    self.gridHeightPx = 0

    self.snakeSheet = love.graphics.newImage("assets/textures/snakeSheet.png")
    self.tileSheet = love.graphics.newImage("assets/textures/tilesSheet.png")

    self.tileData = {
        [1]={tilePos={x=2,y=0},sheet = self.tileSheet, canCollide = true,id=1,},
        [2]={tilePos={x=0,y=0},sheet = self.tileSheet, canCollide = true,id=2,},
        [3]={tilePos={x=0,y=0},sheet = self.snakeSheet, canCollide = true,id=3,},
        [4]={tilePos={x=0,y=1},sheet = self.snakeSheet, canCollide = true,id=4,},
        [5]={tilePos={x=1,y=0},sheet = self.tileSheet, canCollide = true,id=5,},
        [6]={tilePos={x=0,y=1},sheet = self.tileSheet, canCollide = true,id=6},
        [7]={tilePos={x=1,y=1},sheet = self.tileSheet, canCollide = false,id=7,},
        [8]={tilePos={x=2,y=1},sheet = self.tileSheet, canCollide = false,id=8,},
    }
end

function tileManager:update(dt)
end

function tileManager:drawTile(x, y, id)
    love.graphics.setColor(1, 1, 1, 1)
    local tileSize = self.gridWidthPx / self.gridWidth


    -- Tile ids:
    -- 8 - Flag
    -- 7 - Spike
    -- 6 - Rock
    -- 5 - Rotten Apple
    -- 4 - Tail
    -- 3 - Head
    -- 2 - Apple
    -- 1 - Ground

    local tilePosition = {x=self.tileData[id].tilePos.x,y=self.tileData[id].tilePos.y}
    local tileSheet = self.tileData[id].sheet
    if id == 1 then
        if mapManager:getTileFromPos(x,y-1) == 1 then
            tilePosition.x=3
        end
    elseif id == 4 then
        tilePosition.x = (math.floor(x+y+snake.x+snake.y))%2
    elseif id == 3 then
        tilePosition.x = snake.prevDirection-1
    end
    local quad = love.graphics.newQuad((tilePosition.x)*16,(tilePosition.y)*16,16,16,tileSheet:getDimensions())
    local scale = tileSize/16
    love.graphics.draw(tileSheet, quad, x*tileSize, y*tileSize,0,scale,scale)
end

function tileManager:draw()
    love.graphics.setColor(0.5, 0.5, 0.5, 1)

    local xRatio = self.gridWidth / self.gridHeight

    local sX = love.graphics.getWidth()
    local sY = love.graphics.getHeight()

    if sX / xRatio > sY then
        self.gridWidthPx = sY * xRatio
        self.gridHeightPx = sY
        love.graphics.translate(love.graphics.getWidth() / 2 - (sY * xRatio * 0.5), 0)
    else
        self.gridWidthPx = sX
        self.gridHeightPx = sX / xRatio
        love.graphics.translate(0, love.graphics.getHeight() / 2 - (sX / xRatio * 0.5))
    end
end

return tileManager
