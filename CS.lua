soul.CS = {}
local CS = soul.CS

CS.new = function(self, cs, bx, by, rx, ry, binding, baseOne)
	local cs = cs or {}
	
	cs.bx, cs.by, cs.rx, cs.ry, cs.binding, cs.baseOne = bx, by, rx, ry, binding, baseOne
	
	setmetatable(cs, self)
	self.__index = self
	
	cs:update()
	
	return cs
end

CS.update = function(self)
	local screen = self:getScreen()
	if self.screenX ~= screen.x or self.screenY ~= screen.y or self.screenWidth ~= screen.w or self.screenHeight ~= screen.h then
		self.screenX = screen.x
		self.screenY = screen.y
		self.screenWidth = screen.w
		self.screenHeight = screen.h
		
		if self.binding == "h" then
			self.one = self.screenHeight
			self.onex = self.one
			self.oney = self.one
		elseif self.binding == "h" then
			self.one = self.screenHeight
		elseif self.binding == "min" then
			self.one = math.min(self.screenHeight, self.screenWidth)
			self.onex = self.one
			self.oney = self.one
		elseif self.binding == "max" then
			self.one = math.max(self.screenHeight, self.screenWidth)
			self.onex = self.one
			self.oney = self.one
		elseif self.binding == "all" then
			self.one = math.min(self.screenHeight, self.screenWidth)
			self.onex = self.screenWidth
			self.oney = self.screenHeight
		else
			self.one = 1
			self.onex = self.one
			self.oney = self.one
		end
		
		if not self.baseOne then
			self.baseOne = self.one
		end
	end
end

CS.getScreen = function(self)
	return {
		x = 0, y = 0,
		w = love.graphics.getWidth(), h = love.graphics.getHeight()
	}
end

CS.aX = function(self, x)
	if not x then return end
	self:update()
	return map(x, 0, 1, self.screenX, self.screenX + self.screenWidth)
end

CS.aY = function(self, y)
	if not y then return end
	self:update()
	return map(y, 0, 1, self.screenY, self.screenY + self.screenHeight)
end

CS.x = function(self, X, g)
	if not X then return end
	self:update()
	
	if g then
		return (X - self:aX(self.bx)) / self.onex - self.rx
	else
		return X / self.onex
	end
end

CS.y = function(self, Y, g)
	if not Y then return end
	self:update()
	
	if g then
		return (Y - self:aY(self.by)) / self.oney - self.ry
	else
		return Y / self.oney
	end
end

CS.X = function(self, x, g)
	if not x then return end
	self:update()
	
	if g then
		return self:aX(self.bx) + (x - self.rx) * self.onex
	else
		return x * self.onex
	end
end

CS.Y = function(self, y, g)
	if not y then return end
	self:update()
	
	if g then
		return self:aY(self.by) + (y - self.ry) * self.oney
	else
		return y * self.oney
	end
end