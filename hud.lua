Hud = {}

gengine.stateMachine(Hud)

function Hud:init()
	gengine.gui.loadFile("gui/action_menu.html")
	gengine.gui.onPageLoaded = onPageLoaded
end

function Hud:onMouseDown()
    print("hudcmousedown")
end

function Hud.buildFood()
    local e = Factory:createFarm()
    UserAction:placeBuilding(e)
end

function Hud.buildHouse()
    local e = Factory:createHouse()
    UserAction:placeBuilding(e)
end

function Hud.buildTower()
    local e = Factory:createTower()
    UserAction:placeBuilding(e)
end

function onPageLoaded()
	pop = 4
	max_pop = 5
    
    gengine.gui.executeScript("updatePop('" .. pop .. "');")
    
end