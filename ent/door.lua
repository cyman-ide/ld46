
local Useable = require "ent.useable"
local D = Useable:extend()
D.name = "door"

local IMG = ImageArray("img/obj/door.png", 22,43, 0)

function D:start()
	self:addSprite(Sprite(IMG,'1'))
	self:addSprite(Sprite(IMG,'2'))
	self:switchSprite(1)
	self:makeTip { text = "go outside" }
	self.rect = Rect(0,0, IMG.w, IMG.h, self)
end

return D
