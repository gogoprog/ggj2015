AreaOfOrder = AreaOfOrder or {}

function AreaOfOrder:init()
	print("YABABABA")
end

function AreaOfOrder:create()
	print("CREATED")
	local e = gengine.entity.create()
    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("effect_area"),
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