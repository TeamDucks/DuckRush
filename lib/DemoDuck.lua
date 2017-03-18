local DemoDuck = {}

local DuckSpriteSet = require("lib.SpriteSet")().load("/res/proto-duck.png")
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

local DuckSprite = DuckSpriteSet.createSprite().setAnimation("straight", 10).setPosition(150, 450, 10)

local RoadSpriteSet = require("lib.SpriteSet")().load("/res/proto-road.png")
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

-- TODO: cleanup / reuse off-screen tiles
for i = 0, -1000, -1 do
  RoadSpriteSet.createSprite().setAnimation('LeftZero',  0).setPosition(100, 600 + 50*i)
  RoadSpriteSet.createSprite().setAnimation('RightOne',  0).setPosition(150, 600 + 50*i)
  RoadSpriteSet.createSprite().setAnimation('LeftOne',   0).setPosition(200, 600 + 50*i)
  RoadSpriteSet.createSprite().setAnimation('RightZero', 0).setPosition(250, 600 + 50*i)
end

local timeTotal = 0
function updateDuck(dt)
  timeTotal = timeTotal + dt
end
scheduler.addUpdate(updateDuck)

function drawTime()
  love.graphics.print( timeTotal, 1, 1)
end

DemoDuck.duck = DuckSprite

return DemoDuck
