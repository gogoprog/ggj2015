ComponentCoolGuy = {}

local Settings = Settings
local mabs = math.abs

gengine.stateMachine(ComponentCoolGuy)

function ComponentCoolGuy:init()
    self.repletion = 1
    self:changeState("random")
    Village:upPop()
end

function ComponentCoolGuy:insert()
    Village:addGuy(self.entity)
end

function ComponentCoolGuy:remove()
    Village:removeGuy(self.entity)
end

function ComponentCoolGuy:update(dt)
    if self.repletion > 0 then
        self.repletion = self.repletion - dt * Settings.hungryFactor

        if self.repletion < 0 then
            self:changeState("seekingFood")
            self.repletion = 0
        end
    end

    self:updateState(dt)
end

function ComponentCoolGuy:onHit()
    self:changeState("fighting")
end

function ComponentCoolGuy:onDead()
    Village:downPop()
    self.entity:remove()
    gengine.entity.destroy(self.entity)
end

function ComponentCoolGuy.onStateEnter:random()
    self.checkTimeLeft = 0.1
end

function ComponentCoolGuy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem

    if self.repletion > 0 then

        self.checkTimeLeft = self.checkTimeLeft - dt

        if self.checkTimeLeft < 0 then
            self.checkTimeLeft = 0.1

            local b, d = Village:getClosestBuilding(wi.position, true)
            if b and not b.building:isFullWorkers() then
                if d < b.building.params.areaSize then
                    self.targetSite = b
                    self:changeState("interacting")
                else
                    wi:moveTo(b.worldItem.position)
                    entity.sprite.extent = vector2(64 * wi.direction, 64)
                end
            elseif wi.state == "idle" then
                local b, d = Village:getClosestBuilding(wi.position)
                local t = b.worldItem.position + (math.random() - 0.5) * 0.3
                wi:moveTo(t)
                entity.sprite.extent = vector2(64 * wi.direction, 64)
            end
        end
    end
end

function ComponentCoolGuy:orderMoveTo(r)
    print("MOVETO")
end

function ComponentCoolGuy.onStateEnter:seekingFood()
    local entity = self.entity
    local wi = entity.worldItem
    local farm = Village:getClosestFarm(self.entity.worldItem.position)

    if farm then
        self.entity.worldItem:moveTo(farm.worldItem.position)
        self.targetForFood = farm
    else
        self.entity.worldItem:moveTo(Village.home.worldItem.position)
        self.targetForFood = Village.home
    end

    entity.sprite.extent = vector2(64 * wi.direction, 64)
end

function ComponentCoolGuy.onStateUpdate:seekingFood(dt)
    if self.entity.worldItem.state == "idle" then
        self:changeState("eating")
    end
end

function ComponentCoolGuy.onStateExit:seekingFood()

end

function ComponentCoolGuy.onStateEnter:eating()
    if Village.food <= 0 then
        self.onDead()
    else
        self.timeLeft = 1
    end

end

function ComponentCoolGuy.onStateUpdate:eating(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        Village:downFood()
        self:changeState("random")
    end
end

function ComponentCoolGuy.onStateExit:eating()
    self.repletion = 1
end

function ComponentCoolGuy.onStateEnter:fighting()
    self.entity.worldItem:stop()
    self.timeLeft = 1
end

function ComponentCoolGuy.onStateUpdate:fighting(dt)

end

function ComponentCoolGuy.onStateExit:fighting()

end

function ComponentCoolGuy.onStateEnter:interacting()
    self.entity.worldItem:stop()
    self.timeLeft = 1
    self.targetSite.building:addWorker(self.entity)
end

function ComponentCoolGuy.onStateUpdate:interacting(dt)
    if self.targetSite.building:canInteract() then

    else
        self:changeState("random")
    end
end

function ComponentCoolGuy.onStateExit:interacting()
    self.targetSite.building:removeWorker(self.entity)
end