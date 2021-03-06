ComponentAreaOfOrder = {}

function ComponentAreaOfOrder:init()

	self.areaTimer = 3
	self.position = self.position or 0

end

function ComponentAreaOfOrder:update(dt)
	self.areaTimer = self.areaTimer - dt
	if self.areaTimer <= 0 then
	    self:destroy()
	end
end

function ComponentAreaOfOrder:insert()
end

function ComponentAreaOfOrder:remove()
end

function ComponentAreaOfOrder:destroy()
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

function ComponentAreaOfOrder:createArrows()
	self.right_arrow = nil
	self.right_arrow = Factory:createRightArrow(self.position, 5)
	self.left_arrow = nil
	self.left_arrow = Factory:createLeftArrow(self.position, 5)
end

function ComponentAreaOfOrder:increaseZone()
	self.left_arrow.worldItem:setPosition(math.rad(math.deg(self.left_arrow.worldItem.position) + 5))
	self.right_arrow.worldItem:setPosition(math.rad(math.deg(self.right_arrow.worldItem.position) - 5))
end

function ComponentAreaOfOrder:apply()
    local p = self.entity.worldItem.position
    local delta = math.abs(
        Util:getDeltaAngle(
            self.left_arrow.worldItem.position,
            p
            )
        )
    for k, v in ipairs(Village.guys) do
        local diff = math.abs(v.worldItem.position - p)
        if math.abs(v.worldItem.position - p ) < delta then
            v.guy:orderMoveTo(p)
            v:onDead()
        end
    end
end