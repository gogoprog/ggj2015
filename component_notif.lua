ComponentNotif = {}

function ComponentNotif:init()
    self.timeLeft = 1
end

function ComponentNotif:insert()
end

function ComponentNotif:remove()
end

function ComponentNotif:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.target then
        self.entity.worldItem.position = self.target.worldItem.position
    end

    self.entity.sprite.color = vector4(1,1,1,self.timeLeft)

    if self.timeLeft < 0 then
        self.entity:remove()
        gengine.entity.destroy(self.entity)
    end
end

