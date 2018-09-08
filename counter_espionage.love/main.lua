--init game window settings
font = love.graphics.setNewFont( "compFont.ttf", 12 )
love.graphics.setColor(0, 1, 0)



-- setting up state management
function clearLoveCallbacks( ... )
  love.draw = nil
  love.keypressed = nil
  love.keyreleased = nil
  love.joystickpressed = nil
  love.joystickreleased = nil
  -- love.load = nil
  love.mousepressed= nil
  love.mousereleased = nil
  love.update = nil
end

state = {}
function loadState( name )
  state = {}
  clearLoveCallbacks()
  local path = "states/" .. name
  require(path .. "/main")
  load() --this function called from inside state
end

function load( ... )
 -- dummy function to be replaced by state load function
end

function love.load( ... )
  loadState("intro")
end

function love.keypressed( key )
  if key == "s" then loadState("mainGame") end
end

