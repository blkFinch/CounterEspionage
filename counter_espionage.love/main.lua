--init game window settings
font = love.graphics.setNewFont( "compFont.ttf", 12 )
love.graphics.setColor(0, 1, 0)

Player = {}
Enemy = {}

-- leaving this here for reference change values to change window size
-- window = love.window.setMode(300, 300)

-- init values here
function love.load()
  Player.bank = 0
  randomize_enemy()
end

function randomize_enemy( ... )
  Enemy.id = love.math.random(12)
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
  if key == "r" then
    randomize_enemy()
  end
end

function debug_info( ... )
  return "Enemy Location: " .. Enemy.id
end

-- draws to screen once per step
function love.draw( ... )
  love.graphics.print("Bank: " .. Player.bank, 0, 0)

  -- debug info
  love.graphics.print(debug_info(), 0, 100)
end