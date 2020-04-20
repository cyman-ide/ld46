
local Useable = require "ent.useable"
local T = Useable:extend()
T.name = "keytrash"

local IMG = ImageArray("img/obj/trashcan2.png", 21,20, 0)

function T:start()
	self:addSprite(Sprite(IMG,'1'))
	self:addSprite(Sprite(IMG,'2'))
	if gHour >= 5 then
		self:switchSprite(2)
	else
		self:switchSprite(1)
	end
	self.rect = Rect(0,0, IMG.w, IMG.h, self)
end

function T:use()
	world:getLayer("obj"):withName("door")[1]:unlock()
	self:switchSprite(2)
	if not self.entTip then
		self:makeTip { text = "you found a key" }
		self.entTip:activate()
	end
end

return T
