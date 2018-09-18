Player = {}
Enemy = {}

playerTurn = true

-- init values here
function load()
  Player.bank = 0
  Player.guess = 1

  textResponse = {
    no_money = "You do not have enough money",
    wrong_guess = "You eliminated an inocent employee",
    player_turn = " It is your turn -- What would you like to do?",
    empty = " "
  }

  playerMenuChoice = 1 

  playerMove = {
   guess = "Attempt to eliminate spy",
   intel = "gather more intel"
   -- add in option to reduce spy positions?
  }

  textWindow = " "
  playerMenu = " "

  randomize_enemy()
end

function randomize_enemy( ... )
  Enemy.id = love.math.random(12)
end

function check_enemy( ... )
  playerTurn = false
  if Player.guess == Enemy.id then
    loadState("win")
  else
    textWindow = textResponse.wrong_guess
  end
end

function player_turn( ... )
  textWindow = textResponse.player_turn .. "\n use up and down to choose: "
  
  if playerMenuChoice == 1 then
    playerMenu = playerMove.guess
  elseif playerMenuChoice == 2 then
    playerMenu = playerMove.intel
  end

  if love.keyboard.isDown("down") and playerMenuChoice < 2 then
    playerMenuChoice = playerMenuChoice + 1
  end

  if love.keyboard.isDown("up") and playerMenuChoice > 1 then
    playerMenuChoice = playerMenuChoice - 1
  end

end

function enemy_turn()
  -- random attempt at stealing player's money
  -- two 6 sided die roll, if they match it is a hit
  -- against player
end

-- for testing
function love.keypressed(key)
  if key == "space" then
    Player.bank = Player.bank + 1
  end

  if key == "r" then
    randomize_enemy()
  end

  if key == "return" and playerMenu == playerMove.guess then
    check_enemy()
  end

-- move to 'guess' state
  -- if key == "up" and Player.guess < 12 then
  --   Player.guess= Player.guess + 1
  -- end
  -- if key == "down" and Player.guess > 1 then
  --   Player.guess= Player.guess - 1
  -- end
end

function debug_info( ... )
  return "Enemy Location: " .. Enemy.id
end


-- update values here
function love.update()
  if(playerTurn) then
    player_turn()
  end

  -- close window on esc
  if love.keyboard.isDown("escape") then love.window.close() end
end

-- draws to screen once per step
function love.draw( ... )
  -- TODO consider breaking this into draw_player_turn and draw_enemy_turn
  draw_main_game()
end


function draw_main_game()
  love.graphics.print("Bank: " .. Player.bank, 0, 0)
  love.graphics.print("Guess: " .. Player.guess, 0, 20)
  love.graphics.print(textWindow, 5, 300)
  love.graphics.print(playerMenu, 200, 350)

  -- debug info
  love.graphics.print(debug_info(), 0, 500)
end