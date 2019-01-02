soul.graphics.Polygon = createClass(soul.graphics.GraphicalObject)
local Polygon = soul.graphics.Polygon

Polygon.draw = function(self)
	self:switchColor()
	self:switchLineWidth()
	self:switchLineStyle()
	
	local vertices = {}
	for i, v in ipairs(self.vertices) do
		if i % 2 == 1 then
			points[i] = self.cs:X(v, true)
		else
			points[i] = self.cs:Y(v, true)
		end
	end
	
	return love.graphics.polygon(self.mode, vertices)
end