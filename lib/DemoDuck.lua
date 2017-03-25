local utils = require('utils')
local Tween = require('lib.Tween')
local SpriteSet = require("lib.SpriteSet")

-- local DemoDuck = {x = 32*5, y = 32*7}
local DemoDuck = utils.getCenter()
local numOfRowRoad = math.ceil(love.graphics.getHeight()/32)
local tweenTime = 1
local direction = 0

--Controls--

--end of controls--
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
      if pos.y > camera.y+32*numOfRowRoad then
        sprite.remove()
        World.remove(remover)
      end
    end
  }
  World.register(remover)
end

local timeTotal = 0
local function renderRoadRow(x,y)
  wrapRoadSprite('LeftZero', {x=x-32*3, y=y})
  wrapRoadSprite('LeftOne', {x=x-32*2, y=y})
  wrapRoadSprite('LeftTwo', {x=x-32, y=y})

  wrapRoadSprite('RightTwo', {x=x, y=y})
  wrapRoadSprite('RightOne', {x=x+32, y=y})
  wrapRoadSprite('RightZero', {x=x+32*2, y=y})
end
World.register({
    load = function()
      local camera = World.get('camera')
      local xy = utils.getCenter()
      for i = 0,numOfRowRoad do
        renderRoadRow(xy.x, i*32)
      end
      camera.setPosition(0, 0)
      local function move_camera()
        --love.graphics.print("Tween ended", 0, 50)
        renderRoadRow(xy.x, camera.y-32)
        Tween.ease_linear(camera, {x = camera.x, y = camera.y - 32}, tweenTime, move_camera)
      end
      move_camera()
      local function move_duck()
        Tween.ease_back_in_out(
          DemoDuck,
          {x = DemoDuck.x + direction*32, y = DemoDuck.y - 32},
          tweenTime,
          move_duck
        )
      end
      move_duck()
    end,
    update = function(dt)
      timeTotal = timeTotal + dt
      --DemoDuck.y = DemoDuck.y - dt * 32/tweenTime
      --World.get('camera').y = DemoDuck.y
    end,
    draw = function(layer)
      if layer == _layer_ui then
        love.graphics.print( timeTotal, 1, 1)
      end
    end,
    keypressed = function(key)
      if key == 'left' then
        direction = -1
        DuckSprite.animation('left', 10)
      elseif key == 'right' then
        direction = 1
        DuckSprite.animation('right', 10)
      else
        direction = 0
        DuckSprite.animation('straight', 10)
      end
    end
               }, 'duck')

return DemoDuck
