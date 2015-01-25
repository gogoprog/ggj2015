ComponentEnemyFort = {}

function ComponentEnemyFort:init()
    self.timeLeft = 0
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
        self.timeLeft = 5
    end
end

function ComponentEnemyFort:onDead()
    Game:winGame()
end