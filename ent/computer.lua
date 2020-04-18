
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
	self.online = false
end

function Computer:use()
	if not self.online then
		self.online = true
		self:switchSprite(2)
		local chair = world:getLayer("obj"):withName("office_chair")[1]
		chair:switchSprite(2)
		chair.y = chair.y - 9
		chair.x = chair.x + 1
		local boi = world:getLayer("player").items[1]
		boi.visible = false
		boi.seized = true
		self.entTip:deactivate()
		CutScript(function (when)
			when(1)
			world:loadSTAIN("discord")
		end)
		chair:switchLayer("player")
	end
end

return Computer
