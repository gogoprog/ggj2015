ComponentHouse = {}

function ComponentHouse:init()
	self.timeLeft = 60
    self.goldGeneration = Settings.Buildings.House.goldGeneration
    self.goldTimer = Settings.Buildings.House.goldGenerationRate
end

function ComponentHouse:update(dt)
	if self.entity.built then
		Village:upMaxPop()
		self.entity.built = false
	end

	self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 and Village.population < Village.populationMax then
        local e = Factory:createMan()
        e.worldItem:setPosition(self.entity.worldItem.position)
        e:insert()
        self.timeLeft = 30
    end
end

function ComponentHouse:insert()
end

function ComponentHouse:remove()
end