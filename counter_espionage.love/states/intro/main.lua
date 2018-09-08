
function load( ... )
  file = love.filesystem.newFile("states/intro/intro.txt", "r")
  text = { file:read(all) }
end

function love.draw()
  love.graphics.print(text,0,0)
end
