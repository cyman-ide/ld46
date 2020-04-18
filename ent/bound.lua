
local Bound = Entity:extend()
Bound.name = "bound"

function Bound:start()
	if self.layer then
		self.layer.binding = true
	end
	self.binding = true
	self.rect = Rect(0,0, (self.w or 20), (self.h or 20), self)
end

function Bound:draw()
	love.graphics.setColor(0,1,1)
	love.graphics.rectangle("line", self.rect:get())
	love.graphics.setColor(1,1,1)
end

return Bound
