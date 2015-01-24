ComponentHome = {}

function ComponentHome:init()
    self.timeLeft = 5
    self.params = self.params
end

function ComponentHome:insert()
    Village.home = self.entity
end

function ComponentHome:remove()
    Village.home = nil
end

function ComponentHome:update(dt)
    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then
        local e = Factory:createMan()
        e.worldItem:setPosition(self.entity.worldItem.position)
        e:insert()
        self.timeLeft = 30
    end
end
