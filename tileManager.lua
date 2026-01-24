local tileManager = {}

function tileManager:load()
end

function tileManager:update(dt)
end

function tileManager:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print("Gravity Snake",0,0)
end

return tileManager