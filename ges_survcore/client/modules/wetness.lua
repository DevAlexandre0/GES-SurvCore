-- wetness tracking
GES_Wetness = { value = 0 }

local tickMs = 2000

function GES_Wetness.Init()
    tickMs = Config.Wetness.TickMs or 2000
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if IsPedSwimming(ped) then
                GES_Wetness.Add(2.0)
            else
                local rain = GetRainLevel()
                local indoors = TempState and TempState.isIndoors
                if rain > 0.1 and not indoors then
                    GES_Wetness.Add(rain * 1.5 + (GES_Blizzard and GES_Blizzard.intensity or 0))
                end
            end
            local coords = GetEntityCoords(ped)
            local dry = 0.5
            if Config.Features.Heat and GES_Heat then
                local near, power = GES_Heat.GetAt(coords)
                if near then dry = dry + power end
            end
            if TempState and TempState.windSpeed then
                dry = dry + TempState.windSpeed * 0.05
            end
            GES_Wetness.Add(-dry)
            TriggerEvent(CONST.Events.WetTick, GES_Wetness.value)
            Wait(tickMs)
        end
    end)
end

function GES_Wetness.Add(delta)
    GES_Wetness.value = Util.Clamp((GES_Wetness.value or 0) + delta, 0.0, 100.0)
end

function GES_Wetness.Get()
    return GES_Wetness.value
end
