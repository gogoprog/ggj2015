UserAction = UserAction or {}

gengine.stateMachine(UserAction)

function UserAction:init()
    self.currentEntity = nil
    self:changeState("idle")
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
        local b = Village:getClosestBuilding(r)
        if b then
            if math.abs(b.worldItem.position - self.currentEntity.worldItem.position)
                    > (self.currentEntity.building.params.areaSize + b.building.params.areaSize) then
                self.currentEntity.building:changeState("inConstruction")
                self:changeState("idle")
            end
        else
            self.currentEntity.building:changeState("inConstruction")
            self:changeState("idle")
        end
    else
        area = nil
        area = Factory:areaClicked()
        area.worldItem.position = r
    end
end

function UserAction:placeBuilding(e)
    if self.state == "idle" then
        self.currentEntity = e
        self.currentEntity:insert()
        self:changeState("placingBuilding")
    end
end