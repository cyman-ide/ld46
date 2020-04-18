
local Useable = require "ent.useable"
local Computer = Useable:extend()
Computer.name = "computer"

local IMG = ImageArray("img/obj/computer.png", 19,13, 0)

function Computer:start()
	self:addSprite(Sprite(IMG,'1'))
	self:addSprite(Sprite(IMG,'2'))
	self:switchSprite(1)
	self.rect = Rect(0,0, IMG.w, IMG.h, self)
	self:makeTip { text = "go online" }
end

function Computer:use()
	self:switchSprite(2)
end

return Computer
