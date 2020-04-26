
local T = Entity:extend()
T.name = "title"

local lg = love.graphics

function T:start()
	self.lastFont = lg.getFont()
	self.font = lg.newFont("meme/impact.ttf", 32)
end

function T:update()
	if input.use.pressed then
		lg.setFont(self.lastFont)
		world:loadSTAIN("meme")
	end
end

function T:postUpdate()
	camera.x = 124
	camera.y = 70
	local ww, wh = lg.getDimensions()
	camera.zoom = wh / 140
end

function T:draw()
	lg.setFont(self.font)
	lg.printf("Jiggy Bungus", 0,0, 248, "center")

	font:print("created by\ncyman and yecats", 50,40)
	font:print("press k or c to start", 80, 80)
	lg.setFont(self.lastFont)
end

return T
