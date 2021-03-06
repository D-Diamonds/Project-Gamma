Cell = Class{}

function Cell:init(newFloor, defs, floorNumber, cellNum)
	self.floorNumber = floorNumber
	self.clickable = Clickable(defs.x, defs.y, defs.width, defs.height, function()
		if not self.cubicle.purchased then
			self.buyCubicle.upgrading = true
		else
			self.upgradeWorker.upgrading = true
		end
	end, floorNumber)
	self.color = colors['gray']--sets color of button
	self.border = "line"--sets type of border around button

	if not newFloor then--if it's not a new save file or new floor, then use saved data to make worker
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, data = defs.data, floorNum = floorNumber, cellNum = cellNum, floorNum = self.floorNumber}
	else--otherwise, make a new worker
		self.cubicle = Cubicle {x = self.clickable.x, y = self.clickable.y, width = self.clickable.width, height = self.clickable.height, data = {false, 0, nil, math.random(self.floorNumber + 1, self.floorNumber + SPRITE_VARIANTS), 0}, floorNum = floorNumber, cellNum = cellNum, floorNum = self.floorNumber}
	end

	self.buyCubicle = UpgradeMenu ({--creates the option to buy a cubicle when a cell is clicked
		x = self.clickable.x,
		y = self.clickable.y,
		width = self.clickable.width,
		height = self.clickable.height,
		type = "Cubicle",
		cost = self.cubicle.price,
		buttonText = "Buy",
		onClick = function() 
			if self.buyCubicle:purchase() then
				self.cubicle:buyWorker()
				print("Purchased Cubicle")
			end
		end,
		timer = true
	}, floorNumber)

	self.upgradeWorker = UpgradeMenu ({--creates the option to upgrade a worker when a cell is clicked
		x = self.clickable.x,
		y = self.clickable.y,
		width = self.clickable.width,
		height = self.clickable.height,
		type = "Worker",
		cost = (DEFAULT_UPGRADE_COST * (math.pow(1.5, floorNumber - 1)))*(math.pow(2, self.cubicle.worker.upgradeLevel)),
		buttonText = "Upgrade",
		onClick = function() 
			if self.upgradeWorker:purchase() then
				local playState = stateMachine.current:getPlayState()
			    stateMachine:change("flappy", {playState = playState, workerLevel = self.cubicle.worker.upgradeLevel})
				self.cubicle.worker:upgrade()
				print("Upgraded Worker")
				self:newUpgradeWorker()
			end
		end,
		timer = true
	}, floorNumber)
end


function Cell:update(dt)
	self.clickable:update(dt)
	self.buyCubicle:update(dt)
	if self.buyCubicle.button.clickable:isHovering() and money >= self.buyCubicle.cost then
		self.buyCubicle.button.buttonColor = "green"
	elseif self.buyCubicle.button.clickable:isHovering() and money < self.buyCubicle.cost then
		self.buyCubicle.button.buttonColor = "red"
	else
		self.buyCubicle.button.buttonColor = "gray"
	end

	if self.cubicle.purchased then
		self.cubicle:update(dt)
		self.upgradeWorker:update(dt)
		if self.upgradeWorker.button.clickable:isHovering() and money >= self.upgradeWorker.cost then
			self.upgradeWorker.button.buttonColor = "green"
		elseif self.upgradeWorker.button.clickable:isHovering() and money < self.upgradeWorker.cost then
			self.upgradeWorker.button.buttonColor = "red"
		else
			self.upgradeWorker.button.buttonColor = "gray"
		end
	end
end

function Cell:render()
	setColor(self.color)
	
	self.cubicle:render()
	if self.cubicle.purchased then
		self.upgradeWorker:render()
	end

	self.buyCubicle:render()
end

function Cell:getData()
	return {self.cubicle.purchased, self.cubicle.worker.timeEmployed, self.cubicle.price, self.cubicle.spriteIndex, self.cubicle.worker.upgradeLevel}
end


function Cell:newUpgradeWorker()
	self.upgradeWorker = UpgradeMenu ({--creates the option to upgrade a worker when a cell is clicked
		x = self.clickable.x,
		y = self.clickable.y,
		width = self.clickable.width,
		height = self.clickable.height,
		type = "Worker",
		cost = (DEFAULT_UPGRADE_COST * (math.pow(1.5, self.floorNumber - 1)))*(math.pow(2, self.cubicle.worker.upgradeLevel)),
		buttonText = "Buy",
		onClick = function() 
			if self.upgradeWorker:purchase() then
				local playState = stateMachine.current:getPlayState()
			    stateMachine:change("flappy", {playState = playState, workerLevel = self.cubicle.worker.upgradeLevel})
				self.cubicle.worker:upgrade()
				print("Upgraded Worker")
				self:newUpgradeWorker()
				
			end
		end,
		timer = true
	}, floorNumber)
end


