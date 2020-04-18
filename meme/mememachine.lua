
local args = {...}
local path = args[1] or "meme/"

local lg = love.graphics

local lines = {}
local i = 0
for line in love.filesystem.lines(path .. "text.txt") do
	i = i + 1
	lines[i] = line
end
local topText = lines[love.math.random(i)]
local bottomText = lines[love.math.random(i)]

local numImages = 0
while love.filesystem.getInfo( (numImages+1)..".png" ) do
	numImages = numImages + 1
end
local image = lg.newImage(path .. love.math.random(numImages) .. ".png")

local impact = lg.newFont(path .. "impact.ttf", 60)
local pastFont = lg.getFont()
lg.setFont(impact)

local canvas = lg.newCanvas(400,400)
local fontCan = lg.newCanvas(400,400)
lg.setCanvas(fontCan)
lg.printf(topText, 10,0, 380, "center")
local _, bottomLines = impact:getWrap(bottomText, 380)
local height = impact:getHeight() * #bottomLines
lg.printf(bottomText, 10,400-height, 380, "center")

lg.setCanvas(canvas)
lg.draw(image)
lg.setColor(0,0,0)
lg.draw(fontCan, -2, -2)
lg.draw(fontCan, -2, 2)
lg.draw(fontCan, 2, -2)
lg.draw(fontCan, 2, 2)
lg.setColor(1,1,1)
lg.draw(fontCan)

lg.setCanvas()
lg.setFont(pastFont)

print("meme generated")

return canvas

