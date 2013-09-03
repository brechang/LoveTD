local lvl1 = {}
local GS = require "hump.gamestate"
local UT = require "util"
local HC = require "hardoncollider"
local pos, speed, tileSize, width, height = UT.pos, UT.speed, UT.tileSize,
UT.width, UT.height

local grid = UT.genGrid()

local function on_collide(dt, shape1, shape2)
	if shape1 == stop then
        print(shape2.number)
        Collider.remove(shape2)
        enemies[shape2.number] = nil
	elseif shape2 == stop then
        print(shape1.number)
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

local function dist(x1, y1, x2, y2)
	return math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
end

function lvl1:update(dt)
	for _, t in pairs(towers) do
		for _, v in pairs(enemies) do
			local x1, y1 = v:center()
			local x2, y2 = t:getPos()[1], t:getPos()[2]
			if dist(x1, y1, x2, y2) <= t:getRadius() then
				v.hp = v.hp - 1
				if v.hp == 0 then
					Collider.remove(v)
					enemies[v.number] = nil
				end
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
	timer = 0
	turn = Collider:addPoint(375, 275)
	stop = Collider:addRectangle(350, 550, 30, 30)
end

function lvl1:draw()
    --love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
	UT.fillGrid(grid, tileSize)
	for k,v in pairs(enemies) do
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
