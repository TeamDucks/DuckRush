local DemoDuck = {}

local SpriteSet = require("lib.SpriteSet")

local DuckSprite = require("lib.SpriteSet")().load("/res/proto-duck.png")
  .createAnimation("straight")
  .createFrame(1, 1, 50, 50)
  .createFrame(51, 1, 50, 50)
  .createFrame(1, 1, 50, 50)
  .createFrame(101, 1, 50, 50)
  .createAnimation("left")
  .createFrame(301, 1, 50, 50)
  .createFrame(351, 1, 50, 50)
  .createFrame(301, 1, 50, 50)
  .createFrame(401, 1, 50, 50)
  .createAnimation("right")
  .createFrame(151, 1, 50, 50)
  .createFrame(201, 1, 50, 50)
  .createFrame(151, 1, 50, 50)
  .createFrame(251, 1, 50, 50)

DuckSprite.setAnimation("straight", 10)

local RoadSprite = require("lib.SpriteSet")().load("/res/proto-road.png")

local timeTotal = 0
function DemoDuck.update(dt)
  timeTotal = timeTotal + dt
  if timeTotal > 10 and timeTotal < 11 then
    DuckSprite.setAnimation("left", 10)
  end
  if timeTotal > 20 and timeTotal < 21 then
    DuckSprite.setAnimation("right", 10)
  end
  DuckSprite.update(dt)
end

function DemoDuck.draw()
  love.graphics.print( timeTotal, 1, 1)
  DuckSprite.draw(50, 50)
end

return DemoDuck
