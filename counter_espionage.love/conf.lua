function love.conf( t )
  -- t.window.width =
  -- t.window.height =
  love.filesystem.setIdentity("CounterEspionage")
  t.window.title = "Counter Espionage"
  io.stdout:setvbuf("no")
  t.console = true
end