ComponentEnemyFort = {}

function ComponentEnemyFort:init()
    self.timeLeft = 2
end

function ComponentEnemyFort:insert()
    table.insert(Game.enemies, e)
end

function ComponentEnemyFort:remove()
    for k, v in ipairs(Game.enemies) do
        if v == self.entity then
            table.remove(Game.enemies, k)
            break
        end
    end
end

function ComponentEnemyFort:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        local e = Factory:createEnemy()
        e.worldItem:setPosition(self.entity.worldItem.position)
        e:insert()
        self.timeLeft = 2
    end
end
