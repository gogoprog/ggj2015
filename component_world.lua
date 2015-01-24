ComponentWorld = {}

local Settings = Settings
local matan2 = math.atan2

function ComponentWorld:init()
    self.camera = Game.camera
    self.cameraExtent = vector2(1024 * 2, 600 * 2)
    self.zoom = 1
    self.rotateSpeed = 0
    self.zoomSpeed = 0
    self.currentRadiant = 0
end

function ComponentWorld:insert()
end

function ComponentWorld:update(dt)
    local mouse = gengine.input.mouse
    local keyboard = gengine.input.keyboard
    local entity = self.entity
    local zoomFactor = (self.zoom -  Settings.cameraMinZoom) / ( Settings.cameraMaxZoom -  Settings.cameraMinZoom)

    if mouse:isJustDown(3) then
        local x,y = gengine.input.mouse:getPosition()
        self.startX = x
        self.startRotation = entity.rotation
    elseif mouse:isDown(3) then
        local x,y = gengine.input.mouse:getPosition()
        self.lastX = x

        entity.rotation = self.startRotation + (x - self.startX) * -0.01 * ( 0.1 + zoomFactor )

    elseif mouse:isJustUp(3) then
        local x,y = gengine.input.mouse:getPosition()

        self.rotateSpeed = (x - self.lastX) * - 1.0 * Settings.cameraRotateFactor
    end

    if gengine.input.keyboard:isDown(79) then
       entity.rotation = entity.rotation + 0.025
    end
    if gengine.input.keyboard:isDown(80) then
       entity.rotation = entity.rotation - 0.025
    end

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera.camera:getWorldPosition(x,y)
    local dist = gengine.math.getDistance(entity.position, vector2(wx, wy))

    if math.abs(dist - Settings.worldRadius) < Settings.clickableZone then
        local dx, dy

        dy = wy - entity.position.y
        dx = wx - entity.position.x
        local r = matan2(dy, dx)

        r = r - entity.rotation

        Game.cursor.worldItem:setPosition(r)

        if mouse:isJustDown(1) then
            Game:onClick(r)
        end
    end

    if self.rotateSpeed > 0 then
        self.rotateSpeed = self.rotateSpeed - dt * Settings.cameraSlowDown
        if self.rotateSpeed < 0 then
            self.rotateSpeed = 0
        end
        entity.rotation = entity.rotation + self.rotateSpeed * dt
    elseif self.rotateSpeed < 0 then
        self.rotateSpeed = self.rotateSpeed + dt * Settings.cameraSlowDown
        if self.rotateSpeed > 0 then
            self.rotateSpeed = 0
        end

        entity.rotation = entity.rotation + self.rotateSpeed * dt
    end

    local wheel = mouse:getWheelY()
    self.zoomSpeed = self.zoomSpeed + wheel

    if self.zoomSpeed > 0 then
        self.zoomSpeed = self.zoomSpeed - dt * Settings.cameraZoomSlowDown
        if self.zoomSpeed < 0 then
            self.zoomSpeed = 0
        end
        self.zoom = self.zoom - self.zoomSpeed * dt
        self.camera.camera.extent = self.cameraExtent * self.zoom
    elseif self.zoomSpeed < 0 then
        self.zoomSpeed = self.zoomSpeed + dt * Settings.cameraZoomSlowDown
        if self.zoomSpeed > 0 then
            self.zoomSpeed = 0
        end
        self.zoom = self.zoom - self.zoomSpeed * dt
        self.camera.camera.extent = self.cameraExtent * self.zoom
    end

    if keyboard:isDown(81) then
        self.zoom = self.zoom + 1 * dt
        self.camera.camera.extent = self.cameraExtent * self.zoom
    elseif keyboard:isDown(82) then
        self.zoom = self.zoom - 1 * dt
        self.camera.camera.extent = self.cameraExtent * self.zoom
    end

    if self.zoom < Settings.cameraMinZoom then
        self.zoom = Settings.cameraMinZoom
        self.zoomSpeed = 0
        self.camera.camera.extent = self.cameraExtent * self.zoom
    end

    if self.zoom > Settings.cameraMaxZoom then
        self.zoom = Settings.cameraMaxZoom
        self.zoomSpeed = 0
        self.camera.camera.extent = self.cameraExtent * self.zoom
    end

    zoomFactor = 1 - zoomFactor

    entity.position.y = - Settings.worldRadius * Settings.cameraOffsetFactor * zoomFactor + self.zoom * Settings.cameraFactor
    entity.rotation = Util:getDeltaAngle(0, entity.rotation)
end

function ComponentWorld:remove()
end

