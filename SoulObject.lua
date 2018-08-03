soul.SoulObject = createClass()
local SoulObject = soul.SoulObject

SoulObject.loaded = false

SoulObject.load = function(self) end

SoulObject.unload = function(self) end

SoulObject.reload = function(self)
	if self.loaded then
		self:unload()
		self:load()
	end
end

SoulObject.receiveEvent = function(self, event) end

SoulObject.deactivate = function(self)
	if self.loaded then
		soul.removeObserver(self.observer)
		
		self:unload()
		self.loaded = false
	end
end

SoulObject.activate = function(self)
	if not self.loaded then
		local soulObject = self
		self.observer = self.observer or Observer:new()
		self.observer.receiveEvent = function(self, event)
			soulObject:receiveEvent(event)
		end
		soul.addObserver(self.observer)
		
		self:load()
		self.loaded = true
	end
end