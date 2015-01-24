ComponentCoolGuy = {}

gengine.stateMachine(ComponentCoolGuy)

function ComponentCoolGuy:init()
    self.hp = 100
    self:changeState("random")
end

function ComponentCoolGuy:insert()
end

function ComponentCoolGuy:remove()
end

function ComponentCoolGuy:update(dt)
    self:updateState(dt)
end

function ComponentCoolGuy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem
    if wi.state == "idle" then
        wi:moveTo(math.random() * math.pi * 2)
        entity.sprite.extent = vector2(32 * wi.direction, 32)
    end
end