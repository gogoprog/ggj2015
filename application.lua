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

end

function Application.onStateExit:ingame()

end

function Application:start()
    self:changeState("ingame")
end
