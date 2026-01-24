function love.load()
    tileManager = require "tileManager"

    tileManager:load()
end

function love.update(dt)
    tileManager:update(dt)
end

function love.draw()
    tileManager:draw()
end
