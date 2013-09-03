local lvl1 = {}
local GS = require "hump.gamestate"
local UT = require "util"
local HC = require "hardoncollider"
local pos, speed, tileSize, width, height = UT.pos, UT.speed, UT.tileSize,
UT.width, UT.height

local grid = UT.genGrid()

local function intable(tabl, obj)
	for _, v in pairs(tabl) do
		if obj == v then
			return true
		end
	end
	return false
end

local function on_collide(dt, shape1, shape2)
--~ 	if shape1 == stop then
--~         Collider.remove(shape2)
--~         enemies[shape2.number] = nil
--~ 	elseif shape2 == stop then
--~         Collider.remove(shape1)
--~         enemies[shape1.number] = nil
--~ 	end
--~ 	for k, v in pairs(enemies) do
--~ 		if shape1 == v or shape2 == v then
--~ 			v.velocity = {x = 0, y = 50}
--~ 		end
--~ 	end
	if intable(enemies, shape1) then
		if shape2 == stop then
			Collider.remove(shape1)
			enemies[shape1.number] = nil
		elseif shape2 == turn then
			shape1.velocity = {x = 0, y = 50}
		else
			shape1.hp = shape1.hp - 1
			if shape1.hp <= 0 then
				Collider.remove(shape1)
				enemies[shape1.number] = nil
			end
			Collider.remove(shape2)
			projectiles[shape2.number] = nil
		end
	elseif intable(enemies, shape2) then
		if shape1 == stop then
			Collider.remove(shape2)
			enemies[shape2.number] = nil
		elseif shape1 == turn then
			shape2.velocity = {x = 0, y = 50}
		else
			shape2.hp = shape2.hp - 1
			if shape2.hp <= 0 then
				Collider.remove(shape2)
				enemies[shape2.number] = nil
			end
			Collider.remove(shape1)
			projectiles[shape1.number] = nil
		end
	elseif intable(projectiles, shape1) then
		if shape2 == stop then
			Collider.remove(shape1)
			projectiles[shape1.number] = nil
		end
	elseif intable(projectiles, shape2) then
		if shape1 == stop then
			Collider.remove(shape2)
			projectiles[shape2.number] = nil
		end
	end
end

local function add_enemy()
	enemy = Collider:addRectangle(0, 270, 10, 10)
	enemy.velocity = {x = 50, y = 0}
    enemy.number = #enemies + 1
	enemy.hp = 2
	Collider:addToGroup("enemies", enemy)
	enemies[enemy.number] = enemy
end

local function genProjectile(x1, y1, enemy)
    projectile = Collider:addCircle(x1, y1, 5)
    projectile.number = #projectiles + 1
    projectiles[projectile.number] = projectile
	projectile.maxSpeed = 200
	x2, y2 = enemy:center()
	projectile.velocity = {x = x2 - x1, y = y2 - y1}
	projectile.en = enemy
	Collider:addToGroup("projectiles", projectile)
    return projectile
end


local function dist(x1, y1, x2, y2)
	return math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
end

function lvl1:update(dt)
	for _, t in pairs(towers) do
		for _, v in pairs(enemies) do
            --position of the enemy
			local x1, y1 = v:center()

            --position of the tower
			local x2, y2 = 50*t:getPos()[1]-25, 50*t:getPos()[2]-25
			if dist(x1, y1, x2, y2) <= t:getRadius() and t:getRate() == 0 then
                p = genProjectile(x2, y2, v)
				t:setRate(t:getMaxRate())

					--Collider.remove(v)
					--enemies[v.number] = nil
			end
		end
	end

	if timer <= dt then
		add_enemy()
		timer = 2
	else
		timer = timer - dt
	end

	for _, v in pairs(enemies) do
		v:move(v.velocity.x * dt, v.velocity.y * dt)
	end

	for _, t in pairs(towers) do
		if t:getRate() <= dt then
			t:setRate(0)
		else
			t:setRate(t:getRate() - dt)
		end
	end

	-- COME BACK TO DIS
	for _, p in pairs(projectiles) do
		x2, y2 = p.en:center()
		x1, y1 = p:center()
		p.velocity = {x = x2 - x1, y = y2 - y1}
		local len = math.sqrt(p.velocity.x^2 + p.velocity.y^2)
		p.velocity.x = p.velocity.x / len * p.maxSpeed
		p.velocity.y = p.velocity.y / len * p.maxSpeed
		p:move(p.velocity.x * dt, p.velocity.y * dt)
	end

	Collider:update(dt)
end

function lvl1:init()
    love.graphics.setColor(255,0,0)
	Collider = HC(100, on_collide)
	enemies = {}
	towers = {}
    projectiles = {}
	timer = 0
	turn = Collider:addPoint(375, 275)
	stop = Collider:addRectangle(350, 550, 30, 30)
end

function lvl1:draw()
    --love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
	UT.fillGrid(grid, tileSize)
	for k, v in pairs(enemies) do
		v:draw("fill")
	end

    for k, v in pairs(projectiles) do
        v:draw("fill")
    end

	stop:draw("fill")
end

function lvl1:mousepressed(x, y, button)
    if button == 'l' then
        gx, gy = UT.locateGridPos(x, y, tileSize)
        grid[gx][gy] = UT.newTower(gx, gy)
		towers[#towers + 1] = grid[gx][gy]
    end
end

function lvl1:leave()
    --nothing yet
end

return lvl1
