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
    hungryFactor = 0.5,
    Buildings = {
        House = {
            Textures = {
                beginConstruction = "house",
                halfConstruction = "house",
                complete = "house"
            },
            constructionRate = 0.8,
            maxWorkers = 10,
            currentWorkers = 0,
            baseProductionRate = 1.2,
            areaSize = 3,
            hp = 100
        },
        Farm = {
            Textures = {
                beginConstruction = "farm",
                halfConstruction = "farm",
                complete = "farm"
            },
            constructionRate = 0.8,
            maxWorkers = 10,
            currentWorkers = 0,
            baseProductionRate = 1.2,
            areaSize = 0.1,
            hp = 100
        }
    }
}