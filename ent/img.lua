
local Img = Entity:extend()
Img.name = "img"

local cache = {}
local DEFAULT = love.graphics.newImage("img/default.png")

function Img:loadImg()
	if self.path then
		if cache[self.path] then
			self.img = cache[self.path]
		else
			if not love.filesystem.getInfo(self.path) then
				dev.log:print("failed: "..self.path.." not found")
				return
			end
			local newImage = love.graphics.newImage(self.path)
			self.img = newImage
			cache[self.path] = newImg
		end
		self.rect = Rect(0,0, self.img:getWidth(), self.img:getHeight(), self)
	end
end

function Img:start()
	self:loadImg()
	if not self.img then
		self.img = DEFAULT
		self.rect = Rect(0,0, self.img:getWidth(), self.img:getHeight(), self)
	end
end

function Img:draw()
	love.graphics.draw(self.img, self.rect:xy())
end

function Img:editorSetValue(key, val)
	if key == "path" then
		self:loadImg()
	end
end

return Img
