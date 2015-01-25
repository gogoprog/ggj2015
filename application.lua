Application = Application or {}

gengine.stateMachine(Application)

function Application:init()
    self:changeState("menu")
end

function Application:update(dt)
    self:updateState(dt)
end

function Application.onStateEnter:menu()
    gengine.gui.loadFile("gui/main.html")
end

function Application.onStateUpdate:menu(dt)
end

function Application.onStateExit:menu()
end

function Application.onStateEnter:ingame()
    Game:init()
    Game:start()
end

function Application.onStateUpdate:ingame(dt)
    if gengine.input.keyboard:isJustUp(4) then
        local e = Factory:createEnemy()
        e.worldItem:setPosition(Game.cursor.worldItem.position)
        e:insert()
        table.insert(Game.enemies, e)
    end

    if gengine.input.keyboard:isJustDown(44) then
        local e = Factory:createMan()
        e.worldItem:setPosition(Game.cursor.worldItem.position)
        e:insert()
        Game.timeLeft = 30
    end
end

function Application.onStateExit:ingame()

end

function Application:start()
    self:changeState("ingame")
end

function Application:next()
    self:changeState("menu")
end
