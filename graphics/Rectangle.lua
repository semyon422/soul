soul.graphics.Rectangle = createClass(soul.graphics.GraphicalObject)
local Rectangle = soul.graphics.Rectangle

Rectangle.draw = function(self)
	self:switchColor()
	self:switchLineWidth()
	self:switchLineStyle()
	
	return love.graphics.rectangle(
		self.mode,
		self.cs:X(self.x, true),
		self.cs:Y(self.y, true),
		self.cs:X(self.w),
		self.cs:Y(self.h)
	)
end