local MyDuck = {}

 ------------ Experimental animation utils --------------------------

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

-- Kiem cai sheet gi ma kho chia qua
initAnimation(duckSprite, "retract", frameStepper(4,88,35,64), 7)
duckSprite.setAnimation("retract", 5)

function MyDuck.update(dt)
  -- TODO
  duckSprite.update(dt)
end

function MyDuck.draw(dt)
  -- TODO
  duckSprite.draw(
    (love.graphics.getWidth() - 16) / 2,
    (love.graphics.getHeight() - 16) / 2);
end

return MyDuck
