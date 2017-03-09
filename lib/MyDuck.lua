local MyDuck = {}

local duckSprite = require("lib.SpriteSet")().load("/res/koopa_troopa.png")

-- Return next frame coordinations (x,y,w,h) on every invokes
function frameStepper(offsetX, offsetY, frameWidth, frameHeight)
  local step = -1
  return function()
    step = step + 1
    return offsetX + frameWidth * step, offsetY, frameWidth, frameHeight
  end
end

--- Create animations for spritesheets have frame size divided evenly
-- @param sprite SpriteSet
-- @param name string animation name
-- @param stepper frameStepper
-- @param frameCount number of expected frames on spritesheet
function initAnimation(sprite, name, stepper, frameCount)
  local anim = sprite.createAnimation(name)
  function frameIter(remainSteps)
    if (remainSteps == 0) then
      return
    else
      anim.createFrame(stepper())
      frameIter(remainSteps - 1)
    end
  end
  frameIter(frameCount)
end

------------------------------------------------------------

local duckSprite = require("lib.SpriteSet").load("/res/koopa_troopa.png")

-- Fine-grained framing
duckSprite.createAnimation("sample")
  .createFrame(364, 238, 32, 32)
  .createFrame(396, 238, 32, 32)
  .createFrame(428, 238, 32, 32)
  .createFrame(460, 238, 32, 32)

initAnimation(duckSprite, "retract", frameStepper(4,88,35,64), 7)
duckSprite.setAnimation("retract", 10)

function MyDuck.update(dt)
  -- TODO
  duckSprite.update(dt)
end

function MyDuck.draw(dt)
  -- TODO
  local centerX = love.graphics.getWidth() / 2
  local centerY = love.graphics.getHeight() / 2

  duckSprite.draw(centerX - 8, centerY - 8)
  local blame = "Thua! Sheet gì khó chia quá"
  love.graphics.print(blame,
                      centerX - love.graphics.getFont():getWidth(blame) / 2,
                      centerY + love.graphics.getFont():getHeight(blame) + 60)
end

return MyDuck
