local lvl1 = {}
local GS = require "hump.gamestate"
local UT = require "util"
local HC = require "hardoncollider"
local pos, speed, tileSize, width, height = UT.pos, UT.speed, UT.tileSize,
UT.width, UT.height

local start = {0, 275, 1}
local stop = {375, 575}
local turns = {{375, 275, 4}}
local e1 = EN(5, 5, 10, {start[1], start[2]}, 1)
local enemies = {}
local towers = {}

local grid = UT.genGrid()

local function on_collide(dt, shape1, shape2)
	for i = 1, #enemies do
		if shape1 == enemies[i] or shape2 == enemies[i] then
			enemies[i].velocity = {x = 0, y = 50}
		end
	end
end

local function add_enemy()
	enemy = Collider:addRectangle(0, 270, 10, 10)
	enemy.velocity = {x = 50, y = 0}
	Collider:addToGroup("enemies", enemy)
	enemies[#enemies + 1] = enemy
end

function lvl1:update(dt)
	if timer <= dt then
		add_enemy()
		timer = 3
	else
		timer = timer - dt
	end
	for i = 1, #enemies do
		enemies[i]:move(enemies[i].velocity.x * dt, enemies[i].velocity.y * dt)
	end

	Collider:update(dt)
end

function lvl1:init()
    love.graphics.setColor(255,0,0)
	Collider = HC(100, on_collide)
	enemies = {}
	timer = 3
	turn = Collider:addPoint(375, 275)
end

function lvl1:draw()
    --love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
	UT.fillGrid(grid, tileSize, towers)
	for i = 1, #enemies do
		enemies[i]:draw("fill")
	end
	turn:draw("fill")
end

function lvl1:mousepressed(x, y, button)
    if button == 'l' then
        gx, gy = UT.locateGridPos(x, y, tileSize)
        grid[gx][gy] = 1 - grid[gx][gy]
    end
end

function lvl1:leave()
    --nothing yet
end

return lvl1
