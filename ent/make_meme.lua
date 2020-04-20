
local MakeMeme = Entity:extend()
MakeMeme.name = "make_meme"

local lg = love.graphics

function MakeMeme:start()
	self.id = 0
	for _,ent in ipairs(world:getLayer("main").items) do
		if ent.id == 1 then
			ent.onClick = function(btn)
				gMeme = gMemeMachine()
				collectgarbage()
			end
		elseif ent.id == 2 then
			ent.onClick = function(btn)
				love.mouse.setVisible(true)
				world:loadSTAIN("bedroom")
			end
		end
	end
end

function MakeMeme:draw()
	lg.push()
	lg.scale(0.25)
	lg.draw(gMeme, 148, 80)
	lg.pop()
end

return MakeMeme
