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