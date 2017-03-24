
return {
  load = function(filename)
    local SpriteSet
    local image = love.graphics.newImage(filename)
    local animations = {}

    local cut = {startX=0, startY=0, cols=0, sizeX=32, sizeY=32}

    local buildingName = nil -- animation builder pattern

    SpriteSet = {
      cut = function(newStartX, newStartY, newCols, newSizeX, newSizeY)
        startX = newStartX
        startY = newStartY
        cols = newCols
        sizeX = newSizeX
        sizeY = newSizeY
        return SpriteSet
      end,
      animation = function(name, frameIndexes)
        buildingName = name
        if frameIndexes == nil then
          animations[name] = {length = 0, frames = {}}
          return SpriteSet
        end
        animations[name] = {length = #frameIndexes, frames = {}}
        for i = 1, #frameIndexes do
          local index = frameIndexes[i]
          local row = 0
          local col = index - 1
          if cut.cols ~= 0 then
            row = math.floor(col/cut.cols)
            col = col % cut.cols
          end
          animations[name].frames[i] = love.graphics.newQuad(
            0 + col*cut.sizeX, 0 + row*cut.sizeY,
            cut.sizeX, cut.sizeY,
            image:getWidth(), image:getHeight())
        end
        return SpriteSet
      end,
      frame = function (x1, y1, width, height)
        if buildingName ~= nil then
          animations[buildingName].length = animations[buildingName].length + 1
          animations[buildingName].frames[animations[buildingName].length] =
            love.graphics.newQuad(x1, y1, width, height, image:getWidth(), image:getHeight())
        end
        return SpriteSet
      end,
      instance = function(entity, animation, fps)
        local currentAnimation = animation
        local frameTime = 0
        local currentFrame = 1
        local frameDelta = 0
        if fps > 0 then -- frame rate is 0 in case there is no animation
          frameTime = 1 / fps
        else
          frameTime = 0
        end

        local Sprite
        local worldEntity

        local currentLayer = 1

        Sprite = {
          animation = function(name, framerate)
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
          end,
          layer = function(layer)
            currentLayer = layer
          end,
          remove = function()
            World.remove(worldEntity)
          end
        }

        worldEntity = {
          update = function(dt)
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
          end,
          draw = function(layer)
            if layer == currentLayer then
              if currentAnimation == nil or image == nil then
                return nil
              end
              love.graphics.draw(image, animations[currentAnimation].frames[currentFrame], entity.x, entity.y)
            end
          end
        }
        World.register(worldEntity)

        return Sprite
      end
    }

    return SpriteSet
  end
}
