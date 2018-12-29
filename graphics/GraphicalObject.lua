soul.graphics.GraphicalObject = createClass()
local GraphicalObject = soul.graphics.GraphicalObject

GraphicalObject.draw = function(self) end

GraphicalObject.deactivate = function(self)
	soul.graphics.objects[self] = nil
end

GraphicalObject.activate = function(self)
	soul.graphics.objects[self] = self
end

GraphicalObject.switchColor = function(self, state)
	if state and self.color then
		self.oldColor = {love.graphics.getColor()}
		love.graphics.setColor(self.color)
	elseif not state and self.oldColor then
		love.graphics.setColor(self.oldColor)
		self.oldColor = nil
	end
end

GraphicalObject.switchFont = function(self, state)
	if state and self.font then
		self.oldFont = love.graphics.getFont()
		love.graphics.setFont(self.font)
	elseif not state and self.oldFont then
		love.graphics.setFont(self.oldFont)
		self.oldFont = nil
	end
end

GraphicalObject.switchLineStyle = function(self, state)
	if state and self.lineStyle then
		self.oldLineStyle = love.graphics.getLineStyle()
		love.graphics.setLineStyle(self.lineStyle)
	elseif not state and self.oldLineStyle then
		love.graphics.setLineStyle(self.oldLineStyle)
		self.oldLineStyle = nil
	end
end

GraphicalObject.switchLineWidth = function(self, state)
	love.graphics.setLineWidth(state and self.lineWidth or 1)
end