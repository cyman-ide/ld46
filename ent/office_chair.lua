
local Useable = require "ent.useable"
local Chair = Useable:extend()
Chair.name = "office_chair"

local IMG = ImageArray("img/obj/chair.png", 14,17, 0)
local IMG2 = ImageArray("img/boi/boi_chair.png")
local STEP = 0.2

function Chair:start()
	self:addSprite(Sprite(IMG,'1~e',STEP))
	self:addSprite(Sprite(IMG2,'1',STEP))
	self:switchSprite(1)
	self.rect = Rect(0,0, 10,10, self)
end

return Chair
