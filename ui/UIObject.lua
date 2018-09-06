soul.ui.UIObject = createClass(soul.SoulObject)
local UIObject = soul.ui.UIObject

UIObject.action = function(self) end

UIObject.interact = function(self)
	self:action()
end