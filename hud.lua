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

function Hud:modeBuild()

end

function Hud:modeFight()

end

function Hud:modeProduce()

end

function onPageLoaded()
    
end