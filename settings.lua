Settings = Settings or {
    mapSize = 2048,
    worldRadius = 690,
    cameraFactor = -100,
    cameraOffsetFactor = 1,
    cameraSlowDown = 10,
    cameraRotateFactor = 0.5,
    clickableZone = 100,
    Buildings = {
        House = {
            Textures = {
                beginConstruction = "house",
                halfConstruction = "",
                complete = "house"
            },
            constructionRate = 1,
            maxWorkers = 10,
            currentWorkers = 0,
            baseProductionRate = 1.2
        }
    }
}