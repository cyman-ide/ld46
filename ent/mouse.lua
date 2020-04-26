
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

function Mouse:update()
	if input.quit.pressed then
		love.event.quit()
	end
end

function Mouse:postUpdate()
	local ww, wh = love.graphics.getDimensions()
	camera.zoom = wh / 140
	camera.y = 70
	camera.x = 124
	self.x, self.y = camera:screenToWorld(love.mouse.getPosition())
end

return Mouse
