local lvl1 = {}
local GS = require "hump.gamestate"
local UT = require "util"
local HC = require "hardoncollider"
local pos, speed, tileSize, width, height = UT.pos, UT.speed, UT.tileSize,
UT.width, UT.height

local start = {0, 275, 1}
local stop = {375, 575}
local turns = {{375, 275, 4}}
local enemies = {}

local grid = UT.genGrid()

local function on_collide(dt, shape1, shape2)

end

function lvl1:update(dt)
    pos = pos + speed * dt
end

function lvl1:init()
    --nothing
    love.graphics.setColor(255,0,0)
	Collider = HC(100, on_collide)

end

function lvl1:draw()
    --love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
    UT.fillGrid(grid, tileSize)
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
