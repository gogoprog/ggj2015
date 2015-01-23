ComponentWorld = {}

local Settings = Settings

function ComponentWorld:init()
    self.camera = Game.camera
    self.cameraExtent = vector2(1024 * 2, 600 * 2)
    self.zoom = 1
    self.rotateSpeed = 0
end

function ComponentWorld:insert()
end

function ComponentWorld:update(dt)
    local mouse = gengine.input.mouse
    local keyboard = gengine.input.keyboard

    if mouse:isJustDown(1) then
        local x,y = gengine.input.mouse:getPosition()
        self.startX = x
        self.startRotation = self.entity.rotation
    elseif mouse:isDown(1) then
        local x,y = gengine.input.mouse:getPosition()
        self.lastX = x

        self.entity.rotation = self.startRotation + (x - self.startX) * -0.005

    elseif mouse:isJustUp(1) then
        local x,y = gengine.input.mouse:getPosition()

        self.rotateSpeed = (x - self.lastX) * - 1.0 * Settings.cameraRotateFactor
    end

    if self.rotateSpeed > 0 then
        self.rotateSpeed = self.rotateSpeed - dt * Settings.cameraSlowDown
        if self.rotateSpeed < 0 then
            self.rotateSpeed = 0
        end
        self.entity.rotation = self.entity.rotation + self.rotateSpeed * dt
    elseif self.rotateSpeed < 0 then
        self.rotateSpeed = self.rotateSpeed + dt * Settings.cameraSlowDown
        if self.rotateSpeed > 0 then
            self.rotateSpeed = 0
        end

        self.entity.rotation = self.entity.rotation + self.rotateSpeed * dt
    end

    if keyboard:isDown(81) then
        self.zoom = self.zoom + 1 * dt
        self.camera.camera.extent = self.cameraExtent * self.zoom
    elseif keyboard:isDown(82) then
        self.zoom = self.zoom - 1 * dt
        self.camera.camera.extent = self.cameraExtent * self.zoom
    end

    self.entity.position.y = - Settings.mapSize * 0.5 + self.zoom * Settings.cameraFactor
end

function ComponentWorld:remove()
end

