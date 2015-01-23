ComponentWorldItem = {}

local Settings = Settings

local mpi = math.pi
local mcos = math.cos
local msin = math.sin

gengine.stateMachine(ComponentWorldItem)

function ComponentWorldItem:init()
    self.world = Game.world
    self.position = 0
    self.speed = 10
    self:changeState("idle")
end

function ComponentWorldItem:insert()
end

function ComponentWorldItem:update(dt)
    self:computePosition()

    self:updateState(dt)
end

function ComponentWorldItem:remove()
end

function ComponentWorldItem:setPosition(pos)
    self.position = pos
end

function ComponentWorldItem:computePosition()
    local x, y
    local cpos = self.position + self.world.rotation

    x = mcos(cpos) * Settings.worldRadius
    y = msin(cpos) * Settings.worldRadius

    self.entity.position = self.world.position + vector2(x, y)
    self.entity.rotation = cpos - mpi * 0.5
end

function ComponentWorldItem:moveTo(target)
    self.startPosition = self.position
    self.targetPosition = target

    self.direction = 1
    self:changeState("moving")
end

function ComponentWorldItem.onStateUpdate:idle(dt)

end

function ComponentWorldItem.onStateUpdate:moving(dt)
    if self.direction > 0 then
        if self.position < self.targetPosition then
            self.position = self.position + dt * self.speed * 0.01
            if self.position > self.targetPosition then
                self.position = self.targetPosition
                self:changeState("idle")
            end
        end
    else
        if self.position > self.targetPosition then
            self.position = self.position - dt * self.speed * 0.01
            if self.position < self.targetPosition then
                self.position = self.targetPosition
                self:changeState("idle")
            end
        end
    end
end