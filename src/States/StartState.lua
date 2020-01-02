StartState = Class{__includes = BaseState}

function StartState:init()
	local buttonWidth = 120
	local buttonHeight = 50

	-- buttons to switch between the  states
	self.buttons = {
		["start"] = Button ({
			x = VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2 - 90,
			width = buttonWidth,
			height = buttonHeight,
			text = "Start", 
			onClick = function()
				stateMachine:change("play", loadData())
			end}, "rect"),
		["settings"] = Button ({
			x = VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2 - 30,
			width = buttonWidth,
			height = buttonHeight,
			text = "Settings", onClick = function()
				stateMachine:change("settings")
			end}, "rect"),
		["achievment"] = Button ({
			x = VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 30,
			width = buttonWidth,
			height = buttonHeight,
			text = "Achievments", onClick = function()
				stateMachine:change("achievment")
				velY = 0
			end}, "rect"),
		["quit"] = Button ({
			x = VIRTUAL_WIDTH / 2 - buttonWidth / 2, 
			y = VIRTUAL_HEIGHT / 2 - buttonHeight / 2 + 90,
			width = buttonWidth,
			height = buttonHeight,
			text = "Quit", onClick = function()
				love.event.quit()
			end}, "rect"),
		["instructions"] = Button ({
			x = VIRTUAL_WIDTH - buttonWidth - 10, 
			y = 10,
			width = buttonWidth,
			height = buttonHeight,
			text = "Instructions", onClick = function()
				stateMachine:change("instructions")
			end}, "rect")
	}

end

function StartState:update(dt)
	for i, button in pairs(self.buttons) do
		button:update(dt)
	end
end

function StartState:render()
	for i, button in pairs(self.buttons) do
		button:render()
	end
end




