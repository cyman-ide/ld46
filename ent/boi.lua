
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

local SCREEN_W = 248

local roomLeft = {
	out2 = "out1",
	out3 = "out2",
}

local roomRight = {
	out1 = "out2",
	out2 = "out3",
}

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

	self.stepDistance = 30

	self.camZoom = 1

	self.canJump = false

	if gHour == 1 then
		SPEED = SPEED * 2
		STEP = STEP / 2
	end

	if gHour == 1 and world.name == "bedroom" then
		self.x = self.x - 100
		self.camZoom = 4
		self.camFocus = true
		self.seized = true
		self.sndCrash = love.audio.newSource("sfx/shatter2.ogg", "static")
		CutScript(function (when, self)
			when(1)
			self.camZoom = 1
			self.camFocus = false
			self.yv = -JUMP_VEL/2
			self.stepDistance = 20

			when(1.5)
			self.xv = 200
			self.scalex = 1
			self:switchSprite("run")
			world:getLayer("obj"):withName("office_chair")[1]:switchSprite("spin")

			when(1.75)
			self:switchSprite("dive")
			self.yv = -JUMP_VEL
			self.bound = false
			self.canJump = false -- stop step sounds

			when(2)
			world:getLayer("obj"):withName("window")[1].visible = true
			self.sndCrash:play()
			entityCreate("tips", {
				name = "shake",
				duration = 0.5,
				intesity = 5,
			})

			when(3)
			world:loadSTAIN("out1")
		end, self)
	elseif gHour == 1 and world.name == "out1" then
		gHour = 2
		self.x = -50
		self.y = -150
		self.xv = SPEED/2
		self.seized = true
		self:switchSprite("dive")
		CutScript(function(when, self)
			when(1.5)
			flux.to(self, 1.5, {xv=0})

			when(3)
			self.seized = false
		end, self)
	elseif gFromWorld == "modcom" then
		self.x = 165
		gFromWorld = "modhouse"
	elseif world.name == "bedroom" and gHour > 0 then
		self.x = 67
	elseif gStartFrom then
		if gStartFrom == "left" then
			self.x = 13
		elseif gStartFrom == "right" then
			self.x = SCREEN_W - 13
		end
		gStartFrom = false
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
		if SPEED == 50 then
			self:switchSprite("fall")
		else
			self:switchSprite("dive")
		end
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

	if self.x > SCREEN_W then
		local rmr = roomRight[world.name]
		if rmr then
			world:loadSTAIN(rmr)
			gStartFrom = "left"
		end
	elseif self.x < 0 then
		local rml = roomLeft[world.name]
		if rml then
			world:loadSTAIN(rml)
			gStartFrom = "right"
		end
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

	if self.canJump then
		self.stepDistance = self.stepDistance - abs(self.xv) * dt
		if self.stepDistance < 0 then
			gSndSteps[love.math.random(5)]:play()
			self.stepDistance = 24
		end
	end
end

return Boi
