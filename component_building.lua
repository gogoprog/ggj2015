ComponentBuilding = {}

gengine.stateMachine(ComponentBuilding)

function ComponentBuilding:init()
    self.params = self.params or {}
end

function ComponentBuilding:insert()
    self:changeState("inConstruction")
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
    self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.beginConstruction)
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