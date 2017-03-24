debug = true

function love.load(arg)
end

function love.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(172,172,172,255)
end

require("lib.Layer")
require ('lib.World') -- World will override functions
require('lib.DemoDuck')
require('lib.Camera')
