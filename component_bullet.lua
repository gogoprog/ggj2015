ComponentBullet = {}


local Settings = Settings

function ComponentBullet:init()
    self.time = 0
    self.duration = 0.5
end

function ComponentBullet:insert()
    self.start = self.entity.worldItem.position
end

function ComponentBullet:remove()
end

function ComponentBullet:update(dt)
    local wi = self.entity.worldItem

    self.time = self.time + dt
    wi.position = self.start + (self.target - self.start) * (self.time/self.duration)

    wi.offset = 100 - self.time * self.time * 640

    if self.time > self.duration or wi.offset < 0 then
        self.entity:remove()
        gengine.entity.destroy(self.entity)
    end
end
