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
    hungryFactor = 0.01,
    attackDistance = 0.02,
    startingGold = 10,
    startingFood = 5,
    whatDoWeDoKnowCredits = 3,
    whatDoWeDoKnowCreditsPrice = 5,
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
            areaSize = 0.05,
            hp = 100,
            price = 5
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
            areaSize = 0.05,
            hp = 100,
            price = 10
        },
        Tower = {
            Textures = {
                beginConstruction = "works",
                halfConstruction = "works",
                complete = "tower"
            },

            constructionRate = 0.3,
            maxWorkers = 10,
            areaSize = 0.05,
            hp = 100,
	        price = 15,
            attackInterval = 2,
            damage = {5, 10},
            attackArea = 0.25,
            price = 15
        },
        Home = {
            Textures = {
                beginConstruction = "home",
                halfConstruction = "home",
                complete = "home"
            },
            areaSize = 0.05,
            maxWorkers = 0,
            hp = 100,
            goldGeneration = 1,
            goldGenerationRate = 5
        },
        EnemyFort = {
            hp = 100,
            areaSize = 0.06
        }
    },
    Enemy = {
        damage = {1, 5},
        attackInterval = 0.5,
        speed = 4,
        hp = 200
    },
    Guys = {
        build = {
            damage = {1, 5},
            attackInterval = 1,
            hitFactor = 1,
            buildFactor = 1,
            productionFactor = 1,
            moveAnimation = "farmer_left",
            buildAnimation = "farmer_building_left",
            fightAnimation = "farmer_fight_left"
        },
        fight = {
            damage = {5, 10},
            attackInterval = 1,
            hitFactor = 0.5,
            buildFactor = 0.5,
            productionFactor = 0.5,
            moveAnimation = "warrior_left",
            buildAnimation = "warrior_building_left",
            fightAnimation = "warrior_fight_left"
        },

        speed = 4;
    }
}