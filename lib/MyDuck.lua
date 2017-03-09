local MyDuck = {}

local duckSprite = require("lib.SpriteSet")().load("/res/koopa_troopa.png")

duckSprite.createAnimation("sample")
  .createFrame(364, 238, 32, 32)
  .createFrame(396, 238, 32, 32)
  .createFrame(428, 238, 32, 32)
  .createFrame(460, 238, 32, 32)
duckSprite.setAnimation("sample", 10)

function MyDuck.update(dt)
  -- TODO
  duckSprite.update(dt)
end

function MyDuck.draw(dt)
  -- TODO
  duckSprite.draw(100, 100)
end

return MyDuck
