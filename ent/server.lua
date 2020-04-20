
local Server = Entity:extend()
Server.name = "server"

local lg = love.graphics

local pfp = {
	[0] = lg.newImage("img/boi/boi_icon.png"),
	lg.newImage("img/obj/icon1.png"),
	lg.newImage("img/obj/icon2.png"),
	lg.newImage("img/obj/icon3.png"),
}

local user = {}
do -- load users
	local i = 1
	local name = "discord/usr1.txt"
	while love.filesystem.getInfo(name) do
		user[i] = {}
		for line in love.filesystem.lines(name) do
			table.insert(user[i], line)
		end
		i = i + 1
		name = ("discord/usr%i.txt"):format(i)
	end
end

user[0] = {
	"nice meme",
	"lmao",
	"i agree",
	"high quality meme right there",
	"congrats you kept your meme alive",
	"this is the end",
	"why are you still here",
}

local niceMsg = {
	"hey guys check out my meme :)",
	"at everyone",
	"look at this cool meme",
	"i love this meme",
	"haha look",
}

local posters = {}
local function initPosters(time)
	local used = {}
	local numUsers = #user
	for i=1,3 do
		local poster = {}
		poster.pfp = i
		poster.user = love.math.random(numUsers)
		while used[poster.user] do
			poster.user = poster.user % numUsers + 1
		end
		used[poster.user] = true
		poster.nextIndex = 1
		poster.nextTime = time + love.math.random() * 2
		posters[i] = poster
	end
end

function Server:start()
	self.rect = Rect(0,0, 188,110, self)
	self.msg = {}
	local time = love.timer.getTime()
	initPosters(time)
	self.startTime = time
	self.wait = 1

	for _,ent in ipairs(world:getLayer("main"):withName("button")) do
		if ent.id == 1 then -- @everyone
			if gHour == 0 then
				ent.visible = false
				ent.update = function() end
			elseif gHour == 5 then
				ent.onClick = function ()
					table.insert(self.msg, {-1, 0, 2})
					gHour = 6
					CutScript(function(when)
						when(1)
						table.insert(self.msg, {1, 0, 1})

						when(2)
						table.insert(self.msg, {-1, 1, 3})
						when(2.8)
						table.insert(self.msg, {2, 0, 2})

						when(3.5)
						table.insert(self.msg, {-1, 2, 4})
						when(4)
						table.insert(self.msg, {3, 0, 3})

						when(5)
						table.insert(self.msg, {-1, 3, 5})
						when(6)
						table.insert(self.msg, {1, 0, 4})

						when(9)
						table.insert(self.msg, {0, 0, 5})
						when(9.5)
						table.insert(self.msg, {0, 0, 6})

						when(100)
						table.insert(self.msg, {0,0,7})
					end)
				end
			end
		elseif ent.id == 2 then -- post
			ent.onClick = function()
				if gHour == 0 then
					table.insert(self.msg, {-1, 0, 1})
					self.wait = 0.2
					for k,poster in ipairs(posters) do
						poster.nextTime = love.timer.getTime() + 0.2 * k
					end
					gHour = 1
					CutScript(function(when)
						when(4)
						love.mouse.setVisible(true)
						world:loadSTAIN("bedroom")
					end)
				end
			end
		end
	end
end

function Server:update()
	if gHour == 6 then return end
	local time = love.timer.getTime()
	for i=1,3 do
		local poster = posters[i]
		if time >= poster.nextTime then
			table.insert(self.msg, {poster.pfp, poster.user, poster.nextIndex})
			poster.nextIndex = poster.nextIndex % #user[poster.user] + 1
			poster.nextTime = time + love.math.random() * self.wait*5 + self.wait
		end
	end

	if #self.msg > 200 then
		self.msg = {} -- prevent list from becomming MASSIVE
	end
end

function Server:postUpdate() -- coppied from boi
	local ww, wh = love.graphics.getDimensions()
	camera.zoom = wh / 140
	camera.y = 70
	camera.x = 124
	love.window.setTitle(love.timer.getFPS())
end

function Server:draw()
	local z = camera.zoom
	lg.push()
	lg.setScissor(self.x*z, self.y*z, self.rect.w*z, self.rect.h*z)
	lg.translate(self.x, self.y + 5)
	lg.scale(0.5)
	local dx = 10
	local dy = 180
	for i=#self.msg, 1, -1 do
		local msg = self.msg[i]
		if msg[1] == -1 then
			lg.draw(pfp[msg[2]], dx, dy-90)
			if msg[3] == 2 then
				lg.setColor(1,1,0)
			end
			font:print(niceMsg[msg[3]], dx+15, dy-87)
			lg.setColor(1,1,1)
			lg.draw(gMeme, dx, dy-60, 0, 0.2)
			dy = dy - 120
		else
			lg.draw(pfp[msg[1]], dx, dy)
			font:print(user[msg[2]][msg[3]], dx+15, dy+3)
			dy = dy - 30
		end
		if dy < self.y-60 then break end
	end
	lg.setScissor()
	lg.pop()
end

return Server
