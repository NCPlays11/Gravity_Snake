function love.load()
    snake = require("snake")
    tileManager = require "tileManager"
    mapManager = require "mapManager"

    love.graphics.setDefaultFilter("nearest","nearest")

    snake:load()
    tileManager:load()
    mapManager:load()

    mapManager:loadMap({
        startPos = {x=2,y=5},
        startTail = {{x=0,y=4},{x=1,y=4}},
        map={
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,1,5,6,7,8,2},
            {1,1,1,1,1,1,1,1,1,1},
        }
    })
end

function love.update(dt)
    snake:update(dt)
end

function love.draw()
    love.graphics.push()
    tileManager:draw()
    snake:draw()
    mapManager:draw()
    love.graphics.pop()
end

function love.keypressed(key)
   snake:keypressed(key)

   if key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
end