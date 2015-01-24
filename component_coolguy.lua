ComponentCoolGuy = {}

local Settings = Settings

gengine.stateMachine(ComponentCoolGuy)

function ComponentCoolGuy:init()
    self.hp = 100
    self.repletion = 1
    self:changeState("random")
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

function ComponentCoolGuy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem

    if self.repletion > 0 then
        if wi.state == "idle" then
            wi:moveTo(math.random() * math.pi * 2)
            entity.sprite.extent = vector2(64 * wi.direction, 64)
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
    self.timeLeft = 1
end

function ComponentCoolGuy.onStateUpdate:eating(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        self.repletion = 1
        self:changeState("random")
    end
end

function ComponentCoolGuy.onStateExit:eating()

end
