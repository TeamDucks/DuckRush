debug = true

local DemoDuck = require('lib.DemoDuck')

function love.load(arg)

end

function love.update(dt)
  -- TODO
 DemoDuck.update(dt)
end

function love.draw()
  -- TODO
  DemoDuck.draw()
  love.graphics.setBackgroundColor(172,172,172,255)
end
