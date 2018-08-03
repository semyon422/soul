soul.ui.Button = createClass(soul.ui.UIObject)
local Button = soul.ui.Button

Button.receiveEvent = function(self, event)
	if event.name == "love.mousepressed" then
		local mx, my = event.data[1], event.data[2]
		local x = self.cs:X(self.x, true)
		local y = self.cs:Y(self.y, true)
		local w = self.cs:X(self.w)
		local h = self.cs:Y(self.h)
		if belong(mx, x, x + w, my, y, y + h) then
			self:interact()
		end
	end
end

Button.load = function(self)
	if self.loadBackground then self:loadBackground() end
	if self.loadForeground then self:loadForeground() end
	
	self.loaded = true
end

Button.unload = function(self)
	if self.unloadBackground then self:unloadBackground() end
	if self.unloadForeground then self:unloadForeground() end
	
	self.loaded = false
end