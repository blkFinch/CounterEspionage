function load( ... )
  logo = love.graphics.newImage('images/CE_Logo.png')

--init splash cover at origin
  xPos = 0
  yPos = 0
  speed = 400
end

function love.update(dt)
  if(xPos < 700) then
    -- moves xPos by speed * delta time
    xPos = xPos + ( dt * speed )
  end

  -- temp input grab to switch state
  if love.keyboard.isDown("space") then
    loadState("intro")
  end
end

function love.draw( ... )
  love.graphics.setColor(0,1,0)
  love.graphics.draw(logo, 10, 10)

  if xPos < 700 then
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill',xPos, yPos, 700, 400)
  else
    love.graphics.print('Press Space To Start', 200, 500)
  end
end

