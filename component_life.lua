ComponentLife = {}

function ComponentLife:init()
    self.hp = self.hp or 100
    self.maxHp = self.hp
end

function ComponentLife:insert()
end

function ComponentLife:remove()
end

function ComponentLife:update(dt)
end

function ComponentLife:hit(dmg)
    self.hp = self.hp - dmg
    self.entity:onHit(dmg)
    if self.hp < 0 then
        self.entity:onDead()
    end
end

function ComponentLife:isWounded()
    return self.hp < self.maxHp
end
