FlappyState = Class{__includes = BaseState}

function FlappyState:init()
	self.pipes = {}
	self.maxPipes = nil
	self.bird = Bird()

end

function FlappyState:enter(params)
	if params.playState ~= nil then
		self.playState = params.playState
		print("Saved play state")
	end
	if params.workerLevel ~= nil then
		self.maxPipes = (params.workerLevel + 1) * 3
	end

end

function FlappyState:update(dt)
	if #self.pipes == 0 or self.pipes[#self.pipes].x <= VIRTUAL_WIDTH - 200 and #self.pipes < self.maxPipes then
		self.pipes[#self.pipes + 1] = Pipe()
	end
	for i in pairs(self.pipes) do
		self.pipes[i]:update(dt)
	end
	self.bird:update(dt)
	if self.bird.reachedGoal and #self.pipes > 0 then
		self.playState:saveFloor()
		stateMachine.current = self.playState
	end
	if self:touching() then
		stateMachine:change('flappy', {playState = self.playState, workerLevel = self.maxPipes/3 - 1})
	end
end

function FlappyState:render()
	love.graphics.clear(40, 45, 52, 255)
	for i in pairs(self.pipes) do
		self.pipes[i]:render()
	end
	self.bird:render()
end

function FlappyState:touching()
	for i in pairs(self.pipes) do
		if (self.bird.x > self.pipes[i].x and self.bird.x < self.pipes[i].x + self.pipes[i].width) and 
		  ((self.bird.y > self.pipes[i].y and self.bird.y < self.pipes[i].gapY) or
		  (self.bird.y > self.pipes[i].gapY + self.pipes[i].gapLength and self.bird.y < self.pipes[i].height)) then
		  	return true
		end
	end
	return false
end
