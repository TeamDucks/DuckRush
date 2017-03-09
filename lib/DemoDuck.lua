local DemoDuck = {}

local SpriteSet = require("lib.SpriteSet")

local DuckSprite = require("lib.SpriteSet")().load("/res/proto-duck.png")
  .createAnimation("straight")
  .createFrame(0, 0, 50, 50)
  .createFrame(50, 0, 50, 50)
  .createFrame(0, 0, 50, 50)
  .createFrame(100, 0, 50, 50)
  .createAnimation("left")
  .createFrame(300, 0, 50, 50)
  .createFrame(350, 0, 50, 50)
  .createFrame(300, 0, 50, 50)
  .createFrame(400, 0, 50, 50)
  .createAnimation("right")
  .createFrame(150, 0, 50, 50)
  .createFrame(200, 0, 50, 50)
  .createFrame(150, 0, 50, 50)
  .createFrame(250, 0, 50, 50)

DuckSprite.setAnimation("straight", 10)

local RoadSprite = require("lib.SpriteSet")().load("/res/proto-road.png")
  .createAnimation("LeftZero").createFrame(0, 0, 50, 50)
  .createAnimation("RightZero").createFrame(50, 0, 50, 50)
  .createAnimation("LeftMinusOne").createFrame(100, 0, 50, 50)
  .createAnimation("RightMinusOne").createFrame(150, 0, 50, 50)
  .createAnimation("LeftPlusOne").createFrame(200, 0, 50, 50)
  .createAnimation("RightPlusOne").createFrame(250, 0, 50, 50)
  .createAnimation("LeftOne").createFrame(300, 0, 50, 50)
  .createAnimation("RightOne").createFrame(350, 0, 50, 50)
  .createAnimation("LeftTwo").createFrame(400, 0, 50, 50)
  .createAnimation("RightTwo").createFrame(450, 0, 50, 50)

local timeTotal = 0
function DemoDuck.update(dt)
  timeTotal = timeTotal + dt
  DuckSprite.update(dt)
end

function DemoDuck.draw()
  love.graphics.print( timeTotal, 1, 1)
  DuckSprite.draw(50, 50)
  -- FIXME: draw multiple animation instances
  RoadSprite.setAnimation("LeftOne", 0)
  RoadSprite.draw(100, 100)
  RoadSprite.setAnimation("RightOne", 0)
  RoadSprite.draw(200, 100)
end

return DemoDuck
