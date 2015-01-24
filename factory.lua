require 'component_coolguy'
require 'component_building'
require 'component_house'
require 'component_enemy'
require 'component_farm'
require 'component_area_of_order'
require 'component_enemy_fort'
require 'component_home'

Factory = Factory or {}

local Settings = Settings

function Factory:init()
    local texture, atlas

    texture = gengine.graphics.texture.get("normal_left")
    atlas = gengine.graphics.atlas.create("normal_left", texture, 4, 1)
    gengine.graphics.animation.create(
        "normalLeft",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3 },
            framerate = 6,
            loop = true
        }
        )

    texture = gengine.graphics.texture.get("builder_left")
    atlas = gengine.graphics.atlas.create("builder_left", texture, 4, 1)
    gengine.graphics.animation.create(
        "builderLeft",
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
        "warriorLeft",
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

function Factory:areaClicked()

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

    e:addComponent(
        ComponentAreaOfOrder(),
        {

        },
        "areaOfOrder"
        )

    e:insert()

    return e

end

function Factory:createMan()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = gengine.graphics.animation.get("normalLeft"),
            extent = vector2(64, 64),
            layer = 2
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

    e:addComponent(
        ComponentCoolGuy(),
        {
        },
        "guy"
        )

    return e
end

function Factory:createEnemy()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = gengine.graphics.animation.get("warriorLeft"),
            extent = vector2(64, 64),
            layer = 2,
            color = vector4(1, 0.0, 0.0, 1)
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

    e:addComponent(
        ComponentEnemy(),
        {
        },
        "enemy"
        )

    return e
end

function Factory:createHouse()
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

    return e
end

function Factory:createFarm()
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
        "enemyFort"
    )

    return e
end
