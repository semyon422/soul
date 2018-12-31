soul.CS = {}
local CS = soul.CS

CS.new = function(self, cs, bx, by, rx, ry, binding, baseOne)
	local cs = cs or {}
	
	cs.bx, cs.by, cs.rx, cs.ry, cs.binding, cs.baseOne = bx, by, rx, ry, binding, baseOne
	
	setmetatable(cs, self)
	self.__index = self
	
	cs:update()
	soul.cses[cs] = cs
	
	return cs
end

CS.update = function(self)
	self.screenWidth = love.graphics.getWidth()
	self.screenHeight = love.graphics.getHeight()
	
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

CS.aX = function(self, x)
	return map(x, 0, 1, 0, self.screenWidth)
end

CS.aY = function(self, y)
	return map(y, 0, 1, 0, self.screenHeight)
end

CS.x = function(self, X, g)
	if g then
		return (X - self:aX(self.bx)) / self.onex - self.rx
	else
		return X / self.onex
	end
end

CS.y = function(self, Y, g)
	if g then
		return (Y - self:aY(self.by)) / self.oney - self.ry
	else
		return Y / self.oney
	end
end

CS.X = function(self, x, g)
	if g then
		return self:aX(self.bx) + (x - self.rx) * self.onex
	else
		return x * self.onex
	end
end

CS.Y = function(self, y, g)
	if g then
		return self:aY(self.by) + (y - self.ry) * self.oney
	else
		return y * self.oney
	end
end