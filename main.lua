require 'game'
require 'application'

function init()
    gengine.application.setName("global.game.jam.2015")
    gengine.application.setExtent(1024,600)
    print("STARTING GAME")
end

local e, cameraEntity

function start()
    print("STARTING GAME")
    gengine.graphics.setClearColor(0.0, 0.0, 0.0, 1)
    gengine.graphics.texture.createFromDirectory("data/")
    Application:init()
end

function update(dt)
    -- if gengine.input.keyboard:isJustUp(41) then
    --     gengine.application.quit()
    -- end
    Game:update(dt)
end

function stop()

end