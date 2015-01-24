ComponentBuilding = {}

gengine.stateMachine(ComponentBuilding)

function ComponentBuilding:init()
    self.params = self.params or {}
    self.currentTime = 0
    self.constructionProgression = 0
    self.justBegun = true
    self.placingOffset = 80
    self.workers = {}
    if self.params.constructionRate then
        self:changeState("placing")
    else
        self:changeState("idle")
    end
end

function ComponentBuilding:insert()
end

function ComponentBuilding:remove()
end

function ComponentBuilding:update(dt)
    self:updateState(dt)
end

function ComponentBuilding:productionRate()
    return self.baseProductionRate * self.currentWorkers
end

function ComponentBuilding:isFullWorkers()
    return #self.workers >= self.params.maxWorkers
end

function ComponentBuilding:addWorker(e)
    table.insert(self.workers, e)
end

function ComponentBuilding:removeWorker(e)
    for k, v in ipairs(self.workers) do
        if v == e then
            table.remove(self.workers, k)
            break
        end
    end
end

function ComponentBuilding:canInteract()
    if self.state ~= "idle" then
        return true
    end

    if self.entity.farm then
        return true
    end

    if self.entity.home then
        return true
    end

    return false
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
    Village:addConstructingBuilding(self.entity)
    self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.beginConstruction)
    self.entity.sprite.color = vector4(1, 1, 1, 1)
    self.entity.worldItem.offset = self.entity.worldItem.offset - self.placingOffset
end

function ComponentBuilding.onStateUpdate:inConstruction(dt)
    self.currentTime = self.currentTime + dt

    self.constructionProgression = self.constructionProgression + (dt * self.params.constructionRate * #self.workers)
    self.entity.sprite.color = vector4(1, 1, 1, 0.5 + self.constructionProgression * 0.5)

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
    Village:removeConstructingBuilding(self.entity)
end

function ComponentBuilding.onStateEnter:idle()
    Village:addBuilding(self.entity)
    self.entity.built = true;
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