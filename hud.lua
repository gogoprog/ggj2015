Hud = {}

gengine.stateMachine(Hud)

function Hud:init()
	gengine.gui.loadFile("gui/action_menu.html")
	gengine.gui.onPageLoaded = onPageLoaded
end

function Hud.buildFood()
    print("food")
end

function Hud.buildHouse()
    local e = Factory:createHouse()
    Game:placeBuilding(e)
end

function Hud.buildTower()
    print("tower")
end

function onPageLoaded()
	food = 3
	pop = 4
	max_pop = 5
    gengine.gui.executeScript("updateFood('" .. food .. "');")
    gengine.gui.executeScript("updatePop('" .. pop .. "');")
    gengine.gui.executeScript("updateMaxPop('" .. max_pop .. "');")
end