Settings = Settings or {
    mapSize = 2048,
    worldRadius = 690,
    cameraFactor = -100,
    cameraOffsetFactor = 1,
    cameraSlowDown = 10,
    cameraZoomSlowDown = 10,
    cameraRotateFactor = 0.4,
    cameraMaxZoom = 3,
    cameraMinZoom = 0.5,
    clickableZone = 2000,
    hungryFactor = 0.05,
    attackDistance = 0.02,
    Buildings = {
        House = {
            Textures = {
                beginConstruction = "works",
                halfConstruction = "works",
                complete = "house"
            },
            constructionRate = 0.2,
            maxWorkers = 10,
            currentWorkers = 0,
            baseProductionRate = 1.2,
            productionTimer = 5,
            areaSize = 0.06,
            hp = 100
        },
        Farm = {
            Textures = {
                beginConstruction = "works",
                halfConstruction = "works",
                complete = "farm"
            },
            constructionRate = 0.2,
            maxWorkers = 3,
            currentWorkers = 0,
            baseProductionRate = 1.2,
            productionTimer = 5,
            areaSize = 0.06,
            hp = 100
        },
        Tower = {
            Textures = {
                beginConstruction = "works",
                halfConstruction = "works",
                complete = "tower"
            },

            constructionRate = 0.3,

            maxWorkers = 10,
            areaSize = 0.1,
            hp = 100
        },
        Home = {
            Textures = {
                beginConstruction = "home",
                halfConstruction = "home",
                complete = "home"
            },
            areaSize = 0.075,
            maxWorkers = 0,
            hp = 100
        }
    },
    Enemy = {
        damage = {1, 5},
        attackInterval = 0.5,
        speed = 5,
        hp = 200
    },
    Guys = {
        build = {
            damage = {1, 5},
            attackInterval = 0.5,
            hitFactor = 1,
            moveAnimation = "builder_left",
            buildAnimation = "builder_building_left"
        },
        fight = {
            damage = {5, 10},
            attackInterval = 0.5,
            hitFactor = 0.5,
            moveAnimation = "warrior_left",
            buildAnimation = "warrior_building_left"
        },
        produce = {
            damage = {1, 2},
            attackInterval = 0.5,
            hitFactor = 1,
            moveAnimation = "farmer_left",
            buildAnimation = "farmer_building_left"
        },
        speed = 10
    }
}