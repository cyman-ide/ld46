
require "cum"

cum.input.register {
	left = {"key.left", "key.a"},
	right = {"key.right", "key.d"},
	jump = {"key.space", "key.x", "key.j"},
	use = {"key.c", "key.k"},
	quit = "key.escape",
}

function cum.preStart()
	local layer = world:addLayer("entity", "tips", 64)
	layer.stainless = true
end

gSndSteps = {
	love.audio.newSource("sfx/step1.wav", "static"),
	love.audio.newSource("sfx/step2.wav", "static"),
	love.audio.newSource("sfx/step3.wav", "static"),
	love.audio.newSource("sfx/step4.wav", "static"),
	love.audio.newSource("sfx/step5.wav", "static"),
}

local musHouse = love.audio.newSource("mus/jig2.xm", "stream")
local musOutside = love.audio.newSource("mus/outside.ogg", "stream")
musOutside:setLooping(true)
local musComputer = love.audio.newSource("mus/computer.ogg", "stream")
musComputer:setLooping(true)

local musLast = musOutside
function cum.onWorldLoad()
	local musNew
	if world.name == "bedroom" or world.name == "modhouse" then
		musNew = musHouse
	elseif world.name:sub(0,3) == "out" then
		musNew = musOutside
	elseif world.name == "discord" or world.name == "modcom" then
		musNew = musComputer
	end

	if musNew ~= musLast then
		musLast:stop()
		musNew:play()
		musLast = musNew
	end
end

cum.init()

