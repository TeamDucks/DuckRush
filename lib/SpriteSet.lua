return function ()
  local SpriteSet = {}
  local image = nil
  local animations = {}

  function SpriteSet.load(filename)
    image = love.graphics.newImage(filename)
    return SpriteSet
  end

  local buildingName = nil
  function SpriteSet.createAnimation(name)
    animations[name] = {length = 0, frames = {}}
    buildingName = name
    return SpriteSet
  end

  function SpriteSet.createFrame(x1, y1, width, height)
    if buildingName ~= nil then
      animations[buildingName].length = animations[buildingName].length + 1
      animations[buildingName].frames[animations[buildingName].length] = love.graphics.newQuad(x1, y1, width, height, image:getWidth(), image:getHeight())
    end
    return SpriteSet
  end

  function SpriteSet.createSprite()
    local Sprite = {x = 0, y = 0}
    local currentAnimation = nil
    local frameTime = 0
    local currentFrame = 1
    local frameDelta = 0

    function Sprite.setAnimation(name, frameRate)
      if animations[name] ~= nil then
        if currentAnimation ~= name then -- reset animation only if the name is changed
          currentAnimation = name
          currentFrame = 1
          frameDelta = 0
        end
        if frameRate > 0 then -- frame rate is 0 in case there is no animation
          frameTime = 1 / frameRate
        else
          frameTime = 0
        end
      end
      return Sprite
    end

    function updateSprite(dt)
      if currentAnimation == nil or image == nil then
        return nil
      end
      if frameTime ~= 0 then
        frameDelta = frameDelta + dt
        while frameDelta > frameTime do
          frameDelta = frameDelta - frameTime
          if currentFrame >= animations[currentAnimation].length then
            currentFrame = 1
          else
            currentFrame = currentFrame + 1
          end
        end
      end
    end
    scheduler.addUpdate(updateSprite)

    local layer = 1
    function drawSprite()
      if currentAnimation == nil or image == nil then
        return nil
      end
      love.graphics.draw(image, animations[currentAnimation].frames[currentFrame], Sprite.x, Sprite.y)
    end
    scheduler.addDraw(drawSprite, layer)
    function Sprite.setPosition(posX, posY, posLayer)
      Sprite.x, Sprite.y = posX, posY
      if posLayer ~= nil and posLayer ~= layer then
        scheduler.removeDraw(drawSprite, layer)
        scheduler.addDraw(drawSprite, posLayer)
        layer = posLayer
      end
      return Sprite
    end

    function Sprite.removeSchedule()
      scheduler.removeUpdate(updateSprite)
      scheduler.removeDraw(drawSprite, layer)
    end

    return Sprite
  end

  return SpriteSet
end
