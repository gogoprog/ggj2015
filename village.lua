Village = {}

gengine.stateMachine(Village)

function Village:reset()
    self.constructingBuildings = {}
    self.farms = {}
    self.towers = {}
    self.houses = {}
    self.home = nil
    self:changeState("build")
end

function Village.onStateEnter:build()

end

function Village.onStateUpdate:build(dt)

end

function Village.onStateExit:build()

end

function Village.onStateEnter:fight()

end

function Village.onStateUpdate:fight(dt)

end

function Village.onStateExit:fight()

end

function Village.onStateEnter:produce()

end

function Village.onStateUpdate:produce(dt)

end

function Village.onStateExit:produce()

end

