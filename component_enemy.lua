ComponentEnemy = {}

gengine.stateMachine(ComponentEnemy)

function ComponentEnemy:init()
    self.gauge = self.gauge

    self:changeState("random")

    self.speakTimeLeft = 0
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
    self.gauge:remove()
    gengine.entity.destroy(self.gauge)
end

function ComponentEnemy:update(dt)
    self.gauge.worldItem.position = self.entity.worldItem.position
    self.gauge.sprite.extent = vector2((self.entity.life.hp / self.entity.life.maxHp) * 25 , 8)
    self:updateState(dt)

    self.speakTimeLeft = self.speakTimeLeft - dt
    if self.speakTimeLeft < 0 then
        if math.random(1, 2) == 1 then
            Factory:createNotif(self.entity, math.random(0, 6), 110)
            self.speakTimeLeft = math.random(5, 10)
        end
    end
end

function ComponentEnemy:checkForBuildings()
    local wi = self.entity.worldItem
    local b, d = Village:getClosestCoolBuilding(wi.position)

    if b then
        if d < (Settings.attackDistance + b.building.params.areaSize) then
            return b
        end
    end
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

function ComponentEnemy:ensureAnim()
    local entity = self.entity
    local wi = entity.worldItem
    self.entity.sprite.animation = gengine.graphics.animation.get("enemy_left")
    entity.sprite.extent = vector2(64 * wi.direction, 64)
end

function ComponentEnemy:onHit()

end

function ComponentEnemy:onDead()
    self.entity:remove()
    gengine.entity.destroy(self.entity)
end

function ComponentEnemy.onStateUpdate:random(dt)
    local entity = self.entity
    local wi = entity.worldItem
    if wi.state == "idle" then
        wi:moveTo(math.pi * 0.5)
        self:ensureAnim()
    end

    local g = self:checkForGuys()
    if g then
        self:changeState("fighting")
    end

    local b = self:checkForBuildings()
    if b then
        self:changeState("fighting")
    end
end

function ComponentEnemy.onStateEnter:fighting()
    local wi = self.entity.worldItem
    wi:stop()
    self.timeLeft = 0

    self.entity.sprite:pushAnimation(gengine.graphics.animation.get("enemy_fight_left"))
end

function ComponentEnemy.onStateUpdate:fighting(dt)
    self.timeLeft = self.timeLeft - dt
    if self.timeLeft < 0 then
        local g = self:checkForGuys()
        local b = self:checkForBuildings()
        if g or b then
            local damage = Settings.Enemy.damage
            local final_damage = damage[1] + (damage[2] - damage[1]) * math.random()
            if g then
                g.life:hit(final_damage)
            elseif b then
                b.life:hit(final_damage)
            end
            self.timeLeft = Settings.Enemy.attackInterval
            self.entity.sprite:pushAnimation(gengine.graphics.animation.get("enemy_fight_left"))
        else
            self:changeState("random")
        end
    end
end

function ComponentEnemy.onStateExit:fighting()

end