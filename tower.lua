Class = require 'hump.class'

Tower = Class{}

function Tower:init(maxRate, attack, radius, pos)
	self.maxRate = maxRate
	self.attack = attack
	self.radius = radius
    self.pos    = pos
	self.rate = 0
end

function Tower:getRate()
	return self.rate
end

function Tower:setRate(r)
	self.rate = r
end

function Tower:getMaxRate()
	return self.maxRate
end

function Tower:getAttack()
	return self.attack
end

function Tower:getRadius()
	return self.radius
end

function Tower:getPos()
    return self.pos
end

return Tower
