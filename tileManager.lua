local tileManager = {}

function tileManager:load()
    self.gridWidth = 5
    self.gridHeight = 5
    self.gridWidthPx = 0
    self.gridHeightPx = 0
end

function tileManager:update(dt)
end

function tileManager:drawTile(x,y, id)
    local tileSize = self.gridWidthPx/self.gridWidth

    if id == 3 then
        love.graphics.setColor(0,1,0)
    elseif id == 2 then
        love.graphics.setColor(1,0,0)
    elseif id == 1 then
        love.graphics.setColor(1,1,1)
    end

    love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize, tileSize)
end

function tileManager:draw()
    love.graphics.setColor(0.5,0.5,0.5,1)

    local xRatio = self.gridWidth/self.gridHeight

    local sX = love.graphics.getWidth()
    local sY = love.graphics.getHeight()

    if sX/xRatio > sY then
        love.graphics.rectangle("fill",love.graphics.getWidth()/2-(sY*xRatio*0.5),0,sY*xRatio,sY)
        self.gridWidthPx = sY*xRatio
        self.gridHeightPx = sY
        love.graphics.translate(love.graphics.getWidth()/2-(sY*xRatio*0.5),0)
    else
        love.graphics.rectangle("fill",0,love.graphics.getHeight()/2-(sX/xRatio*0.5),sX,sX/xRatio)
        self.gridWidthPx = sX
        self.gridHeightPx = sX/xRatio
        love.graphics.translate(0,love.graphics.getHeight()/2-(sX/xRatio*0.5))
    end
end

return tileManager