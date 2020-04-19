
local Useable = require "ent.useable"
local Mod = Useable:extend()
Mod.name = "the_mod"

local IMG = ImageArray("img/obj/mod.png", 43,28, 0)
local STEP = 1

function Mod:start()
	self:addSprite(Sprite(IMG,'1-e',STEP))
	self:switchSprite(1)
	self.rect = Rect(2,0, IMG.w-4, IMG.h, self)
end

function Mod:gotPlayer()
	self.yv = -100
	self.ya = 480
	self.rotv = -10
	CutScript(function(when, self)
		when(5)
		self.terminate = true
	end, self)
end

return Mod
