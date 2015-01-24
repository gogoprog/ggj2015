ComponentAreaOfOrder = {}

function ComponentAreaOfOrder:init()

	self.areaTimer = 3
	self.position = self.position or 0

end

function ComponentAreaOfOrder:update(dt)
	self.areaTimer = self.areaTimer - dt
	if self.areaTimer <= 0 then
		for k, v in ipairs(Game.orderAreaTable) do
	        if v == self.entity then
	            table.remove(Game.orderAreaTable, k)
	            break
	        end
	    end
	    self.left_arrow:remove()
	    gengine.entity.destroy(self.left_arrow)
	    self.right_arrow:remove()
	    gengine.entity.destroy(self.right_arrow)
		self.entity:remove()
		gengine.entity.destroy(self.entity)
	end
end

function ComponentAreaOfOrder:insert()
end

function ComponentAreaOfOrder:remove()
end

function ComponentAreaOfOrder:destroy()
end

function ComponentAreaOfOrder:createArrows()
	self.right_arrow = nil
	self.right_arrow = Factory:createRightArrow(self.position, 5)
	self.left_arrow = nil
	self.left_arrow = Factory:createLeftArrow(self.position, 5)
end

function ComponentAreaOfOrder:increaseZone()
	self.left_arrow.worldItem.position = math.rad(math.deg(self.left_arrow.worldItem.position) + 5)
	self.right_arrow.worldItem.position = math.rad(math.deg(self.right_arrow.worldItem.position) - 5)
end