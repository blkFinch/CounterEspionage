
function load( ... )
  file = love.filesystem.newFile("states/intro/intro.txt", "r")
  text = file:read(all)
  substring = " "
  i = 1
  delay = 10
  speed = 300
end

function love.update( dt )
  delay = delay - (dt * speed)
  if(delay <= 0 and i <= #text )then
    delay = 10
    substring = string.sub(text,1,i)
    i = i + 1
  end

  if love.keyboard.isDown("return") then loadState("mainGame") end
end

function love.draw()
  love.graphics.print(substring , 30, 40)
  love.graphics.print('Press "Enter" to Begin...', 30, 500)
end
