ComponentTower = {}

function ComponentTower:init()
    self.timeLeft = 1.0
end

function ComponentTower:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        Factory:createBullet(self.entity.worldItem.position, self.entity.worldItem.position + 0.5 * math.random(-1, 1))
        self.timeLeft = 1.0 * math.random()
    end
end

function ComponentTower:insert()
end

function ComponentTower:remove()
end