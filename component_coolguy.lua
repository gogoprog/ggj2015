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
            self.repletion = 0
            if Village.food > 0 then
                Village:downFood()
                self.repletion = 1
            else
                self:onDead()
            end
        end
    end

    self:updateState(dt)
end

function ComponentCoolGuy:onHit(dmg)
    self.entity.life.hp = self.entity.life.hp + dmg * ( 1 - Settings.Guys[Village.state].hitFactor)
    if self.state ~= "fighting" then
        self:changeState("fighting")
    end
end

function ComponentCoolGuy:onDead()
    Village:downPop()

    if self.targetSite then
        self.targetSite.building:removeWorker(self.entity)
    end

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

    self:changeState("executing")

    Factory:createNotif(self.entity, 23)

    self:ensureAnim()
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

function ComponentCoolGuy:ensureAnim()
    local entity = self.entity
    local wi = entity.worldItem
    self.entity.sprite.animation = gengine.graphics.animation.get(Settings.Guys[Village.state].moveAnimation)
    entity.sprite.extent = vector2(64 * wi.direction, 64)
end

function ComponentCoolGuy.onStateEnter:seekingFood()
    local entity = self.entity
    local wi = entity.worldItem
    local farm = Village:getClosestFarm(wi.position)

    if farm then
        wi:moveTo(farm.worldItem.position)
        self.targetForFood = farm
    else
        wi:moveTo(Village.home.worldItem.position)
        self.targetForFood = Village.home
    end

    self:ensureAnim()

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
    self:ensureAnim()
    self.timeLeft = 1
    self.targetSite.building:addWorker(self.entity)
    self.entity.sprite.animation = gengine.graphics.animation.get(Settings.Guys[Village.state].buildAnimation)

    Factory:createNotif(self.entity, math.random(7, 10))

    local area = self.targetSite.building.params.areaSize
    local count = self.targetSite.building.params.maxWorkers
    local n = #self.targetSite.building.workers - 1

    self.entity.worldItem.position = self.targetSite.worldItem.position - area * 0.5 + area * (n/count)
end

function ComponentCoolGuy.onStateUpdate:interacting(dt)
    if self.targetSite.building:canInteract() then

    else
        self:changeState("random")
    end
end

function ComponentCoolGuy.onStateExit:interacting()
    self.targetSite.building:removeWorker(self.entity)
    self:ensureAnim()
    self.targetSite = nil
end


function ComponentCoolGuy.onStateEnter:executing()
    self:ensureAnim()
end

function ComponentCoolGuy.onStateUpdate:executing(dt)
    if self.entity.worldItem.state == "idle" then
        self:changeState("random")
    end
end

function ComponentCoolGuy.onStateExit:executing()

end