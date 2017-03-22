return function ()
  local SpriteSet = {}
  local image = nil
  local animations = {}

  function SpriteSet.load(filename)
    image = love.graphics.newImage(filename)
    return SpriteSet
  end

  local cut = {startX=0, startY=0, cols=0, sizeX=32, sizeY=32}
  function SpriteSet.cut(newStartX, newStartY, newCols, newSizeX, newSizeY)
    startX = newStartX
    startY = newStartY
    cols = newCols
    sizeX = newSizeX
    sizeY = newSizeY
    return SpriteSet
  end

  function SpriteSet.cutAnimation(name, frameIndexes)
    animations[name] = {length = #frameIndexes, frames = {}}
    for i = 1, #frameIndexes do
      local index = frameIndexes[i]
      local row = 0
      local col = index - 1
      if cut.cols ~= 0 then
        row = math.floor(col/cut.cols)
        col = col % cut.cols
      end
      animations[name].frames[i] = love.graphics.newQuad(0 + col*cut.sizeX, 0 + row*cut.sizeY, cut.sizeX, cut.sizeY, image:getWidth(), image:getHeight())
    end
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
    local Sprite = {}
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

    local x = 0; local y = 0
    local layer = 1
    function drawSprite()
      if currentAnimation == nil or image == nil then
        return nil
      end
      love.graphics.draw(image, animations[currentAnimation].frames[currentFrame], x, y)
    end
    scheduler.addDraw(drawSprite, layer)
    function Sprite.setPosition(posX, posY, posLayer)
      x, y = posX, posY
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
