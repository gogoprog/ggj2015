ComponentBuilding = {}

function ComponentBuilding:init()
    self.constructionRate = 1
    self.maxWorkers = 10
    self.currentWorkers = 0
    self.baseProductionRate = 1.2
end

function ComponentBuilding:update(dt)

end

function ComponentBuilding:productionRate()
    return sef.baseProductionRate * self.currentWorkers
end

function ComponentBuilding:addWorker()

end