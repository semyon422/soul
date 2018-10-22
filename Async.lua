soul.Async = createClass(soul.SoulObject)
local Async = soul.Async

Async.load = function(self)
	self.threadName = tostring(self)
	self.thread = love.thread.newThread(
		"threadName = \"" .. self.threadName .. "\"\n" ..
		self:getAsyncFunctionHeader() ..
		self.threadFunction
	)
	self.inputChannel = love.thread.getChannel("input_" .. self.threadName)
	self.outputChannel = love.thread.getChannel("output_" .. self.threadName)
	self.thread:start()
	
	self.result = {}
end

Async.unload = function(self)

end

Async.update = function(self)
	local threadError = self.thread:getError()
	if threadError then
		if self.catch then
			self.catch(threadError)
			self:deactivate()
			return
		else
			error(threadError)
		end
	end
	
	local message = self:receive()
	while message do
		table.insert(self.result, message)
		message = self:receive()
	end
	
	if not self.thread:isRunning() then
		trycatch(
			function() self.try(unpack(self.result)) end,
			function(...) self.catch(...) end
		)
		self:deactivate()
	end
end

Async.receiveEvent = function(self, event)
	if event.name == "love.update" then
		self:update()
	end
end

Async.send = function(self, message)
	self.inputChannel:push(message)
end

Async.receive = function(self)
	return self.outputChannel:pop()
end

Async.getAsyncFunctionHeader = function(self)
	return [[
		inputChannel = love.thread.getChannel("input_]] .. self.threadName .. [[")
		outputChannel = love.thread.getChannel("output_]] .. self.threadName .. [[")
		
		threaded = true
		
		_return = function(...)
			for _, message in ipairs({...}) do
				outputChannel:push(message)
			end
		end
		
		args = {}
		while true do
			local message = inputChannel:pop()
			if message then
				if message == "\0" then break end
				table.insert(args, message)
			end
		end
	]]
end

Async.threadFunction = [[]]

Async.try = function() end
Async.catch = function() end

Async.trycatch = function(self, try, catch)
	self.try = try
	self.catch = catch
end

soul.async = function(threadFunction, ...)
	local async = soul.Async:new()
	async.threadFunction = threadFunction
	async:activate()
	for _, arg in ipairs({...}) do
		async:send(arg)
	end
	async:send("\0")
	
	return async
end