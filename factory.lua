require 'component_coolguy'

Factory = Factory or {}

local Settings = Settings

function Factory:init()
    local texture = gengine.graphics.texture.get("normal_left")
    local atlas = gengine.graphics.atlas.create("normal_left", texture, 4, 1)
    self.manLeft = gengine.graphics.animation.create(
        "normalLeft",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3 },
            framerate = 6,
            loop = true
        }
        )
end

function Factory:createCursor()
    local e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("cursor_arrow"),
            extent = vector2(64, 64),
            layer = 5,
            color = vector4(1,1,1,0.5)
        },
        "sprite"
        )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 32
        },
        "worldItem"
        )

    e:insert()

    return e
end

function Factory:createMan()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = self.manLeft,
            extent = vector2(32, 32),
            layer = 2
        },
        "sprite"
        )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 16
        },
        "worldItem"
        )

    e:addComponent(
        ComponentCoolGuy(),
        {
        },
        "guy"
        )

    return e
end

function Factory:createHouse()
    local e = gengine.entity.create()
    local texture = gengine.graphics.texture.get(Settings.Buildings.House.Textures.complete)

    e:addComponent(
        ComponentSprite(),
        {
            texture = texture,
            extent = vector2(128, 128),
            layer = 1
        }
    )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 64
        },
        "worldItem"
    )

    return e
end

function Factory:createFarm()

end