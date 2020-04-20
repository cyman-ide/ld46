
local Useable = require "ent.useable"
local D = Useable:extend()
D.name = "door"

local IMG = ImageArray("img/obj/door.png", 22,43, 0)

function D:start()
	self:addSprite(Sprite(IMG,'1'))
	self:addSprite(Sprite(IMG,'2'))
	self:switchSprite(1)
	if gHour == 2 and world.name == "out3" then
		self.gotPlayer = function(self, boi)
			boi.seized = true
			boi.yv = -50
			boi.xv = 50
			boi:switchSprite("fall")
			local sndShatter = love.audio.newSource("sfx/shatter.ogg", "static")
			
			CutScript(function(when, self)
				when(0.2)
				self:switchSprite(2)
				sndShatter:play()
				entityCreate("tips", {
					name = "shake",
					intensity = 5,
					duration = 0.2,
				})
				self:switchLayer("player")

				when(0.4)
				gHour = 3
				world:loadSTAIN("modhouse")
			end, self)
		end
	elseif gHour >= 3 then
		if world.name == "modhouse" then
			self:switchSprite(2)
			self:makeTip { text = "go outside" }
			self.use = function(self)
				world:loadSTAIN("out3")
			end
		elseif world.name == "out3" then
			self:switchSprite(2)
			self:makeTip { text = "go inside" }
			self.use = function(self)
				world:loadSTAIN("modhouse")
			end
		end
	end

	if world.name == "out1" then
		self:makeTip { text = "locked", x = 20 }
		self.unlock = function(self)
			self:makeTip { text = "go inside", x = 20 }
			self.use = function(self)
				world:loadSTAIN("bedroom")
			end
			if gHour < 5 then gHour = 5 end
		end
		if gHour >= 5 then self:unlock() end
	elseif world.name == "bedroom" then
		if gHour > 2 then
			self.use = function(self)
				world:loadSTAIN("out1")
			end
			self:makeTip { text = "go outside" }
		end
	end

	self.rect = Rect(0,0, IMG.w, IMG.h, self)
end

function D:unlock()
end

return D
