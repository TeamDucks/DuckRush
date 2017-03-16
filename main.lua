debug = true

--------------------------------------------------------------------------------
scheduler =
  (
  function()
    local this = {}
    local listUpdate = {}
    local listLayer = {}
    for i = 1, 10 do
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

    function this.addDraw(drawFunction, layer)
      layer = layer == nil and 1 or layer
      layer = layer < 1 and 1 or layer
      layer = layer > 10 and 10 or layer
      listLayer[layer][drawFunction] = drawFunction
    end

    function this.removeDraw(drawFunction, layer)
      listLayer[layer][drawFunction] = nil
    end

    function this.doDraw()
      for i = 1, 10 do
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

function love.load(arg)
  -- do nothing for now
end

function love.update(dt)
  scheduler.doUpdate(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(172,172,172,255)
  scheduler.doDraw()
end
