
local Window = Entity:extend()
Window.name = "window"

function Window:start()
	self.img = love.graphics.newImage("img/obj/windowbreak.png")
	self.rect = Rect(0,0, self.img:getWidth(), self.img:getHeight(), self)
	self.visible = false
end

function Window:draw()
	if self.visible then
		love.graphics.draw(self.img, self.x, self.y)
	end
end

return Window
