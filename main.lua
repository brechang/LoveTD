GS = require "hump.gamestate"
lvl1 = require "lvl1"

local mainMenu = {}

function love.load()
    love.graphics.setMode(600, 800, false, true)
    love.graphics.setColor(0, 255, 0)

    GS.registerEvents()

end

function love.draw()
    love.graphics.rectangle("line", 0, 0, 400, 400)
end

--Game code
function mainMenu:draw()  
    --Stuff happens and gamestate switches
    GS.switch(lvl1)
end
    
