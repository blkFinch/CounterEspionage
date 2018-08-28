--init game window settings
font = love.graphics.setNewFont( "compFont.ttf", 12 )
love.graphics.setColor(0, 1, 0)

Player = {}

-- leaving this here for reference change values to change window size
-- window = love.window.setMode(300, 300)

-- init values here
function love.load()
  Player.bank = 0
end

-- update values here
function love.update()

  -- close window on esc
  if love.keyboard.isDown("escape") then love.window.close() end
end

-- for testing 
function love.keypressed(key)
  if key == "space" then
    Player.bank = Player.bank + 1
  end
end

-- draws to screen once per step
function love.draw( ... )
  love.graphics.print(Player.bank, 0, 0)
end