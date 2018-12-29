soul.graphics.Circle = createClass(soul.graphics.GraphicalObject)
local Circle = soul.graphics.Circle

Circle.draw = function(self)
	self:switchColor(true)
	self:switchLineWidth(true)
	self:switchLineStyle(true)
	
	love.graphics.circle(
		self.mode,
		self.cs:X(self.x, true),
		self.cs:Y(self.y, true),
		self.cs:X(self.r)
	)
	
	self:switchColor()
	self:switchLineWidth()
	self:switchLineStyle()
end