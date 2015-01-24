ComponentEnemy = {}

gengine.stateMachine(ComponentEnemy)

function ComponentEnemy:init()
    self.gauge = self.gauge

    self:changeState("random")
end

function ComponentEnemy:insert()
    table.insert(Game.enemies, self.entity)
    self.gauge:insert()
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
    self.gauge.worldItem.position = self.entity.worldItem.position
    self.gauge.sprite.extent = vector2(self.entity.life.hp / 4 , 8)
    self:updateState(dt)
end

function ComponentEnemy:checkForGuys()
    local wi = self.entity.worldItem
    local g, d = Village:getClosestGuy(wi.position)

    if g then
        if d < Settings.attackDistance then
            return g
        end
    end
end

function ComponentEnemy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem
    if wi.state == "idle" then
        wi:moveTo(math.random() * math.pi * 2)
        entity.sprite.extent = vector2(64 * wi.direction, 64)
    end

    local g = self:checkForGuys()
    if g then
        self:changeState("fighting")
    end
end

function ComponentEnemy.onStateEnter:fighting()
    local wi = self.entity.worldItem
    wi:stop()
    self.timeLeft = 0
end

function ComponentEnemy.onStateUpdate:fighting(dt)
    self.timeLeft = self.timeLeft - dt
    if self.timeLeft < 0 then
        local g = self:checkForGuys()
        if g then
            local damage = Settings.Enemy.damage
            local final_damage = damage[1] + (damage[2] - damage[1]) * math.random()
            g.life:hit(final_damage)
            self.timeLeft = Settings.Enemy.attackInterval
        else
            self:changeState("random")
        end
    end
end

function ComponentEnemy.onStateExit:fighting()

end
