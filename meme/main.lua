
local meme
local generate

function love.load()
	generate = love.filesystem.load("mememachine.lua")
	meme = generate("")
end

function love.draw()
	love.graphics.draw(meme, 20, 20)
end

function love.keypressed(key)
	if key == "space" then
		meme = generate("")
	end
end
