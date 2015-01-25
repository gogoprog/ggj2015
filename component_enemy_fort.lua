ComponentEnemyFort = {}

function ComponentEnemyFort:init()
    self.timeLeft = 0
    self.spawnCount = 0
end

function ComponentEnemyFort:insert()
end

function ComponentEnemyFort:remove()
end

function ComponentEnemyFort:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        local e = Factory:createEnemy()
        if math.random(1,2) == 1 then
            e.worldItem:setPosition(self.entity.worldItem.position + 0.05)
        else
            e.worldItem:setPosition(self.entity.worldItem.position - 0.05)
        end
        e:insert()
        self.spawnCount = self.spawnCount + 2
        self.timeLeft = 30 - math.min(self.spawnCount, 28)
    end
end