
local Button = Entity:extend()
Button.name = "button"

local mouse

function Button:start()
	self.path = self.path or "img/obj/no.png"
	self:editorSetValue("path", self.path)
	mouse = world:getLayer("mouse").items[1]
end

function Button:onClick()
end

function Button:update()
	if mouse then
		if self.rect:collidepoint(mouse.x, mouse.y) then
			if input.click.down then
				self:switchSprite("in")
			else
				self:switchSprite("out")
			end
			if input.click.pressed then
				self:onClick()
			end
		end
	end
end

function Button:editorSetValue(key, val)
	if key == "path" then
		local limg = love.graphics.newImage(val)
		self.img = ImageArray(val, limg:getWidth()/2, limg:getHeight(), 0)
		self:addSprite(Sprite(self.img,'1'), "out")
		self:addSprite(Sprite(self.img,'2'), "in")
		self:switchSprite("out")
		self.rect = Rect(0,0, self.img.w, self.img.h, self)
	end
end

return Button
