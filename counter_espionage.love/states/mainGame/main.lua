
-- declaring globals
Player = {}
Enemy = {}

MenuState = ""

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
   intel = "gather more intel",
   save_game = "save game?", --for testing
   load_game = "load game?"

   -- add in option to reduce spy positions?
  }

  MenuState = "main"

  guessMenu = {
    one = "first cubicle",
    two = "second cubicle"
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
  
  -- displays menu descriptions
  if MenuState == "main" then
    if playerMenuChoice == 1 then
      playerMenu = playerMove.guess
    elseif playerMenuChoice == 2 then
      playerMenu = playerMove.intel
    elseif playerMenuChoice == 3 then
      playerMenu = playerMove.save_game
    elseif playerMenuChoice == 4 then
      playerMenu = playerMove.load_game
    end
  elseif MenuState == "guess" then 
    playerMenu = "Use Left and Right to adjust your guess"
  else
    playerMenu = "something went wrong :<"
  end
end


function enemy_turn()
  -- random attempt at stealing player's money
  -- two 6 sided die roll, if they match it is a hit
  -- against player
end

-- for testing
function love.keypressed(key)
  if key == "m" then
    Player.bank = Player.bank + 1
  end

  if key == "r" then
    randomize_enemy()
  end

-- MAIN MENU
  if MenuState == "main" then 

    if key == "return" then
      handle_main_menu_input()
    end

    if key == "down" and playerMenuChoice < 4 then
      playerMenuChoice = playerMenuChoice + 1
    end 
    if key == "up" and playerMenuChoice > 1 then 
      playerMenuChoice = playerMenuChoice - 1
    end
-- Guess Menu
  elseif MenuState == "guess" then
    if key == "left" and Player.guess > 1 then
      Player.guess = Player.guess - 1
    end
    if key == "right" and Player.guess < 12 then
      Player.guess = Player.guess + 1
    end

    if key == "return" then
      check_enemy()
    end
  end


end

function handle_main_menu_input()
  if playerMenu == playerMove.guess then
    MenuState = "guess"
  elseif playerMenu == playerMove.save_game then 
    love.filesystem.write("player_save.txt", serpent.dump(Player))
    textWindow = "game saved!"
  elseif playerMenu == playerMove.load_game then 
    Player = love.filesystem.load("player_save.txt") {}
  end
end

function debug_info( ... )
  return "Enemy Location: " .. Enemy.id .. " MenuState: " .. MenuState
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

-- for save game TODO: extract this to a globally required file
--took this function from RiciLake @ http://lua-users.org/wiki/TableSerialization
function table.show(t, name, indent)
  local cart     -- a container
  local autoref  -- for self references

  --[[ counts the number of elements in a table
  local function tablecount(t)
     local n = 0
     for _, _ in pairs(t) do n = n+1 end
     return n
  end
  ]]
  -- (RiciLake) returns true if the table is empty
  local function isemptytable(t) return next(t) == nil end

  local function basicSerialize (o)
     local so = tostring(o)
     if type(o) == "function" then
        local info = debug.getinfo(o, "S")
        -- info.name is nil because o is not a calling level
        if info.what == "C" then
           return string.format("%q", so .. ", C function")
        else 
           -- the information is defined through lines
           return string.format("%q", so .. ", defined in (" ..
               info.linedefined .. "-" .. info.lastlinedefined ..
               ")" .. info.source)
        end
     elseif type(o) == "number" or type(o) == "boolean" then
        return so
     else
        return string.format("%q", so)
     end
    end
  end