-- blizzard controller
GES_Blizzard = { active = false, intensity = 0.0, extWeather = nil }

function GES_Blizzard.Init()
    for _,name in ipairs(Config.Blizzard.ExternalWeather or {}) do
        if Util.TryResource(name) then
            GES_Blizzard.extWeather = name
            break
        end
    end
    RegisterNetEvent(CONST.Events.BlizzardStart)
    AddEventHandler(CONST.Events.BlizzardStart, function(intensity, duration)
        GES_Blizzard.Start(intensity, duration)
    end)
end

function GES_Blizzard.Start(intensity, duration)
    intensity = Util.Clamp(intensity or 1.0, 0.0, 1.0)
    duration = duration or 60
    if GES_Blizzard.extWeather then
        local ok, err = pcall(function()
            exports[GES_Blizzard.extWeather]:setBlizzard(intensity, duration)
        end)
        if not ok then
            Util.Log('WARN', 'External weather blizzard call failed: ' .. tostring(err))
        end
    else
        SetWeatherTypeOverTime('XMAS', 1.0)
        SetWindSpeed(intensity * 10.0)
        SetTimecycleModifier('snowblind')
        GES_Blizzard.active = true
        GES_Blizzard.intensity = intensity
        CreateThread(function()
            Wait(duration * 1000)
            ClearTimecycleModifier()
            SetWindSpeed(0.0)
            GES_Blizzard.active = false
            GES_Blizzard.intensity = 0.0
        end)
    end
end
