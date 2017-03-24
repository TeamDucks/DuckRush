local DemoDuck = {x = 32*5, y = 32*7}

local Tween = require('lib.Tween')
local SpriteSet = require("lib.SpriteSet")

local DuckSpriteSet = SpriteSet.load("/res/proto-duck.png").cut(0, 0, 3, 32, 32)
  .animation("straight", {1, 2, 1, 3})
  .animation("right", {4, 5, 4, 6})
  .animation("left", {7, 8, 7, 9})

local DuckSprite = DuckSpriteSet.instance(DemoDuck, "straight", 10).layer(_layer_duck)

local RoadSpriteSet = SpriteSet.load("/res/proto-road.png")
-- .cut(0, 0, 0, 32, 32) -- default cut
  .animation("LeftZero", {1})
  .animation("RightZero", {2})
  .animation("LeftOne", {3})
  .animation("RightOne", {4})
  .animation("LeftTwo", {5})
  .animation("RightTwo", {6})

-- TODO: cleanup / reuse off-screen tiles
local function wrapRoadSprite(animationName, pos)
  local sprite = RoadSpriteSet.instance(pos, animationName, 0).layer(_layer_road)
  local camera = World.get('camera')
  local remover = {
    update = function(dt)
      if pos.y > camera.y+32*11 then
        sprite.remove()
        World.remove(remover)
      end
    end
  }
  World.register(remover)
end

local timeTotal = 0
World.register({
    load = function()
      local camera = World.get('camera')
      for i = 1, 10 do
        wrapRoadSprite('LeftZero', {x=32*2, y=32*i})
        wrapRoadSprite('LeftOne', {x=32*3, y=32*i})
        wrapRoadSprite('LeftTwo', {x=32*4, y=32*i})
        wrapRoadSprite('RightTwo', {x=32*5, y=32*i})
        wrapRoadSprite('RightOne', {x=32*6, y=32*i})
        wrapRoadSprite('RightZero', {x=32*7, y=32*i})
      end
      camera.setPosition(0, 0)
      local function move_camera()
        wrapRoadSprite('LeftZero', {x=32*2, y=camera.y})
        wrapRoadSprite('LeftOne', {x=32*3, y=camera.y})
        wrapRoadSprite('LeftTwo', {x=32*4, y=camera.y})
        wrapRoadSprite('RightTwo', {x=32*5, y=camera.y})
        wrapRoadSprite('RightOne', {x=32*6, y=camera.y})
        wrapRoadSprite('RightZero', {x=32*7, y=camera.y})
        Tween.ease_linear(camera, {x = camera.x, y = camera.y - 32}, 2, move_camera)
      end
      move_camera()
      local function move_duck()
        Tween.ease_back_in_out(
          DemoDuck,
          {x = DemoDuck.x, y = DemoDuck.y - 32},
          2,
          move_duck
        )
      end
      move_duck()
    end,
    update = function(dt)
      timeTotal = timeTotal + dt
    end,
    draw = function(layer)
      if layer == _layer_ui then
        love.graphics.print( timeTotal, 1, 1)
      end
    end
               }, 'duck')

return DemoDuck
