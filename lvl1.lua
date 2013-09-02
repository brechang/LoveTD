local lvl1 = {}
local GS = require "hump.gamestate"


function lvl1:init()
    --nothing
end

function lvl1:draw()
    love.graphics.printf("This is the first level. Lorem Ipsum and all that shit", 120, 200, 150, "center")
end

function lvl1:mousepressed(x, y, button)
    --nothing yet
end

function lvl1:leave()
    --nothing yet
end


--All these local bitches will be moved into some external module
--Generates a grid 
local function genGrid(width, height)
    local newGrid = {}
    for i = 1, width do
        newGrid[i] = {}
        for j = 1, height do
            newGrid[i][j] = 0
        end
    end
end

--Locates the grid coordinate based on mouseX, mouseY, and tileSize
local function locateGridPos(mouseX, mouseY, tileSize)
    local gridX, gridY = math.ceil(mouseX / tileSize), math.ceil(mouseY/tileSize)
    return gridX, gridY
end

--Fills in the grid given two coordinates
local function fillGrid(grid, tileSize, x, y)
    if(x and y) then 
        for k, v in pairs(grid) do 
            for i, j in pairs(v) do 
                love.graphics.rectangle("fill", tileSize*(k - 1), tileSize*(i - 1),
                tileSize, tileSize)
            end
        end
    end
end

return lvl1
