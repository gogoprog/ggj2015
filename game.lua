require 'util'
require 'settings'
require 'component_world'
require 'component_world_item'
require 'hud'
require 'factory'
require 'village'
require 'user_action'

Game = Game or {}

gengine.stateMachine(Game)

function Game:init()
    Factory:init()

    self.orderAreaTable = {}

    self.camera = gengine.entity.create()
    self.camera:addComponent(
        ComponentCamera(),
        {
            extent = vector2(1024 * 2, 600 * 2)
        },
        "camera"
        )
    self.camera:insert()

    self.world = gengine.entity.create()
    self.world:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("planet"),
            extent = vector2(Settings.mapSize, Settings.mapSize)
        },
        "sprite"
        )
    self.world:addComponent(
        ComponentWorld(),
        {
        },
        "world"
        )

    self.cursor = Factory:createCursor()

    self.world:insert()

    self.cursor.worldItem.position = 1.5
    self.buildingToPlace = nil

    Hud:init()
    UserAction:init()
    self:changeState("gameplay")
end

function Game:start()
    self.enemies = {}
    Village:reset()
    local e = Factory:createEnemyFort()
    e.worldItem:setPosition(-math.pi * 0.5)
    e:insert()

    e = Factory:createHome()
    e.worldItem:setPosition(math.pi * 0.5)
    e:insert()

    for i = 0, 3, 1 do
        e = Factory:createMan()
        e.worldItem:setPosition(math.pi * 0.5)
        e:insert()
    end

    local t = Factory:createTower(true)
    t.worldItem.position = 1.10
    t:insert()
    t.building:changeState("idle")

    t = Factory:createTower(true)
    t.worldItem.position = 2.0
    t:insert()
    t.building:changeState("idle")

end

function Game:getClosestEnemy(pos)
    local best = 10, r
    for k, v in ipairs(self.enemies) do
        local delta = math.abs( Util:getDeltaAngle(pos, v.worldItem.position) )

        if delta < best then
            best = delta
            r = v
        end
    end

    return r, best
end

function Game:update(dt)
    if gengine.input.keyboard:isJustUp(4) then
        print(self.cursor.worldItem.position)
    end

    if gengine.input.keyboard:isJustDown(44) then
        local e = Factory:createMan()
        e.worldItem:setPosition(self.cursor.worldItem.position)
        e:insert()
        self.timeLeft = 30
    end

    self:updateState(dt)
    UserAction:update(dt)
end

function Game:onClick(r)

    if self.skipMouse then
        return
    end

    UserAction:onClick(r)

end 

function Game.onStateEnter:gameplay()

end

function Game.onStateUpdate:gameplay(dt)

end

function Game.onStateExit:gameplay()

end

function Game.onStateEnter:showWDWDNMenu()
    Hud:changeState("showWDWDNMenu")
    self:changeState("pending")
end

function Game.onStateUpdate:showWDWDNMenu()

end

function Game.onStateExit:showWDWDNMenu()

end

function Game.onStateEnter:pending()
end

function Game.onStateUpdate:pending()

end

function Game.onStateExit:pending()

end