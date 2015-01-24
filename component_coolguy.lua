ComponentCoolGuy = {}

gengine.stateMachine(ComponentCoolGuy)

function ComponentCoolGuy:init()
    self.hp = 100
    self:changeState("random")
end

function ComponentCoolGuy:insert()
    Village:addGuy(self.entity)
end

function ComponentCoolGuy:remove()
    Village:removeGuy(self.entity)
end

function ComponentCoolGuy:update(dt)
    self:updateState(dt)
end

function ComponentCoolGuy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem
    if wi.state == "idle" then
        wi:moveTo(math.random() * math.pi * 2)
        entity.sprite.extent = vector2(64 * wi.direction, 64)
    end
end