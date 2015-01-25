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
    self.enemyFort = e

    e = Factory:createHome()
    e.worldItem:setPosition(math.pi * 0.5)
    e.building:addGauge()
    e.life.hp = e.life.maxHp
    e:insert()

    for i = 0, 3, 1 do
        e = Factory:createMan()
        e.worldItem:setPosition(math.pi * 0.5)
        e:insert()
    end

    local t = Factory:createTower(true)
    t.worldItem.position = 1.10
    t.building:addGauge()
    t.life.hp = e.life.maxHp
    t:insert()

    t = Factory:createTower(true)
    t.worldItem.position = 2.0
    t.building:addGauge()
    t.life.hp = e.life.maxHp
    t:insert()

end

function Game:getClosestEnemy(pos)
    local best = 10
    local r
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
        local e = Factory:createEnemy()
        e.worldItem:setPosition(self.cursor.worldItem.position)
        e:insert()
        table.insert(self.enemies, e)
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

function Game:winGame()
    Hud:winGame()
    self:changeState("gameOver")
end

function Game:loseGame()
    Hud:loseGame()
    self:changeState("gameOver")
end

function Game.onStateEnter:gameOver()
    Hud:showMainMenu()
end

function Game.onStateUpdate:gameOver(dt)
    if gengine.input.keyboard:isJustDown(44) then
        self:changeState("menu")
    end
end

function Game.onStateEnter:showWDWDNMenu()
    Hud:changeState("showWDWDNMenu")
    self:changeState("pending")
end

function Game.onStateUpdate:showWDWDNMenu()
end

function Game.onStateExit:showWDWDNMenu()
end