soul.graphics.Line = createClass(soul.graphics.GraphicalObject)
local Line = soul.graphics.Line

Line.draw = function(self)
	self:switchColor(true)
	self:switchLineWidth(true)
	self:switchLineStyle(true)
	
	local points = {}
	for i, v in ipairs(self.points) do
		if i % 2 == 1 then
			points[i] = self.cs:X(v, true)
		else
			points[i] = self.cs:Y(v, true)
		end
	end
	
	love.graphics.line(points)
	
	self:switchColor()
	self:switchLineWidth()
	self:switchLineStyle()
end