ComponentBuilding = {}

gengine.stateMachine(ComponentBuilding)

function ComponentBuilding:init()
    self.params = self.params or {}
    self.currentTime = 0
    self.constructionProgression = 0
    self.justBegun = true
end

function ComponentBuilding:insert()
    self:changeState("inConstruction")
end

function ComponentBuilding:update(dt)
    self:updateState(dt)
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

function ComponentBuilding.onStateUpdate:inConstruction(dt)
    self.currentTime = self.currentTime + dt

    self.constructionProgression = self.constructionProgression + (dt * self.params.constructionRate)

    if self.justBegun and self.constructionProgression >= 0.5 then
        self.justBegun = false
        self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.halfConstruction)
    end

    if self.constructionProgression >= 1 then
        self:changeState("idle")
    end

    print(self.constructionProgression)
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