debug = true

local MyDuck = require('lib.MyDuck')

function love.load(arg)

end

function love.update(dt)
  -- TODO
 MyDuck.update(dt)
end

function love.draw()
  -- TODO
  love.graphics.setBackgroundColor(172,172,172,255)
  MyDuck.draw()
end
