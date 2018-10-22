soul = {}

require("soul.SoulObject")
require("soul.CS")
require("soul.Thread")
require("soul.Async")
require("soul.graphics")
require("soul.ui")

local callbackNames = {
	"update",
	"textinput",
	"keypressed",
	"keyreleased",
	"mousepressed",
	"mousemoved",
	"mousereleased",
	"wheelmoved",
	"resize",
	"quit"
}

soul.init = function()
	love.run = soul.run
	love.update = soul.update
	love.draw = soul.draw
	
	soul.observable = Observable:new()
	
	for _, name in pairs(callbackNames) do
		love[name] = function(...)
			soul.observable:sendEvent({
				name = "love." .. name,
				data = {...}
			})
		end
	end
end

soul.addObserver = function(observer)
	soul.observable:addObserver(observer)
end

soul.removeObserver = function(observer)
	soul.observable:removeObserver(observer)
end

soul.run = function()
	love.math.setRandomSeed(os.time())
	love.timer.step()

	while true do
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
		
		love.timer.step()
		love.update(love.timer.getDelta())
		
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			love.draw()
			love.graphics.present()
		end
	end
end

soul.draw = function()
	local objects = {}
	for _, object in pairs(soul.graphics.objects) do
		table.insert(objects, object)
	end
	table.sort(objects, function(a, b)
		return a.layer < b.layer
	end)
	
	for _, object in ipairs(objects) do
		object:draw()
	end
end

soul.focus = {
	["*"] = true
}

soul.cloneFocusTable = function()
	local focus = {}
	for key, value in pairs(soul.focus) do
		focus[key] = value
	end
	return focus
end