
local Mouse = Entity:extend()
Mouse.name = "mouse"

local IMG = ImageArray("img/obj/mouse.png")

function Mouse:start()
	if not dev.editor.active then
		love.mouse.setVisible(false)
	end
	self:addSprite(Sprite(IMG,'1'))
	self:switchSprite(1)
	self.rect = Rect(0,0, 3,3, self)
end

function Mouse:postUpdate()
	self.x, self.y = camera:screenToWorld(love.mouse.getPosition())
end

return Mouse
