Class = require 'hump.class' 

Enemy = Class{}

function Enemy:init(health, attack, speed)
	self.health = health
	self.attack = attack
	self.speed = speed
end
