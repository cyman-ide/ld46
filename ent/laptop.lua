
local Useable = require "ent.useable"
local L = Useable:extend()
L.name = "laptop"

local IMG = ImageArray("img/obj/laptop.png", 20,9, 0)

function L:start()
	self:addSprite(Sprite(IMG,'1'))
	self:addSprite(Sprite(IMG, '2'))
	self:switchSprite(1)
	self:makeTip { text = "hack" }
	self.rect = Rect(0,0, IMG.w, IMG.h, self)
end

function L:use()
	world:loadSTAIN("modcom")
end

return L
