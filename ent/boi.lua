
local Boi = Entity:extend()
Boi.name = "boi"

local SPEED = 50
local GRAV = 240
local JUMP_HEIGHT = 20
local JUMP_VEL = math.sqrt(GRAV * JUMP_HEIGHT * 2)

local IMG = ImageArray("img/boi/boi_run.png", 11,21, 0)
local DIVE_IMG = ImageArray("img/boi/boi_dive.png")
local STEP = 0.1

local abs = math.abs

function Boi:start()
	self.rect = Rect(-5,0, 11,21, self)
	self.bound = true
	self.ya = GRAV

	self:addSprite(Sprite(IMG,'3'), "idle")
	self:addSprite(Sprite(IMG,'1-e',STEP), "run")
	self:addSprite(Sprite(IMG,'1'), "fall")
	self:addSprite(Sprite(DIVE_IMG,'1'), "dive")
	self:switchSprite("idle")
	self.ox = 5

	self.camZoom = 1

	self.canJump = false

	if gHour == 1 and world.name == "bedroom" then
		self.x = self.x - 100
		self.camZoom = 4
		self.camFocus = true
		self.seized = true
		CutScript(function (when, self)
			when(1)
			self.camZoom = 1
			self.camFocus = false
			self.yv = -JUMP_VEL/2

			when(1.5)
			self.xv = SPEED*2
			self.scalex = 1
			self:switchSprite("run")
			world:getLayer("obj"):withName("office_chair")[1]:switchSprite("spin")

			when(2)
			self:switchSprite("dive")
			self.yv = -JUMP_VEL
			self.bound = false

			when(2.5)
			world:getLayer("obj"):withName("window")[1].visible = true

			when(3)
			world:loadSTAIN("out1")
		end, self)
	elseif gHour == 1 and world.name == "out1" then
		self.xv = SPEED * 2
		self.seized = true
		self:switchSprite("dive")
		CutScript(function(when, self)
			when(1.5)
			self.seized = false
		end, self)
	end
end

function Boi:update()
	if self.seized then return end
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
	camera.zoom = wh / 140 * self.camZoom
	if self.camFocus then
		camera.x = self.x
		camera.y = self.y
	else
		camera.y = 70
		camera.x = 124
	end
	love.window.setTitle(love.timer.getFPS())
end

return Boi
