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
    self.population = 5
    self:changeState("build")
end

function Village:addGuy(e)
    table.insert(self.guys, e)

    if self.state == "build" then
        e.sprite.animation = gengine.graphics.animation.get("builderLeft")
    end
end

function Village:removeGuy(e)
    for k, v in ipairs(self.guys) do
        if v == e then
            table.remove(self.guys, k)
            break
        end
    end
end

function Village:addConstructingBuilding(e)
    table.insert(self.constructingBuildings, e)
end

function Village:removeConstructingBuilding(e)
    for k, v in ipairs(self.constructingBuildings) do
        if v == e then
            table.remove(self.constructingBuildings, k)
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

function Village:removeHouse(e)
    for k, v in ipairs(self.houses) do
        if v == e then
            table.remove(self.houses, k)
            break
        end
    end
end

function Village:getGuysCount()
    return #self.guys
end

function Village:getClosestGuy(pos)
    local best = 10, r
    for k, v in ipairs(self.guys) do
        local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )

        if delta < best then
            best = delta
            r = v
        end
    end

    return r, best
end

function Village:getClosestConstructingBuilding(pos)
    local best = 10, r
    for k, v in ipairs(self.constructingBuildings) do
        local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )

        if delta < best then
            best = delta
            r = v
        end
    end

    return r
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

function Village:getClosestBuilding(pos)
    local best = 10, r
    for k, v in ipairs(self.buildings) do
        local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )

        if delta < best then
            best = delta
            r = v
        end
    end

    return r, best
end

function Village.onStateEnter:build()
    for k, v in ipairs(self.guys) do
        v.sprite.animation = gengine.graphics.animation.get("builderLeft")
    end
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

