Factory = Factory or {}

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

function Factory:createMan()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = self.manLeft,
            extent = vector2(32, 32),
            layer = 1
        },
        "spaceShipAnimation"
        )

    e:addComponent(
        ComponentWorldItem(),
        {
        },
        "worldItem"
        )

    return e
end