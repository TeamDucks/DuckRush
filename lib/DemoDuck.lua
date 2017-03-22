local DemoDuck = {}

local SpriteSet = require("lib.SpriteSet")

local DuckSpriteSet = require("lib.SpriteSet")().load("/res/proto-duck.png").cut(0, 0, 3, 32, 32)
  .cutAnimation("straight", {1, 2, 1, 3})
  .cutAnimation("right", {4, 5, 4, 6})
  .cutAnimation("left", {7, 8, 7, 9})

local DuckSprite = DuckSpriteSet.createSprite().setAnimation("straight", 10).setPosition(32*5, 32*5, 10)

local RoadSpriteSet = require("lib.SpriteSet")().load("/res/proto-road.png")
-- .cut(0, 0, 0, 32, 32) -- default cut
  .cutAnimation("LeftZero", {1})
  .cutAnimation("RightZero", {2})
  .cutAnimation("LeftOne", {3})
  .cutAnimation("RightOne", {4})
  .cutAnimation("LeftTwo", {5})
  .cutAnimation("RightTwo", {6})

for i = 0, 11 do
  RoadSpriteSet.createSprite().setAnimation('LeftZero', 0).setPosition(32*2, 32*i)
  RoadSpriteSet.createSprite().setAnimation('LeftOne', 0).setPosition(32*3, 32*i)
  RoadSpriteSet.createSprite().setAnimation('LeftTwo', 0).setPosition(32*4, 32*i)
  RoadSpriteSet.createSprite().setAnimation('RightTwo', 0).setPosition(32*5, 32*i)
  RoadSpriteSet.createSprite().setAnimation('RightOne', 0).setPosition(32*6, 32*i)
  RoadSpriteSet.createSprite().setAnimation('RightZero', 0).setPosition(32*7, 32*i)
end

local timeTotal = 0
function updateDuck(dt)
  timeTotal = timeTotal + dt
end
scheduler.addUpdate(updateDuck)

function drawTime()
  love.graphics.print( timeTotal, 1, 1)
end

return DemoDuck
