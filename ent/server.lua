
local Server = Entity:extend()
Server.name = "server"

local min = math.min
local lg = love.graphics

local pfp = {
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
		poster.nextTime = time + love.math.random() * 5 + 1
		posters[i] = poster
	end
end

function Server:start()
	self.rect = Rect(0,0, 188,110, self)
	self.msg = {}
	initPosters(love.timer.getTime())
end

function Server:update()
	local time = love.timer.getTime()
	for i=1,3 do
		local poster = posters[i]
		if time >= poster.nextTime then
			table.insert(self.msg, {poster.pfp, poster.user, poster.nextIndex})
			poster.nextIndex = min(#user[poster.user], poster.nextIndex+1)
			poster.nextTime = time + love.math.random() * 5 + 1
		end
	end
end

function Server:draw()
	lg.push()
	lg.translate(self.x, self.y)
	lg.scale(0.5)
	local dx = 10
	local dy = 180
	for i=#self.msg, 1, -1 do
		local msg = self.msg[i]
		lg.draw(pfp[msg[1]], dx, dy)
		font:print(user[msg[2]][msg[3]], dx+15, dy+3)
		dy = dy - 30
		if dy < self.y-30 then break end
	end
	lg.pop()
end

return Server
