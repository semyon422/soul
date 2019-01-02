soul.graphics.GraphicalObject = createClass()
local GraphicalObject = soul.graphics.GraphicalObject

GraphicalObject.draw = function(self) end

GraphicalObject.deactivate = function(self)
	soul.graphics.objects[self] = nil
end

GraphicalObject.activate = function(self)
	soul.graphics.objects[self] = self
end

GraphicalObject.switchColor = function(self)
	if self.color then
		love.graphics.setColor(self.color)
	end
end

GraphicalObject.switchFont = function(self)
	if self.font then
		love.graphics.setFont(self.font)
	end
end

GraphicalObject.switchLineStyle = function(self)
	if self.lineStyle then
		love.graphics.setLineStyle(self.lineStyle)
	end
end

GraphicalObject.switchLineWidth = function(self)
	if self.lineWidth then
		love.graphics.setLineWidth(self.lineWidth)
	end
end