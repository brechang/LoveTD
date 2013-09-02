GS = require "hump.gamestate"
lvl1 = require "lvl1"

local mainMenu = {started = false}

function love.load()
    love.graphics.setMode(800, 600, false, true)
    love.graphics.setColor(0, 255, 0)

    GS.registerEvents()
    GS.switch(mainMenu)

end

function love.draw()
    --love.graphics.rectangle("line", 0, 0, 800, 600)
end

function love.keypressed(key)
    if key == 'q' then
        love.event.quit()
    end
end

--Game code
function mainMenu:draw()
    --Stuff happens and gamestate switches
    if mainMenu.started then
        GS.switch(lvl1)
    end

    love.graphics.printf("Welcome to LoveTD. Press 'q' to quit and 's' to start",
    120, 200, 150, "center")
end

function mainMenu:init()
    mainMenu.started = false
end

function mainMenu:keyreleased(key)
    if key == 's' then
        mainMenu.started = true
    end
end
