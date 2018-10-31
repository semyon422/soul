soul.SoulObject = createClass()
local SoulObject = soul.SoulObject

SoulObject.construct = function(self)
	self.observable = self.observable or Observable:new()
	self.sendEvent = function(self, event)
		self.observable:sendEvent(event)
	end
	
	self.observer = self.observer or Observer:new()
	self.observer.receiveEvent = function(_, event)
		self:receiveEvent(event)
	end
end

SoulObject.loaded = false
SoulObject.focus = "*"

SoulObject.load = function(self) end

SoulObject.unload = function(self) end

SoulObject.reload = function(self)
	if self.loaded then
		self:unload()
		self:load()
	end
end

SoulObject.sendEvent = function(self, event) end
SoulObject.receiveEvent = function(self, event) end

SoulObject.deactivate = function(self)
	if self.loaded then
		soul.removeObserver(self.observer)
		
		self:unload()
		self.loaded = false
	end
	
	return self
end

SoulObject.activate = function(self)
	if not self.loaded then
		soul.addObserver(self.observer)
		
		self:load()
		self.loaded = true
	end
	
	return self
end