
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

cum.init()

