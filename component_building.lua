ComponentBuilding = {}

gengine.stateMachine(ComponentBuilding)

local Settings = Settings

function ComponentBuilding:init()

    self.params = self.params or {}
    self.currentTime = 0
    self.constructionProgression = 0
    self.justBegun = true
    self.placingOffset = 80
    self.workers = {}
    self.instantCreation = self.instantCreation or false
    self.hp = 1
    self.price = self.price or 100

    if self.instantCreation then
        self:changeState("idle")
    else
        self:changeState("placing")
    end
end

function ComponentBuilding:insert()
    
end

function ComponentBuilding:remove()
end

function ComponentBuilding:update(dt)
    if self.state ~= "placing" then
        self.gauge.sprite.extent = vector2((self.entity.life.hp / self.entity.life.maxHp) * 65 , 8)
    end

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
    else
        if self.entity.life:isWounded() then
            return true
        end
    end

    if self.entity.farm then
        return true
    end

    if self.entity.home then
        return false
    end

    return false
end

function ComponentBuilding:onDead()
    if self.entity.home then
        Game:loseGame()
    end

    if self.entity.enemyFort then
        Game:winGame()
    end

    self.gauge:remove()
    self.entity:remove()
    Village:removeBuilding(self.entity)
    gengine.entity.destroy(self.gauge)
    gengine.entity.destroy(self.entity)
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
    Village:downGold(self.params.price)
    Village:addConstructingBuilding(self.entity)
    self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.beginConstruction)
    self.entity.sprite.color = vector4(1, 1, 1, 1)
    self.entity.worldItem.offset = self.entity.worldItem.offset - self.placingOffset

    self:addGauge()

end

function ComponentBuilding:addGauge()
    self.gauge = nil
    self.gauge = Factory:createGauge()
    self.gauge.worldItem.position = self.entity.worldItem.position
    self.gauge.worldItem.offset = 128
    self.gauge.sprite.extent = vector2(65, 8)
    self.gauge.sprite_back.extent = vector2(65, 8)
    self.entity.life.hp = 1
    self.gauge:insert()

end

function ComponentBuilding.onStateUpdate:inConstruction(dt)
    self.currentTime = self.currentTime + dt

    self.constructionProgression = self.constructionProgression + (dt * (self.params.constructionRate * Settings.Guys[Village.state].buildFactor) * #self.workers * 0.1)
    self.entity.sprite.color = vector4(1, 1, 1, 0.5 + self.constructionProgression * 0.5)
    self.entity.life.hp = self.entity.life.maxHp * self.constructionProgression

    if self.justBegun and self.constructionProgression >= 0.5 then
        self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.complete)
        self.justBegun = false
        self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.halfConstruction)
    end

    if self.constructionProgression >= 1 then
        self.entity.life.hp = self.entity.life.maxHp
        self.entity.sprite.texture = gengine.graphics.texture.get(self.params.Textures.complete)
        self:changeState("idle")
    end
end

function ComponentBuilding.onStateExit:inConstruction()
    Village:removeConstructingBuilding(self.entity)
end

function ComponentBuilding.onStateEnter:idle()
    Village:addBuilding(self.entity)
    self.entity.built = true
end

function ComponentBuilding.onStateUpdate:idle(dt)
    if self.entity.life:isWounded() then
        self.entity.life.hp = self.entity.life.hp + dt * #self.workers * Settings.Guys[Village.state].repairFactor
    end
end

function ComponentBuilding.onStateExit:idle()

end

function ComponentBuilding.onStateEnter:producing()

end

function ComponentBuilding.onStateUpdate:producing()

end

function ComponentBuilding.onStateExit:producing()

end

function ComponentBuilding:onHit()

end