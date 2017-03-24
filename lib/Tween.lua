local _M = {}

local pretty = require('pl.pretty')

-- In-action tweens
local tweens = {}

local fns = {}
setmetatable(
  fns,
  {
    __index = function (key)
      error("Function '" .. key .. "' doesn't exists")
    end
  }
)

function _M.ease_linear(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_linear', ...)
end

function _M.ease_cube_in(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_cube_in', ...)
end

function _M.ease_cube_in_out(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_cube_in_out', ...)
end

function _M.ease_cube_out(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_cube_out', ...)
end

function _M.ease_back_in(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_back_in', ...)
end

function _M.ease_back_out(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_back_out', ...)
end

function _M.ease_back_in_out(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_back_in_out', ...)
end

function _M.ease_elastic_in(obj, target_position,  duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_elastic_in', ...)
end

function _M.ease_elastic_out(obj, target_position, duration, ...)
  return _M.tween(obj, target_position, duration, 'ease_elastic_out', ...)
end

function _M.ease_elastic_in_out(obj, target_position, duration)
  return _M.tween(obj, target_position, duration, 'ease_elastic_in_out')
end

function _M.tween(obj, target_position, duration, easing_func_name, done_callback)
  assert(obj.x and obj.y, "`x` & `y` is required on tweening object")
  local new_tween = {
    _obj = obj,
    _time = 0,
    _ease = easing_func_name,
    _orig_pos = {x = obj.x, y = obj.y},
    _target_pos = target_position,
    _duration = duration or 3,
    _done_callback = done_callback or function() end
  }
  table.insert(tweens, new_tween)
  return new_tween
end

local function doUpdate(dt)
  for i, tween in ipairs(tweens) do
    local time = tween._time + dt
    local progress = tween._time / tween._duration
    tween._time = time
    if progress <= 1 then
      tween._obj.x = tween._orig_pos.x + fns[tween._ease](progress) * (tween._target_pos.x - tween._orig_pos.x)
      tween._obj.y = tween._orig_pos.y + fns[tween._ease](progress) * (tween._target_pos.y - tween._orig_pos.y)
    else
      if debug then
        print("A tween has finished")
      end
      tween._obj.x = tween._target_pos.x
      tween._obj.y = tween._target_pos.y
      if debug then
        print("A tween is cleaned up")
      end
      tween._done_callback(tween.obj)
      table.remove(tweens, i)
    end
  end
end

World.register({update = doUpdate})

--------------------------------------------------------------------------------

-- Shamelessly copied from https://www.patreon.com/saint11

-- BASIC EASING FUNCIONS CHEAT CHEET
-- (most of them are based on glide by Jacob Albano)
function fns.ease_linear(t)
	return t
end

function fns.ease_cube_in(t)
	return t * t * t
end

function fns.ease_cube_in_out(t)
	if t <= .5 then
		return t * t * t * 4
	else
		t = t - 1
		return 1 + t * t * t * 4
	end
end

function fns.ease_cube_out(t)
	t = t - 1
	return 1 + t * t * t
end

function fns.ease_back_in(t)
	return t * t * (2.70158 * t - 1.70158)
end

function fns.ease_back_out(t)
	t = t - 1
	return (1 - t * t * (-2.70158 * t - 1.70158))
end

function fns.ease_back_in_out(t)
	t = t * 2
  if (t < 1) then
    return t * t * (2.70158 * t - 1.70158) / 2
  else
    t = t - 2;
    return (1 - t * t * (-2.70158 * t - 1.70158)) / 2 + .5
  end
end

function fns.ease_elastic_in(t)
	return math.sin(13 * (math.pi/2) * t) * math.pow(2, 10 * (t - 1))
end

function fns.ease_elastic_out(t)
	return math.sin(-13 * (math.pi/2) * (t + 1)) * math.pow(2, -10 * t) + 1
end

function fns.ease_elastic_in_out(t)
	if (t < 0.5) then
        return 0.5 * (math.sin(13 * (math.pi/2) * (2 * t)) * math.pow(2, 10 * ((2 * t) - 1)))
    else
    	return 0.5 * (math.sin(-13 * (math.pi/2) * ((2 * t - 1) + 1)) * math.pow(2, -10 * (2 * t - 1)) + 2)
    end
end

return _M
