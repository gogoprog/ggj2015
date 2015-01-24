Village = {}

gengine.stateMachine(Village)

function Village:reset()
    self.constructingBuildings = {}
    self.farms = {}
    self.towers = {}
    self.houses = {}
    self.guys = {}
    self.home = nil
    self:changeState("build")
end

function Village:addGuy(e)
    table.insert(self.guys, e)

    if self.state == "build" then
        e.sprite.animation = gengine.graphics.animation.get("builderLeft")
    end
end

function Village:removeGuy(e)
    for k, v in ipairs(self.guys) do
        if v == e then
            table.remove(self.guys, k)
            break
        end
    end
end

function Village:getGuysCount()
    return #self.guys
end

function Village.onStateEnter:build()
    for k, v in ipairs(self.guys) do
        v.sprite.animation = gengine.graphics.animation.get("builderLeft")
    end
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

