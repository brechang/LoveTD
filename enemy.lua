Class = require 'hump.class'

Enemy = Class{}

function Enemy:init(health, attack, speed, pos, dir)
	self.health = health
	self.attack = attack
	self.speed = speed
	self.pos = pos
	self.dir = dir
end

function Enemy:getHealth()
	return self.health
end

function Enemy:getAttack()
	return self.attack
end

function Enemy:getSpeed()
	return self.speed
end

function Enemy:setHealth(hp)
	self.health = hp
end

function Enemy:getDir()
	return self.dir
end

function Enemy:setDir(dir)
	self.dir = dir
end

return Enemy
