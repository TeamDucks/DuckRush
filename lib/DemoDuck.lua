local DemoDuck = {}

local SpriteSet = require("lib.SpriteSet")

local DuckSprite = require("lib.SpriteSet")().load("/res/proto-duck.png")
  .createAnimation("straight")
  .createFrame(1, 1, 50, 50)
  .createFrame(51, 1, 50, 50)
  .createFrame(1, 1, 50, 50)
  .createFrame(101, 1, 50, 50)

DuckSprite.setAnimation("straight", 10)

local RoadSprite = require("lib.SpriteSet")().load("/res/proto-road.png")

local timeTotal = 0
function DemoDuck.update(dt)
  timeTotal = timeTotal + dt
  DuckSprite.update(dt)
end

function DemoDuck.draw()
  DuckSprite.draw(50, 50)
end

return DemoDuck
