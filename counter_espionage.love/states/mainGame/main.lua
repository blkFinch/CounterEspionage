Player = {}
Enemy = {}

-- init values here
function load()
  Player.bank = 0
  randomize_enemy()
  GameState = 1
end

function randomize_enemy( ... )
  Enemy.id = love.math.random(12)
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

-- game states
function draw_main_game()
  love.graphics.print("Bank: " .. Player.bank, 0, 0)

  -- debug info
  love.graphics.print(debug_info(), 0, 100)
end

-- update values here
function love.update()

  -- close window on esc
  if love.keyboard.isDown("escape") then love.window.close() end
end
-- draws to screen once per step
function love.draw( ... )
  draw_main_game()
end