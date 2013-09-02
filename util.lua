local UT = {
    tileSize = 50,
    speed    = 5,
    pos      = 0,
    width    = 800,
    height   = 600
}

--Generates a grid
function UT.genGrid()
    local newGrid = {}
    for i = 1, UT.width/UT.tileSize do
        newGrid[i] = {}
        for j = 1, UT.height/UT.tileSize do
            newGrid[i][j] = 0
        end
    end
    return newGrid
end

--Locates the grid coordinate based on mouseX, mouseY, and tileSize
function UT.locateGridPos(mouseX, mouseY, tileSize)
    local gridX, gridY = math.ceil(mouseX / tileSize), math.ceil(mouseY/tileSize)
    return gridX, gridY
end

--Fills in the grid given two coordinates
function UT.fillGrid(grid, tileSize)
    for k, v in pairs(grid) do
        for i, j in pairs(v) do
            if j == 1 then
                love.graphics.rectangle("fill", tileSize*(k - 1), tileSize*(i - 1),
                tileSize, tileSize)
            end
        end
    end
end

return UT
