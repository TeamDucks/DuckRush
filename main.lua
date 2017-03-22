debug = true

--------------------------------------------------------------------------------
scheduler =
  (
  function()
    local this = {}
    local listUpdate = {}
    local listLayer = {}
    for i = 0, 10 do
      listLayer[i] = {}
    end

    function this.addUpdate(updateFunction)
      listUpdate[updateFunction] = updateFunction
    end

    function this.removeUpdate(updateFunction)
      listUpdate[updateFunction] = nil
    end

    function this.doUpdate(dt)
      for _, func in pairs(listUpdate) do
        func(dt)
      end
    end

    --- Layer 0 is for special setup operation like camera
    function this.addDraw(drawFunction, layer)
      layer = layer == nil and 1 or layer
      layer = layer < 0 and 1 or layer
      layer = layer > 10 and 10 or layer
      listLayer[layer][drawFunction] = drawFunction
    end

    function this.removeDraw(drawFunction, layer)
      listLayer[layer][drawFunction] = nil
    end

    function this.doDraw()
      for i = 0, 10 do
        for _, func in pairs(listLayer[i]) do
          func()
        end
      end
    end

    return this
  end
  )() -- global update/draw manager
--------------------------------------------------------------------------------

local demoDuck = require('lib.DemoDuck')
local Tween = require('lib.Tween')
local camera = require('lib.Camera')


function love.load(arg)
  -- do nothing for now
  camera.setPosition(0, 0)
  Tween.ease_linear(camera, {x = 0, y = -1000}, 60)

  local function move_duck()
    Tween.ease_back_in_out(
      demoDuck.duck,
      {x = demoDuck.duck.x, y = demoDuck.duck.y - 35},
      2,
      move_duck)
  end
  move_duck()
end

function love.update(dt)
  scheduler.doUpdate(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(172,172,172,255)
  scheduler.doDraw()
end
