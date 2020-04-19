
local Useable = require "ent.useable"
local D = Useable:extend()
D.name = "door"

local IMG = ImageArray("img/obj/door.png", 22,43, 0)

function D:start()
	self:addSprite(Sprite(IMG,'1'))
	self:addSprite(Sprite(IMG,'2'))
	self:switchSprite(1)
	if gHour > 1 and world.name == "bedroom" then
		self:makeTip { text = "go outside" }
	elseif gHour == 2 and world.name == "out3" then
		self.gotPlayer = function(self, boi)
			boi.seized = true
			boi.yv = -50
			boi.xv = 50
			boi:switchSprite("fall")
			
			CutScript(function(when, self)
				when(0.2)
				self:switchSprite(2)
				entityCreate("tips", {
					name = "shake",
					intensity = 1,
					duration = 0.2,
				})
				self:switchLayer("player")

				when(0.4)
				gHour = 3
				world:loadSTAIN("modhouse")
			end, self)
		end
	elseif gHour == 3 then
		self:switchSprite(2)
		if world.name == "modhouse" then
			self:makeTip { text = "go outside" }
			self.use = function(self)
				world:loadSTAIN("out3")
			end
		elseif world.name == "out3" then
			self:makeTip { text = "go inside" }
			self.use = function(self)
				world:loadSTAIN("modhouse")
			end
		end
	end
	self.rect = Rect(0,0, IMG.w, IMG.h, self)
end

return D
