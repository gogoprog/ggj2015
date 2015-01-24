ComponentEnemyFort = {}

function ComponentEnemyFort:init()
    self.timeLeft = 2
end

function ComponentEnemyFort:insert()
end

function ComponentEnemyFort:remove()

end

function ComponentEnemyFort:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        --local e = Factory:createEnemy()
        --e.worldItem:setPosition(self.entity.worldItem.position)
        --e:insert()
        self.timeLeft = 2
    end
end
