Hud = {}

gengine.stateMachine(Hud)

function Hud:init()
	self:changeState("show")
end

function Hud.onStateEnter:show()
	gengine.gui.loadFile("gui/action_menu.html")
end

function Hud.onStateUpdate:show()
	
end

function Hud.onStateExit:show()
	gengine.gui.load("gui/blank_menu.html")
end