Hud = {}

gengine.stateMachine(Hud)

function Hud:init()
	gengine.gui.onPageLoaded = onPageLoaded
end

function Hud.onStateEnter:showWDWDNMenu()
    gengine.gui.loadFile("gui/blank_menu.html")
    gengine.gui.loadFile("gui/action_menu.html")
end

function Hud.onStateUpdate:showWDWDNMenu()
    
end

function Hud.onStateExit:showWDWDNMenu()
    gengine.gui.loadFile("gui/blank_menu.html")
end

function Hud.selectMenuA()
    print("Menu A selected")
end

function Hud.selectMenuB()
    print("Menu B selected")
end

function Hud.selectMenuC()
    print("Menu C selected")
end

function Hud.exitWDWDN()
    print("exit WDWDN")
end

function onPageLoaded()
	total = 3
    gengine.gui.executeScript("updateFood('" .. total .. "');")
end