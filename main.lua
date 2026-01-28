function love.load()
    snake = {}
    snake.x = 200
    snake.y = 250
end

function love.update(dt)

end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", snake.x, snake.y, 50, 50)
end

function love.keyreleased(key)
   if key == "w" then
      snake.y = snake.y - 50
   elseif key == "s" then
      snake.y = snake.y + 50
   elseif key == "a" then
      snake.x = snake.x - 50
   elseif key == "d" then
      snake.x = snake.x + 50
   end
end