-- Global single instance of game camera
local Camera

Camera = {
  x = 0, y = 0,
  draw = function(layer)
    if layer == _layer_camera_init then
      love.graphics.push()
      love.graphics.translate(Camera.x, - Camera.y)
    end
    if layer == _layer_camera_end then
      love.graphics.pop()
    end
  end,
  setPosition = function(x, y)
    Camera.x = x
    Camera.y = y
  end
}
World.register(Camera, 'camera')

return Camera
