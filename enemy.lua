Class = require 'hump.class'

Enemy = Class{}

function Enemy:init(health, attack, speed, pos)
	self.health = health
	self.attack = attack
	self.speed = speed
	self.pos = pos
end

