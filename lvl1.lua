local lvl1 = {}
local GS = require "hump.gamestate"

local speed = 5
local pos = 0
local tileSize = 50

local width = 800
local height = 600

--Generates a grid
local function genGrid(width, height)
    local newGrid = {}
    for i = 1, width/tileSize do
        newGrid[i] = {}
        for j = 1, height/tileSize do
            newGrid[i][j] = 0
        end
    end
    return newGrid
end

--Locates the grid coordinate based on mouseX, mouseY, and tileSize
local function locateGridPos(mouseX, mouseY, tileSize)
    local gridX, gridY = math.ceil(mouseX / tileSize), math.ceil(mouseY/tileSize)
    return gridX, gridY
end

--Fills in the grid given two coordinates
local function fillGrid(grid, tileSize)
    for k, v in pairs(grid) do
        for i, j in pairs(v) do
            if j == 1 then
                love.graphics.rectangle("fill", tileSize*(k - 1), tileSize*(i - 1),
                tileSize, tileSize)
            end
        end
    end
end

local grid = genGrid(width, height)


function lvl1:update(dt)
    pos = pos + speed * dt
end

function lvl1:init()
    --nothing
    love.graphics.setColor(255,0,0)
end

function lvl1:draw()
    --love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
    fillGrid(grid, tileSize)
end

function lvl1:mousepressed(x, y, button)
    if button == 'l' then
        gx, gy = locateGridPos(x,y, tileSize)
        grid[gx][gy] = 1 - grid[gx][gy]
    end
end

function lvl1:leave()
    --nothing yet
end



return lvl1
