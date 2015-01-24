ComponentFarm = {}

function ComponentFarm:init()

	self.prodTime = 5
	self.peasants = 1

end

function ComponentFarm:insert()
end

function ComponentFarm:remove()
end

function ComponentFarm:update(dt)

	self.prodTime = self.prodTime - dt
	if self.prodTime <= 0 then
		if self.entity.built and self.peasants > 0 then
			print("produce food")
		end

		self.prodTime = 5
	end

end
