ComponentEnemy = {}

gengine.stateMachine(ComponentEnemy)

function ComponentEnemy:init()
    self:changeState("random")
end

function ComponentEnemy:insert()
    table.insert(Game.enemies, e)
end

function ComponentEnemy:remove()
    for k, v in ipairs(Game.enemies) do
        if v == self.entity then
            table.remove(Game.enemies, k)
            break
        end
    end
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
