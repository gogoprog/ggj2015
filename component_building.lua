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

function ComponentBuilding:addWorkers(n)
    n = n or 1
end

function ComponentBuilding.onStateEnter:inConstruction()

end

function ComponentBuilding.onStateUpdate:inConstruction()

end

function ComponentBuilding.onStateExit:inConstruction()

end

function ComponentBuilding.onStateEnter:idle()

end

function ComponentBuilding.onStateUpdate:idle()

end

function ComponentBuilding.onStateExit:idle()

end

function ComponentBuilding.onStateEnter:producing()

end

function ComponentBuilding.onStateUpdate:producing()

end

function ComponentBuilding.onStateExit:producing()

end