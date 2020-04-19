
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

local musHouse = love.audio.newSource("mus/jig2.xm", "stream")

function cum.onWorldLoad()
	if world.name == "bedroom" or world.name == "modhouse" then
		musHouse:play()
	else
		musHouse:stop()
	end
end

cum.init()

