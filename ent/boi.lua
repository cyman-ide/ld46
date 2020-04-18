
local Boi = Entity:extend()
Boi.name = "boi"

local SPEED = 50
local GRAV = 600
local JUMP_HEIGHT = 40
local JUMP_VEL = math.sqrt(GRAV * JUMP_HEIGHT * 2)

function Boi:start()
	self.rect = Rect(-5,0, 11,19, self)
	self.bound = true
	self.ya = GRAV

	self.canJump = false
end

function Boi:update()
	if input.quit.down then
		love.event.quit()
	end

	if input.left.down then
		self.xv = -SPEED
	elseif input.right.down then
		self.xv = SPEED
	else
		self.xv = 0
	end

	if input.jump.pressed and self.canJump then
		self.yv = -JUMP_VEL
	end

	self.canJump = false
end

function Boi:onBoundHit(side)
	if side == 2 then
		self.canJump = true
	end
end

function Boi:postUpdate()
	local ww, wh = love.graphics.getDimensions()
	camera.zoom = ww / 140
	camera.y = 70
	camera.x = self.x
end

function Boi:draw()
	love.graphics.rectangle("fill", self.rect:get())
end

return Boi
