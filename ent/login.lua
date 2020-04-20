
local Login = Entity:extend()
Login.name = "login"

local lg = love.graphics

local sndWrong = love.audio.newSource("sfx/wrong.wav", "static")
local sndCorrect = love.audio.newSource("sfx/correct.wav", "static")

local numFiles = 0
while love.filesystem.getInfo("discord/pwd"..(numFiles+1)..".txt") do
	numFiles = numFiles + 1
end

local rects = {
	Rect(30,80, 90,26),
	Rect(30,110, 90,26),
	Rect(130,80, 90,26),
	Rect(130,110, 90,26),
}

local lastNum = 0
local function getNewPassword()
	local newNum = love.math.random(numFiles)
	if lastNum == newNum then
		newNum = newNum % numFiles + 1
	end
	lastNum = newNum
	local lines = {}
	for line in love.filesystem.lines("discord/pwd"..newNum..".txt") do
		table.insert(lines, line)
	end
	local result = {}
	result[0] = "hint: " .. lines[1]
	local correctAns = lines[2]
	for i=1,4 do
		local index = love.math.random(1,5-i) + 1
		local raw = lines[index]
		result[i] = {
			text = raw:gsub("%^", "\n"),
			rect = rects[i],
			correct = raw == correctAns,
		}
		table.remove(lines, index)
	end
	return result
end

local mouse
function Login:start()
	self.items = getNewPassword()	
	self.guess = ""
	self.canInput = true
	self.curColor = 1
	mouse = world:getLayer("mouse").items[1]
end

function Login:update()
end

local colors = {
	{0,0,0},
	{200,0,0},
	{0,200,0},
}

function Login:draw()
	lg.setColor(0,0,0)
	font:print("select the correct password", 24,3)
	font:print(self.items[0], 40, 38)

	lg.setColor(colors[self.curColor])
	font:print(self.guess, 40, 56)

	for i=1,4 do
		local item = self.items[i]
		if item.rect:collidepoint(mouse.x, mouse.y) then
			lg.setColor(1,1,1)
			if self.canInput and input.click.pressed then
				self.canInput = false
				self.guess = item.text:gsub("%\n", " ")
				self.correct = item.correct
				CutScript(function(when, self)
					when(1)
					if self.correct then
						sndCorrect:play()
						self.curColor = 3

						when(2)
						entityCreate("main", {
							name = "admin_maker"
						})
						self.terminate = true
					else
						sndWrong:play()
						self.curColor = 2

						when(2)
						self.items = getNewPassword()
						self.guess = ""
						self.canInput = true
						self.curColor = 1
					end
				end, self)
			end
		else
			lg.setColor(0.8, 0.8, 0.8)
		end
		lg.rectangle("fill", item.rect:get())
		lg.setColor(0,0,0)
		font:print(item.text, item.rect.x-5, item.rect.y+4)
	end
	lg.setColor(1,1,1)

	lg.push()
		lg.scale(0.5)
		font:print("secure boot", 400,271)
	lg.pop()
end

return Login
