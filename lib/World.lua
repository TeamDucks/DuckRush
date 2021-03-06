local entities = {}
local scheduledRemoval = {}

World = {
  decorate = function()
    local origin = {
      onload = love.load,
      update = love.update,
      draw = love.draw
    }

    love.load = function(args)
      origin.onload(args)
      for _, entity in pairs(entities) do
        if entity.load ~= nil then
          entity.load(args)
        end
      end
    end

    love.update = function(dt)
      origin.update(dt)
      for _, entity in pairs(entities) do
        if entity.update ~= nil then
          entity.update(dt)
        end
      end
      local i
      for i = 1, #scheduledRemoval do
        entities[scheduledRemoval[i]] = nil
      end
      scheduledRemoval = {}
    end

    love.draw = function()
      origin.draw()
      local i
      for i = 0, _layer_max do
        for _, entity in pairs(entities) do
          if entity.draw ~= nil then
            entity.draw(i)
          end
        end
      end
    end

    love.keypressed = function(key, isrepeat)
      for _, entity in pairs(entities) do
        if entity.keypressed then
          entity.keypressed(key, isrepeat)
        end
      end
    end

    World.decorate = function() print('Decoration removed') end
  end,
  register = function(object, name)
    if name ~= nil then
      entities[name] = object
    else
      entities[object] = object
    end
  end,
  remove = function(objectorname)
    scheduledRemoval[#scheduledRemoval+1] = objectorname
  end,
  reset = function()
    entities = {}
    scheduledRemoval = {}
  end,
  get = function(name)
    return entities[name]
  end
}

return {}
