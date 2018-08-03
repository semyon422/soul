soul = {}

require("soul.SoulObject")
require("soul.CS")
require("soul.Thread")
require("soul.graphics")
require("soul.ui")

local callbackNames = {
	"update",
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
	local layersInit = {}
	for _, object in pairs(soul.graphics.objects) do
		if object.layer and not layersInit[object.layer] then
			layersInit[object.layer] = true
		end
	end
	
	local layers = {}
	for layer in pairs(layersInit) do
		table.insert(layers, layer)
	end
	table.sort(layers)
	
	for _, layer in ipairs(layers) do
		for _, object in pairs(soul.graphics.objects) do
			if object.layer == layer then
				object:draw()
			end
		end
	end
end