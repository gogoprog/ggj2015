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
    gengine.audio.playSound(gengine.audio.sound.get("click_button"))
end

function Hud.buildHouse()
    local e = Factory:createHouse()
    UserAction:placeBuilding(e)
    gengine.audio.playSound(gengine.audio.sound.get("click_button"))
end

function Hud.buildTower()
    local e = Factory:createTower()
    UserAction:placeBuilding(e)
    gengine.audio.playSound(gengine.audio.sound.get("click_button"))
end

function Hud:modeBuild()
    if Village:buyWhatDoWeDoNowCredit() then
        Village:changeMode("build")
    end
end

function Hud:modeFight()
    if Village:buyWhatDoWeDoNowCredit() then
        Village:changeMode("fight")
    end
end

function Hud:modeProduce()
    if Village:buyWhatDoWeDoNowCredit() then
        Village:changeMode("produce")
    end
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
    gengine.gui.executeScript("updateFood('" .. Village.food .. "');")
    gengine.gui.executeScript("updateGold('" .. Village.treasure .. "');")
    gengine.gui.executeScript("updateHousePrice('" .. Settings.Buildings.House.price .. "');")
    gengine.gui.executeScript("updateFarmPrice('" .. Settings.Buildings.Farm.price .. "');")
    gengine.gui.executeScript("updateTowerPrice('" .. Settings.Buildings.Tower.price .. "');")
    gengine.gui.executeScript("updateWhatDoWeDoNowCreditPrice('" .. Settings.whatDoWeDoNowCreditsPrice .. "');")
end