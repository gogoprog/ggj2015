require 'settings'
require 'component_world'
require 'component_world_item'
require 'hud'

Game = Game or {}

function Game:init()
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

    self.cursor = gengine.entity.create()
    self.cursor:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("cursor_arrow"),
            extent = vector2(64, 64),
            layer = 2
        },
        "sprite"
        )
    self.cursor:addComponent(
        ComponentWorldItem(),
        {
        },
        "worldItem"
        )

    self.cursor:insert()

    self.world:insert()
end

function Game:start()

end

function Game:update(dt)
    
end

