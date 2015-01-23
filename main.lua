
function init()
    gengine.application.setName("global.game.jam.2015")
    gengine.application.setExtent(640,480)
end

local e, cameraEntity

function start()
    gengine.graphics.setClearColor(0.5, 0.5, 0.5, 1)

    gengine.graphics.texture.createFromDirectory(".")
end

function update(dt)
    if gengine.input.keyboard:isJustUp(41) then
        gengine.application.quit()
    end
end

function stop()

end
