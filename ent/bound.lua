
local Bound = Entity:extend()
Bound.name = "bound"

local Collider = require "cum.collider"

love.graphics.setLineWidth(1)

function Bound:start()
	if self.layer then
		self.layer.binding = true
	end
	self.binding = true
	self.rect = Rect(0,0, (self.w or 20), (self.h or 20), self)
	self.mask = self.mask or 15
end

function Bound:draw()
	if dev.editor.active then
		love.graphics.setColor(0.5,0,1)
		love.graphics.rectangle("line", self.rect:get())
		love.graphics.setColor(1,1,1)
	end
end

function Bound:bind(ent)
	Collider.assertBoundTagged(ent, self.rect, ent.tox, ent.toy, self.mask) 
end

return Bound
