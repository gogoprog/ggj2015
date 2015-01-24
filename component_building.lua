ComponentBuilding = {}

gengine.stateMachine(ComponentBuilding)

function ComponentBuilding:init()
    self.params = self.params or {}
    self.currentTime = 0
    self.constructionProgression = 0
    self.justBegun = true
    self.placingOffset = 80
    self:changeState("placing")
end

function ComponentBuilding:insert()
    -- self:changeState("inConstruction")
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

function ComponentBuilding.onStateEnter:placing()
    self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.complete)
    self.entity.sprite.color = vector4(1, 1, 1, 0.5)
    self.entity.worldItem.offset = self.entity.worldItem.offset + self.placingOffset
end

function ComponentBuilding.onStateUpdate:placing(dt)
    self.entity.worldItem.position = Game.cursor.worldItem.position
end

function ComponentBuilding.onStateEnter:inConstruction()
    self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.beginConstruction)
    self.entity.sprite.color = vector4(1, 1, 1, 1)
    self.entity.worldItem.offset = self.entity.worldItem.offset - self.placingOffset
end

function ComponentBuilding.onStateUpdate:inConstruction(dt)
    self.currentTime = self.currentTime + dt

    self.constructionProgression = self.constructionProgression + (dt * self.params.constructionRate)

    if self.justBegun and self.constructionProgression >= 0.5 then
        self.justBegun = false
        self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.halfConstruction)
    end

    if self.constructionProgression >= 1 then
        self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.complete)
        self:changeState("idle")
    end
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