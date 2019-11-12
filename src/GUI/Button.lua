
Button = Class{}

function Button:init(defs, shape, floorNumber)
    -- x, y, width, height, text, onClick, shape
    if shape == "rect" then
        self.clickable = Clickable(defs.x, defs.y, defs.width, defs.height, defs.onClick, floorNumber)
    -- verticies
    elseif shape == "triangle" then
        self.verticiesForRender = {}
        for i, coord in pairs(defs.verticies) do
            for j, value in pairs(coord) do
                table.insert(self.verticiesForRender, value)
            end
        end
        self.clickable = TriangleClickable(defs.verticies, defs.onClick, floorNumber)
    end
    self.shape = shape
    self.text = defs.text
    self.textColor = "black"
    self.buttonColor = "gray"
end

function Button:update(dt)
    self.clickable:update(dt)

    if self.clickable:wasClicked() then
        self.buttonColor = "blue"
    elseif self.clickable:isHovering() then
        self.buttonColor = "black"
    else
        self.buttonColor = "gray"
    end


    if self.clickable:isHovering() then
        self.textColor = "white"
    else
        self.textColor = "black"
    end

end

function Button:render()
    setColor(colors[self.buttonColor])
    if self.shape == "rect" then--draw actual button if rectangle
        love.graphics.rectangle("fill", self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
        love.graphics.setFont(love.graphics.newFont(currFont, 20))
        font = love.graphics.getFont()
        setColor(colors[self.textColor])
        love.graphics.print(self.text, math.floor(self.clickable.x + self.clickable.width / 2 - font:getWidth(self.text) / 2), math.floor(self.clickable.y + self.clickable.height / 2 - font:getHeight(self.text) / 2))

    elseif self.shape == "triangle" then--draw actual button if triangle
        setColor(colors["purple"])
        love.graphics.polygon('fill', self.verticiesForRender)
    end
    
end