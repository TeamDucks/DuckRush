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
for i = 0, -1000, -1 do
  RoadSpriteSet.instance({x=32*2, y=600+32*i}, 'LeftZero', 0).layer(_layer_road)
  RoadSpriteSet.instance({x=32*3, y=600+32*i}, 'LeftOne', 0).layer(_layer_road)
  RoadSpriteSet.instance({x=32*4, y=600+32*i}, 'LeftTwo', 0).layer(_layer_road)
  RoadSpriteSet.instance({x=32*5, y=600+32*i}, 'RightTwo', 0).layer(_layer_road)
  RoadSpriteSet.instance({x=32*6, y=600+32*i}, 'RightOne', 0).layer(_layer_road)
  RoadSpriteSet.instance({x=32*7, y=600+32*i}, 'RightZero', 0).layer(_layer_road)
end

local timeTotal = 0
World.register({
    load = function()
      local camera = World.get('camera')
      camera.setPosition(0, 0)
      Tween.ease_linear(camera, {x = 0, y = -1000}, 60)
      local function move_duck()
        Tween.ease_back_in_out(
          DemoDuck,
          {x = DemoDuck.x, y = DemoDuck.y - 35},
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
