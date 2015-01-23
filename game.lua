require 'component_world'

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
            extent = vector2(1024, 1024)
        },
        "sprite"
        )
   self.world:addComponent(
        ComponentWorld(),
        {
        },
        "world"
        )

    self.world:insert()
end

function Game:start()

end

function Game:update(dt)
    
end

