local lvl1 = {}
local GS = require "hump.gamestate"
local UT = require "util"
local HC = require "hardoncollider"
local pos, speed, tileSize, width, height = UT.pos, UT.speed, UT.tileSize,
UT.width, UT.height

local grid = UT.genGrid()

local function on_collide(dt, shape1, shape2)
	if shape1 == stop then
        Collider.remove(shape2)
        enemies[shape2.number] = nil
	elseif shape2 == stop then
        Collider.remove(shape1)
        enemies[shape1.number] = nil
	end
	for k, v in pairs(enemies) do
		if shape1 == v or shape2 == v then
			v.velocity = {x = 0, y = 50}
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

local function genProjectile(x, y)
    projectile = Collider:addCircle(x, y, 20)
    projectile.velocity = {x = 0, y = 0}
    projectile.number = #projectiles + 1
    projectiles[projectile.number] = projectile

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
			local x2, y2 = 50*t:getPos()[1]+25, 50*t:getPos()[2]+25
			if dist(x1, y1, x2, y2) <= t:getRadius() then
                p = genProjectile(x2, y2)
                projectileX, projectileY = p:center()
                p:move((x1 - projectileX) * dt, (y1 - projectileY)* dt)
                    
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
	for k, v in pairs(enemies) do
		v:move(v.velocity.x * dt, v.velocity.y * dt)
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

	turn:draw("fill")
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
