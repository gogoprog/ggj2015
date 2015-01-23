ComponentWorldItem = {}

local Settings = Settings

local mpi = math.pi
local mcos = math.cos
local msin = math.sin

function ComponentWorldItem:init()
    self.world = Game.world
    self.position = 0
end

function ComponentWorldItem:insert()
end

function ComponentWorldItem:update(dt)
    self.position = self.position + dt

    local x, y
    local cpos = self.position + self.world.rotation

    x = mcos(cpos) * Settings.worldRadius
    y = msin(cpos) * Settings.worldRadius

    self.entity.position = self.world.position + vector2(x, y)
    self.entity.rotation = cpos - mpi * 0.5
end

function ComponentWorldItem:remove()
end

