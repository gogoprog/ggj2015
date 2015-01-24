UserAction = UserAction or {}

gengine.stateMachine(UserAction)

function UserAction:init()
    self.currentEntity = nil
end

function UserAction:update(dt)
    self:updateState(dt)
end

function UserAction.onStateEnter:idle()
end

function UserAction.onStateEnter:placingBuilding()

end

function UserAction.onStateUpdate:placingBuilding(dt)

end

function UserAction:onClick(r)
    if self.state == "placingBuilding" then
        self.currentEntity.worldItem:setPosition(r)
        self.currentEntity:insert()
        self.currentEntity = nil
        self:changeState("idle")
    end
end

function UserAction:placeBuilding(e)
    self.currentEntity = e
    self:changeState("placingBuilding")
end