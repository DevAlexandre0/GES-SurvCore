-- Copy this file to config.lua and adjust values
Config = {
    Core = {
        Strict = true,
        AllowFallback = false
    },
    Temperature = {
        Mode = 'auto',
        TickMs = 2000,
        Tiers = {
            {-15,3},
            {-5,2},
            {5,1}
        },
        ExternalResources = { 'GES-Temperature', 'ges_temperature' }
    },
    Wetness = { TickMs = 2000 },
    Features = {
        Wetness = true,
        Heat = true,
        Blizzard = true,
        HUDDemo = true
    },
    Blizzard = {
        ExternalWeather = { 'renewed-weathersync' }
    }
}
