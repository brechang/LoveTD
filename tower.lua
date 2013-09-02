Class = require 'hump.class' 

Tower = Class{}

function Tower:init(health, attack, radius)
	self.health = health
	self.attack = attack
	self.radius = radius
end
