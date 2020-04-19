
local Useable = require "ent.useable"
local Trashcan = Useable:extend()
Trashcan.name = "trashcan"

local IMG = ImageArray("img/obj/trashcan1.png")

function Trashcan:start()
	self:addSprite(Sprite(IMG, '1'))
	self:switchSprite(1)
end

function Trashcan:gotPlayer()
	self.yv = -100
	self.ya = 480
	CutScript(function(when, self)
		when(5)
		self.terminate = true
	end, self)
end

return Trashcan
