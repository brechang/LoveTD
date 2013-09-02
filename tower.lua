Class = require 'hump.class' 

Tower = Class{}

function Tower:init(health, attack, radius)
	self.health = health
	self.attack = attack
	self.radius = radius
end

function Tower:getHealth()
	return self.health
end

function Tower:getAttack()
	return self.attack
end

function Tower:getRadius()
	return self.radius
end

function Tower:setHealth(hp)
	self.health = hp
end

return Tower
