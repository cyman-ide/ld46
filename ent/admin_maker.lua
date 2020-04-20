
local Mkr = Entity:extend()
Mkr.name = "admin_maker"

local lg = love.graphics

local pfp = lg.newImage("img/boi/boi_icon.png")

local badMsg = {
	"wrong choice",
	"no, bad",
	"you can't do that",
	"stop",
	"very funny",
	"no really",
	"im laughing",
	"very original",
	"death",
}

function Mkr:start()
	self.state = 1
	self.badIndex = 1
	self.ok = entityCreate("main", {
		name = "button",
		x = 40, y = 90,
		path = "img/obj/button.png",
		onClick = function(btn)
			CutScript(function(when)
				when(0.2)
				self.state = 3

				when(2)
				gHour = gHour < 4 and 4 or gHour
				gFromWorld = "modcom"
				love.mouse.setVisible(true)
				world:loadSTAIN("modhouse")
			end)
		end,
	})
	self.no = entityCreate("main", {
		name = "button",
		x = 120, y = 90,
		path = "img/obj/no.png",
		onClick = function(btn)
			CutScript(function(when)
				when(0.2)
				self.state = 2

				when(2)
				self.state = 1
				self.badIndex = self.badIndex % #badMsg + 1
			end)
		end,
	})
end

function Mkr:draw()
	lg.draw(pfp, 15, 53)
	lg.setColor(0,0,0)
	if self.state == 1 then
		lg.setColor(0,0,0)
		font:print("<-give him admin rights?", 35, 56)
	elseif self.state == 2 then
		font:print(badMsg[self.badIndex], 35, 56)
	elseif self.state == 3 then
		font:print("good job", 35, 56)
	end
	lg.setColor(1,1,1)
end

return Mkr
