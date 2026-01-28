function love.load()
    snake = require("snake")

    snake:load()
end

function love.update(dt)
    snake:update(dt)
end

function love.draw()
    snake:draw()
end

function love.keypressed(key)
   snake:keypressed(key)
end