Settings = Settings or {
    mapSize = 2048,
    worldRadius = 690,
    cameraFactor = -100,
    cameraSlowDown = 10,
    cameraRotateFactor = 0.5,
    clickableZone = 100,
    Buildings = {
        House = {
            Textures = {
                beginConstruction = "town_hall",
                halfConstruction = "",
                complete = "town_hall"
            },
            constructionRate = 1,
            maxWorkers = 10,
            currentWorkers = 0,
            baseProductionRate = 1.2
        }
    }
}