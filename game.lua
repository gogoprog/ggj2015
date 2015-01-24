require 'settings'
require 'component_world'
require 'component_world_item'
require 'hud'
require 'factory'
require 'village'

Game = Game or {}

gengine.stateMachine(Game)

function Game:init()
    Factory:init()

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
end

function Game:start()
    Village:reset()
end

function Game:update(dt)
    if gengine.input.keyboard:isJustUp(4) then
        self:changeState("showWDWDNMenu")
    end

    if gengine.input.keyboard:isJustDown(44) then
        local e = Factory:createMan()
        e:insert()
        e.worldItem:setPosition(math.random() * math.pi)

        local e = Factory:createEnemy()
        e:insert()
        e.worldItem:setPosition(math.random() * -math.pi)

        local house = Factory:createHouse()
        house:insert()
        house.worldItem:setPosition(math.random() * math.pi)
    end

    self:updateState(dt)
end

function Game:onClick(r)
    
end 

function Game.onStateEnter:gameplay()

end

function Game.onStateUpdate:gameplay()

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

function Game.onStateEnter:placeBuilding()
end

function Game.onStateUpdate:placeBuilding(dt)
end

function Game:placeBuilding(e)
    self.buildingToPlace = e
    self:changeState("placeBuilding")
end