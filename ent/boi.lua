
local Boi = Entity:extend()
Boi.name = "boi"

local SPEED = 50
local GRAV = 240
local JUMP_HEIGHT = 20
local JUMP_VEL = math.sqrt(GRAV * JUMP_HEIGHT * 2)

local IMG = ImageArray("img/boi/boi_run.png", 11,21, 0)
local STEP = 0.1

local abs = math.abs

function Boi:start()
	self.rect = Rect(-5,0, 11,21, self)
	self.bound = true
	self.ya = GRAV

	self:addSprite(Sprite(IMG,'3'), "idle")
	self:addSprite(Sprite(IMG,'1-e',STEP), "run")
	self:addSprite(Sprite(IMG,'1'), "fall")
	self:switchSprite("idle")
	self.ox = 5

	self.canJump = false
end

function Boi:update()
	if input.quit.down then
		love.event.quit()
	end

	if input.left.down then
		self.xv = -SPEED
		self.scalex = -1
	elseif input.right.down then
		self.xv = SPEED
		self.scalex = 1
	else
		self.xv = 0
	end

	if not self.canJump then
		self:switchSprite("fall")
	else
		if abs(self.xv) > 1 then
			self:switchSprite("run")
		else
			self:switchSprite("idle")
		end
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
	camera.zoom = wh / 140
	camera.y = 70
	camera.x = 124
	love.window.setTitle(love.timer.getFPS())
end

return Boi
