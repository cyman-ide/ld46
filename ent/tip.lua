
local Tip = Entity:extend()
Tip.name = "tip"

local lg = love.graphics

local flux = flux
local layerBoi

function Tip:start()
	self.text = self.text or "bottom text"
	local w = (1 + #self.text) * 7
	self.ox = w/2
	self.rect = Rect(-10,-10, 20,20, self)
	self.opacity = 0
	self.active = false
	self.visible = false
	layerBoi = world:getLayer("player")
	self:makeImg(w)
end

function Tip:makeImg(w)
	local img = lg.newCanvas(w+2, 10)
	lg.setCanvas(img)
	lg.push()
	lg.origin()
	lg.translate(1,1)
	lg.setColor(0,0,0)
		font:print(self.text, -1, 0)
		font:print(self.text, 1, 0)
		font:print(self.text, 0, -1)
		font:print(self.text, 0, 1)
	lg.setColor(1,1,1)
		font:print(self.text, 0,0)
	lg.pop()
	lg.setCanvas()
	self.img = img
end

function Tip:activate()
	self.visible = true
	flux.to(self, 0.5, {oy = 5, opacity = 1})
end

function Tip:deactivate()
	flux.to(self, 0.5, {oy = 0, opacity = 0})
		:oncomplete(function() self.visible = false end)
	self.active = false
end

function Tip:draw(dx, dy)
	dx = (dx or 0) + self.x + self.parent.x
	dy = (dy or 0) + self.y - 5 + self.parent.y
	lg.setColor(1,1,1, self.opacity)
	lg.draw(self.img, dx, dy, 0, 1,1, self.ox, self.oy)
	lg.setColor(1,1,1)
end

return Tip
