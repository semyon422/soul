soul.graphics.PointSet = createClass(soul.graphics.GraphicalObject)
local PointSet = soul.graphics.PointSet

local id = love.image.newImageData(1, 1)
id:setPixel(0, 0, 255, 255, 255, 255)
PointSet.point = love.graphics.newImage(id)

PointSet.construct = function(self, maxsprites)
	self.spriteBatch = love.graphics.newSpriteBatch(self.point, maxsprites)
end

PointSet.draw = function(self)
	self:switchColor(true)
	self:switchLineWidth(true)
	self:switchLineStyle(true)
	
	self.spriteBatch:clear()
	
	local points = {}
	for i = 1, #self.points do
		local point = self.points[i]
		self.spriteBatch:add(
			self.cs:X(point.x, true),
			self.cs:Y(point.y, true),
			0,
			self.cs:X(point.w),
			1
		)
	end
	
	love.graphics.draw(self.spriteBatch, 0, 0)
	
	self:switchColor()
	self:switchLineWidth()
	self:switchLineStyle()
end