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

function ComponentCoolGuy:onHit(dmg)
    self.entity.life.hp = self.entity.life.hp + dmg * ( 1 - Settings.Guys[Village.state].hitFactor)
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
    local entity = self.entity
    local wi = entity.worldItem

    wi:moveTo(r)
    entity.sprite.extent = vector2(64 * wi.direction, 64)

    self:changeState("executing")

    Factory:createNotif(self.entity, 23)
end

function ComponentCoolGuy:checkForEnemies()
    local wi = self.entity.worldItem
    local g, d = Game:getClosestEnemy(wi.position)

    if g then
        if d < Settings.attackDistance then
            return g
        end
    end
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

    self.entity.sprite.animation = gengine.graphics.animation.get(Settings.Guys[Village.state].moveAnimation)

    entity.sprite.extent = vector2(64 * wi.direction, 64)
end

function ComponentCoolGuy.onStateEnter:seekingFood()
    Factory:createNotif(self.entity, math.random(17, 19))
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
    self.timeLeft = 0
    Factory:createNotif(self.entity, math.random(11, 16))
end

function ComponentCoolGuy.onStateUpdate:fighting(dt)
    self.timeLeft = self.timeLeft - dt
    if self.timeLeft < 0 then
        local g = self:checkForEnemies()
        if g then
            local damage = Settings.Guys[Village.state].damage
            local final_damage = damage[1] + (damage[2] - damage[1]) * math.random()
            g.life:hit(final_damage)
            self.timeLeft = Settings.Guys[Village.state].attackInterval
        else
            self:changeState("random")
        end
    end
end

function ComponentCoolGuy.onStateExit:fighting()

end

function ComponentCoolGuy.onStateEnter:interacting()
    self.entity.worldItem:stop()
    self.entity.sprite.animation = gengine.graphics.animation.get(Settings.Guys[Village.state].buildAnimation)
    self.timeLeft = 1
    self.targetSite.building:addWorker(self.entity)
    Factory:createNotif(self.entity, math.random(7, 10))
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


function ComponentCoolGuy.onStateEnter:executing()
    self.entity.sprite.animation = gengine.graphics.animation.get(Settings.Guys[Village.state].moveAnimation)
end

function ComponentCoolGuy.onStateUpdate:executing(dt)
    if self.entity.worldItem.state == "idle" then
        self:changeState("random")
    end
end

function ComponentCoolGuy.onStateExit:executing()

end