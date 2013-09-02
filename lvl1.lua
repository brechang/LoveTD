local lvl1 = {}
local GS = require "hump.gamestate"
local UT = require "util"
local HC = require "hardoncollider"
local EN = require "enemy"
local pos, speed, tileSize, width, height = UT.pos, UT.speed, UT.tileSize,
UT.width, UT.height

local start = {0, 275, 1}
local stop = {375, 575}
local turns = {{375, 275, 4}}
local e1 = EN(5, 5, 10, {start[1], start[2]}, 1)
local enemies = {}

local grid = UT.genGrid()

local function on_collide(dt, shape1, shape2)
	enemy1.velocity = {x = 0, y = 50}
end

function lvl1:update(dt)
    enemy1:move(enemy1.velocity.x * dt, enemy1.velocity.y * dt)
	Collider:update(dt)
end

function lvl1:init()
    --nothing
    love.graphics.setColor(255,0,0)
	Collider = HC(100, on_collide)
	enemy1 = Collider:addRectangle(0, 270, 10, 10)
	enemy1.velocity = {x = 50, y = 0}

	turn = Collider:addPoint(375, 275)

end

function lvl1:draw()
    --love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
	UT.fillGrid(grid, tileSize)
	enemy1:draw("fill")
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
