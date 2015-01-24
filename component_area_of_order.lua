ComponentAreaOfOrder = {}

function ComponentAreaOfOrder:init()
	self.areaTimer = 3
end

function ComponentAreaOfOrder:update(dt)
	self.areaTimer = self.areaTimer - dt
	if self.areaTimer <= 0 then
		self.entity:remove()
		gengine.entity.destroy(self.entity)
	end
end

function ComponentAreaOfOrder:insert()
end

function ComponentAreaOfOrder:destroy()
	
end