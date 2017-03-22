-- Global single instance of game camera
local Camera = {x = 0, y = 0}

function doDraw()
  love.graphics.translate(Camera.x, - Camera.y)
end

scheduler.addDraw(doDraw, 0)

function Camera.setPosition(x, y)
  Camera.x = x
  Camera.y = y
end

return Camera
