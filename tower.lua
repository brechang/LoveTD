Class = require 'hump.class' 

Tower = Class{}

function Tower:init(health, attack)
	self.health = health
	self.attack = attack
end
