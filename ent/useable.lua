
local Useable = Entity:extend()
Useable.name = "useable"

local Entity = Entity
local Tip = require "ent.tip"

function Useable:start()
	self:makeTip { text = "error" }
	self.rect = Rect(0,0, 20,20, self)
end

function Useable:makeTip(t)
	t.name = "tip"
	self.entTip = entityCreate("tips", t)
	if not t.x then
		self.entTip.x = self.rect.w/2 - 4
	end
	self.entTip.parent = self
	self.entTip:start()
end

function Useable:update()
	local boi = world:getLayer("player"):checkCollision(self.rect)
	if boi then
		if not self.hasPlayer then
			boi = boi[1]
			self:gotPlayer(boi)
			if self.entTip then
				self.entTip:activate()
			end
			self.hasPlayer = true
		end
	elseif self.hasPlayer then
		self.hasPlayer = false
		self:lostPlayer()
		if self.entTip then
			self.entTip:deactivate()
		end
	end

	if input.use.pressed and self.hasPlayer then
		self:use()
	end
end

function Useable:gotPlayer()
end

function Useable:lostPlayer()
end

function Useable:use()
end

return Useable
