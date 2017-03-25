local function getCenter(obj) 
    local width = love.graphics.getWidth()/2
    local height = love.graphics.getHeight()/2

    return {
        x= width,
        y = height 
    }
end

local function getCenter() 
    return {
        x = love.graphics.getWidth()/2,
        y = love.graphics.getHeight()/2
    }
end

return {
    getCenter = getCenter
}