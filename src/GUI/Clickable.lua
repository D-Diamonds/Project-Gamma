Clickable = Class{}

function Clickable:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.pressed = false
    self.hovering = false

end

function Clickable:update(dt)
    local x, y = love.mouse.getPosition()
    if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
        if love.mouse.isDown(1) then
            self.pressed = true
        else
            self.pressed = false
        end
        self.hovering = true
    else
        self.hovering = false
    end

end

function Clickable:render()
end