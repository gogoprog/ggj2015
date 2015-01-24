ComponentHouse = {}

function ComponentHouse:init()

end

function ComponentHouse:update(dt)
	if self.entity.built then
		Village:upMaxPop()
		self.entity.built = false
	end
end

function ComponentHouse:insert()
end

function ComponentHouse:remove()
end