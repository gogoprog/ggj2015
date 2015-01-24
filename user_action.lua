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
    if not self:canPlaceBuilding(Game.cursor.worldItem.position) then
        self.currentEntity.sprite.color = vector4(1, 0, 0, 0.5)
    else
        self.currentEntity.sprite.color = vector4(1, 1, 1, 0.5)
    end
end

function UserAction:onClick(r)
    if self.state == "placingBuilding" then
        if self:canPlaceBuilding(r) then
            self.currentEntity.building:changeState("inConstruction")
            self:changeState("idle")
        end
    else
        local click_angle = math.deg(r)
        for k, v in ipairs(Game.orderAreaTable) do

            local left_angle = math.deg(v.worldItem.position)-5
            local right_angle = math.deg(v.worldItem.position)+5

            if click_angle >= left_angle and click_angle <= right_angle then
                v.areaOfOrder:increaseZone()
                v.areaOfOrder.areaTimer = 3
                v.areaOfOrder:apply()
                return
            end
        end
        for k, v in ipairs(Game.orderAreaTable) do
             v.areaOfOrder:destroy()
        end
        local area = nil
        area = Factory:areaClicked(r)
        area.worldItem.position = r
        table.insert(Game.orderAreaTable, area)

        area.areaOfOrder:apply()
    end
end

function UserAction:canPlaceBuilding(r)
    local b = Village:getClosestBuilding(r)
    if b then
        if math.abs(b.worldItem.position - self.currentEntity.worldItem.position)
                > (self.currentEntity.building.params.areaSize + b.building.params.areaSize) then
            return true
        end
    else
        return true
    end

    return false
end

function UserAction:placeBuilding(e)
    if self.state == "idle" then
        self.currentEntity = e
        self.currentEntity:insert()
        self:changeState("placingBuilding")
    elseif self.state == "placingBuilding" then
        self.currentEntity:remove()
        gengine.entity.destroy(self.currentEntity)
        self.state = "idle"
        self:placeBuilding(e)
    end
end