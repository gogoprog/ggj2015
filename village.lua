Village = {}

gengine.stateMachine(Village)

function Village:reset()
    self.constructingBuildings = {}
    self.farms = {}
    self.towers = {}
    self.houses = {}
    self.guys = {}
    self.buildings = {}
    self.home = nil
    self.food = 0
    self.population = 0
    self.populationMax = 5
    self:changeMode("build")
end

function Village:addGuy(e)
    table.insert(self.guys, e)

    e.sprite.animation = gengine.graphics.animation.get(Settings.Guys[self.state].moveAnimation)
end

function Village:removeGuy(e)
    for k, v in ipairs(self.guys) do
        if v == e then
            table.remove(self.guys, k)
            break
        end
    end
end

function Village:upFood()
    self.food = self.food + 1
    gengine.gui.executeScript("updateFood('" .. self.food .. "');")
end

function Village:downFood()
    self.food = self.food - 1
    gengine.gui.executeScript("updateFood('" .. self.food .. "');")
end

function Village:upPop()
    self.population = self.population + 1
    gengine.gui.executeScript("updatePop('" .. self.population .. "');")
end

function Village:downPop()
    self.population = self.population - 1
    gengine.gui.executeScript("updatePop('" .. self.population .. "');")
end

function Village:upMaxPop()
    self.populationMax = self.populationMax + 4
    gengine.gui.executeScript("updateMaxPop('" .. self.populationMax .. "');")
end

function Village:addConstructingBuilding(e)
    table.insert(self.constructingBuildings, e)
    table.insert(self.buildings, e)
end

function Village:removeConstructingBuilding(e)
    for k, v in ipairs(self.constructingBuildings) do
        if v == e then
            table.remove(self.constructingBuildings, k)
            break
        end
    end

    for k, v in ipairs(self.buildings) do
        if v == e then
            table.remove(self.buildings, k)
            break
        end
    end
end

function Village:addBuilding(e)
    table.insert(self.buildings, e)

    if e.farm then
        Village:addFarm(e)
    end

    if e.house then
        Village:addHouse(e)
    end

    if e.tower then
        Village:addTower(e)
    end
end

function Village:removeBuilding(e)
    for k, v in ipairs(self.buildings) do
        if v == e then
            table.remove(self.buildings, k)
            break
        end
    end

    if e.farm then
        Village:removeFarm(e)
    end

    if e.house then
        Village:removeHouse(e)
    end

    if e.tower then
        Village:removeTower(e)
    end
end

function Village:addFarm(e)
    table.insert(self.farms, e)
end

function Village:removeFarm(e)
    for k, v in ipairs(self.farms) do
        if v == e then
            table.remove(self.farms, k)
            break
        end
    end
end

function Village:addHouse(e)
    table.insert(self.houses, e)
end

function Village:removeHouse(e)
    for k, v in ipairs(self.houses) do
        if v == e then
            table.remove(self.houses, k)
            break
        end
    end
end

function Village:addTower(e)
    table.insert(self.towers, e)
end

function Village:removeTower(e)
    for k, v in ipairs(self.towers) do
        if v == e then
            table.remove(self.towers, k)
            break
        end
    end
end

function Village:getGuysCount()
    return #self.guys
end

function Village:getClosestGuy(pos, no_order)
    local best = 10, r
    for k, v in ipairs(self.guys) do
        if not no_order or v.guy.state ~= "executing" then
            local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )


            if delta < best then
                best = delta
                r = v
            end
        end
    end

    return r, best
end

function Village:getClosestFarm(pos)
    local best = 10, r
    for k, v in ipairs(self.farms) do
        local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )

        if delta < best then
            best = delta
            r = v
        end
    end

    return r
end

function Village:getClosestHouse(pos)
    local best = 10, r
    for k, v in ipairs(self.houses) do
        local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )

        if delta < best then
            best = delta
            r = v
        end
    end

    return r
end

function Village:getClosestBuilding(pos, interactable)
    local best = 10, r
    for k, v in ipairs(self.buildings) do
        if not interactable or v.building:canInteract() then
            local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )
            if delta < best then
                best = delta
                r = v
            end
        end
    end

    return r, best
end

function Village:changeMode(which)
    print("MODE " .. which)
    for k, v in ipairs(self.guys) do
        v.sprite.animation = gengine.graphics.animation.get(Settings.Guys[which].moveAnimation)
    end

    self:changeState(which)
end

function Village.onStateEnter:build()

end

function Village.onStateUpdate:build(dt)

end

function Village.onStateExit:build()

end

function Village.onStateEnter:fight()

end

function Village.onStateUpdate:fight(dt)

end

function Village.onStateExit:fight()

end

function Village.onStateEnter:produce()

end

function Village.onStateUpdate:produce(dt)

end

function Village.onStateExit:produce()

end

