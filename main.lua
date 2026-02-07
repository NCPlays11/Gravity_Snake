function love.load()
    snake = require("snake")
    tileManager = require "tileManager"
    mapManager = require "mapManager"
    maps = require "maps"

    love.graphics.setDefaultFilter("nearest", "nearest")

    snake:load()
    tileManager:load()
    mapManager:load()

    mapManager:loadMap({
        startPos = maps[mapManager.level]["startPos"],
        startTail = maps[mapManager.level]["startTail"],
        map = maps[mapManager.level]["map"]
    })
end

function love.update(dt)
    mapManager:update(dt)
    snake:update(dt)
end

function love.draw()
    love.graphics.push()
    tileManager:draw()
    snake:draw()
    mapManager:draw()
    love.graphics.pop()
    love.graphics.setBackgroundColor(130 / 255, 200 / 255, 229 / 255)

    love.graphics.setColor(0, 0, 0, 1)
    local f = love.graphics.newFont(math.min(love.graphics.getDimensions()) / 25)
    local t = tostring(love.timer.getFPS())
    love.graphics.rectangle("fill", 0, 0, f:getWidth(t), f:getHeight())
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(f)
    love.graphics.print(t, 0, 0)
end

function love.keypressed(key)
    snake:keypressed(key)

    if key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
end
