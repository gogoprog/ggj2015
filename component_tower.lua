ComponentTower = {}

function ComponentTower:init()
    self.params = self.entity.building.params
    self.timeLeft = self.params.attackInterval
end

function ComponentTower:update(dt)
    if self.entity.building.state == "idle" then
        self.timeLeft = self.timeLeft - dt

        if self.timeLeft < 0 then
            local wi = self.entity.worldItem
            local e, d = Game:getClosestEnemy(wi.position)

            if e then
                if d < self.params.attackArea then
                    local diff = Util:getDeltaAngle(wi.position, e.worldItem.position)
                    Factory:createBullet(wi.position, wi.position + diff)
                    gengine.audio.playSound(gengine.audio.sound.get("tower_fire"))
                    local damage = self.params.damage
                    local final_damage = damage[1] + (damage[2] - damage[1]) * math.random()
                    e.life:hit(final_damage)
                end
            end

            self.timeLeft = self.params.attackInterval
        end
    end
end

function ComponentTower:insert()
end

function ComponentTower:remove()
end