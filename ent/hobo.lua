
local Hobo = Entity:extend()
Hobo.name = "hobo"

local IMG = ImageArray("img/obj/hobo.png", 19,8, 0)
local STEP = 1

function Hobo:start()
	self:addSprite(Sprite(IMG,'1-e',STEP))
	self:switchSprite(1)
	self.rect = Rect(0,0, IMG.w, IMG.h, self)
end

return Hobo
