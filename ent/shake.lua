
local Shake = Entity:extend()
Shake.name = "shake"

function Shake:start()
	self.duration = self.duration or 1
	self.intensity = self.intensity or 3
end

function Shake:postUpdate()
	self.duration = self.duration - dt
	if self.duration <= 0 then
		self.terminate = true
		return
	end
	camera.x = camera.x + love.math.random(-self.intensity, self.intensity)
	camera.y = camera.y + love.math.random() * self.intensity * 2 - self.intensity
end

return Shake
