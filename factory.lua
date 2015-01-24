require 'component_coolguy'
require 'component_building'
require 'component_house'
require 'component_enemy'
require 'component_farm'
require 'component_area_of_order'
require 'component_enemy_fort'
require 'component_home'
require 'component_life'

Factory = Factory or {}

local Settings = Settings

function Factory:init()
    local texture, atlas

    texture = gengine.graphics.texture.get("builder_left")
    atlas = gengine.graphics.atlas.create("builder_left", texture, 4, 1)
    gengine.graphics.animation.create(
        "builder_left",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3 },
            framerate = 6,
            loop = true
        }
        )

    texture = gengine.graphics.texture.get("farmer_left")
    atlas = gengine.graphics.atlas.create("farmer_left", texture, 4, 1)
    gengine.graphics.animation.create(
        "farmer_left",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3 },
            framerate = 6,
            loop = true
        }
        )

    texture = gengine.graphics.texture.get("warrior_left")
    atlas = gengine.graphics.atlas.create("warrior_left", texture, 4, 1)
    gengine.graphics.animation.create(
        "warrior_left",
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

function Factory:areaClicked(r)

    local e = gengine.entity.create()
    -- e:addComponent(
    --     ComponentSprite(),
    --     {
    --         texture = gengine.graphics.texture.get("effect_area"),
    --         extent = vector2(64, 64),
    --         layer = 5,
    --         color = vector4(1,1,1,0.5)
    --     },
    --     "sprite"
    --     )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 32
        },
        "worldItem"
        )

    e:addComponent(
        ComponentAreaOfOrder(),
        {
            position = r
        },
        "areaOfOrder"
        )

    e:insert()
    e.areaOfOrder:createArrows()

    return e

end

function Factory:createRightArrow(r, offset)
    local right_arrow = gengine.entity.create()
    right_arrow:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("rally_area_right"),
            extent = vector2(64, 64),
            layer = 5,
            color = vector4(1,1,1,0.5)
        },
        "sprite"
        )

    right_arrow:addComponent(
        ComponentWorldItem(),
        {
            offset = 32
        },
        "worldItem"
        )

    right_arrow:insert()
    right_arrow.worldItem.position = math.rad(math.deg(r) - offset)

    return right_arrow
end

function Factory:createLeftArrow(r, offset)

    local left_arrow = gengine.entity.create()
    left_arrow:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("rally_area_left"),
            extent = vector2(64, 64),
            layer = 5,
            color = vector4(1,1,1,0.5)
        },
        "sprite"
        )

    left_arrow:addComponent(
        ComponentWorldItem(),
        {
            offset = 32
        },
        "worldItem"
        )

    left_arrow:insert()
    left_arrow.worldItem.position = math.rad(math.deg(r) + offset)

    return left_arrow

end 

function Factory:createMan()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            extent = vector2(64, 64),
            layer = 2
        },
        "sprite"
        )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 32,
            speed = Settings.Guys.speed
        },
        "worldItem"
        )

    e:addComponent(
        ComponentCoolGuy(),
        {
        },
        "guy"
        )

    e:addComponent(
        ComponentLife(),
        {
        },
        "life"
        )

    return e
end

function Factory:createEnemy()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = gengine.graphics.animation.get("warrior_left"),
            extent = vector2(64, 64),
            layer = 2,
            color = vector4(1, 0.0, 0.0, 1)
        },
        "sprite"
        )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 32,
            speed = Settings.Enemy.speed
        },
        "worldItem"
        )

    e:addComponent(
        ComponentEnemy(),
        {
            gauge = self:createGauge()
        },
        "gauge"
        )

    e:addComponent(
        ComponentLife(),
        {
            hp = Settings.Enemy.hp
        },
        "life"
        )

    return e
end

function Factory:createGauge()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("gauge_front"),
            extent = vector2(50, 8),
            layer = 5,
            color = vector4(0,1,0,1)
        },
        "sprite"
    )

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("gauge_back"),
            extent = vector2(50, 8),
            layer = 4,
            color = vector4(1,0,0,1)
        },
        "sprite_back"
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

function Factory:createHouse()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            extent = vector2(96, 96),
            layer = 1
        },
        "sprite"
    )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 48
        },
        "worldItem"
    )

    e:addComponent(
        ComponentBuilding(),
        {
            params = Settings.Buildings.House
        },
        "building"
    )

    e:addComponent(
        ComponentHouse(),
        {
        },
        "house"
    )

    e:addComponent(
        ComponentLife(),
        {
            hp = Settings.Buildings.House.hp
        },
        "life"
        )

    return e
end

function Factory:createTower()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            extent = vector2(128, 128),
            layer = 1
        },
        "sprite"
    )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 64
        },
        "worldItem"
    )

    e:addComponent(
        ComponentBuilding(),
        {
            params = Settings.Buildings.Tower
        },
        "building"
    )

    e:addComponent(
        ComponentHouse(),
        {

        },
        "tower"
    )

    e:addComponent(
        ComponentLife(),
        {
            hp = Settings.Buildings.Tower.hp
        },
        "life"
    )

    return e
end

function Factory:createFarm()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            extent = vector2(96, 96),
            layer = 1
        },
        "sprite"
    )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 48
        },
        "worldItem"
    )

    e:addComponent(
        ComponentBuilding(),
        {
            params = Settings.Buildings.Farm
        },
        "building"
    )

    e:addComponent(
        ComponentFarm(),
        {

        },
        "farm"
    )

    e:addComponent(
        ComponentLife(),
        {
            hp = Settings.Buildings.Farm.hp
        },
        "life"
    )

    return e
end

function Factory:createEnemyFort()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("town_hall"),
            extent = vector2(128, 128),
            layer = 1
        },
        "sprite"
    )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 64
        },
        "worldItem"
    )

    e:addComponent(
        ComponentEnemyFort(),
        {
        },
        "enemyFort"
    )

    return e
end

function Factory:createHome()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("home"),
            extent = vector2(192, 192),
            layer = 1
        },
        "sprite"
    )

    e:addComponent(
        ComponentWorldItem(),
        {
            offset = 96
        },
        "worldItem"
    )

    e:addComponent(
        ComponentBuilding(),
        {
            params = Settings.Buildings.Home
        },
        "building"
    )

    e:addComponent(
        ComponentHome(),
        {
        },
        "home"
    )

    return e
end
