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
    Village:changeMode("build")
end

function Hud:modeFight()
    Village:changeMode("fight")
end

function Hud:modeProduce()
    Village:changeMode("produce")
end

function Hud:winGame()
    gengine.gui.executeScript("showWinOrLose('" .. 1 .. "');")
end

function Hud:loseGame()
    gengine.gui.executeScript("showWinOrLose('" .. 0 .. "');")
end

function Hud:buyWhatDoWeDoNowCredit()
    if not Village:buyWhatDoWeDoNowCredit() then
        gengine.gui.executeScript("showCannotBuyWhatDoWeDoNowCredit();")
    end
end

function onPageLoaded()
    
end

function Hud:showMainMenu()
    gengine.gui.loadFile("gui/main_menu.html")
end