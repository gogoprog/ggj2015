ComponentHome = {}

function ComponentHome:init()
    --initial time off
    self.timeLeft = 5
    self.params = Settings.Buildings.Home
    self.goldTimer = Settings.Buildings.Home.goldGenerationRate
end

function ComponentHome:insert()
    Village.home = self.entity
end

function ComponentHome:remove()
    Village.home = nil
end

function ComponentHome:update(dt)
    self.timeLeft = self.timeLeft - dt
    self.goldTimer = self.goldTimer - dt

    if self.timeLeft < 0 and Village.population < Village.populationMax then
        local e = Factory:createMan()
        e.worldItem:setPosition(self.entity.worldItem.position)
        e:insert()
        -- time to spawn next human
        self.timeLeft = 30
    end

    if self.goldTimer < 0 then
        Village:upGold(self.params.goldGeneration)
        self.goldTimer = self.params.goldGenerationRate
    end
end