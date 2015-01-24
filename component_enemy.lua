ComponentEnemy = {}

gengine.stateMachine(ComponentEnemy)

function ComponentEnemy:init()
    self.hp = 100
    self:changeState("random")
end

function ComponentEnemy:insert()
end

function ComponentEnemy:remove()
end

function ComponentEnemy:update(dt)
    self:updateState(dt)
end

function ComponentEnemy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem
    if wi.state == "idle" then
        wi:moveTo(math.random() * math.pi * 2)
        entity.sprite.extent = vector2(64 * wi.direction, 64)
    end
end
