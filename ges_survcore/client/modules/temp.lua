-- temperature port
GES_Temp = { state = { temp = 0, feelsLike = 0, tier = 0, isIndoors = false }, mode = 'internal', externalRes = nil }

local tickMs = 2000

local function computeTier(feel)
    local tiers = Config.Temperature.Tiers or { {-15,3}, {-5,2}, {5,1} }
    local t = 0
    for _,v in ipairs(tiers) do
        if feel <= v[1] then t = v[2] end
    end
    return t
end

local function internal()
    local temp = 0
    local weather = GetPrevWeatherTypeHashName()
    if weather == GetHashKey('XMAS') or weather == GetHashKey('SNOW') then temp = temp - 5 end
    local hour = GetClockHours()
    if hour < 6 or hour > 20 then temp = temp - 5 end
    local wind = GetWindSpeed()
    local feels = temp - wind * 0.2 - (GES_Blizzard and GES_Blizzard.intensity or 0) * 5.0
    GES_Temp.state = {
        temp = temp,
        feelsLike = feels,
        windChill = feels - temp,
        humidity = 50,
        windSpeed = wind,
        isIndoors = false
    }
end

local function external()
    local ok, data = pcall(function()
        return exports[GES_Temp.externalRes]:getTemperatureData()
    end)
    if ok and type(data) == 'table' then
        GES_Temp.state = {
            temp = data.temperature or 0,
            feelsLike = data.feelsLike or data.perceived or data.temperature or 0,
            windChill = data.windChill,
            humidity = data.humidity,
            windSpeed = data.windSpeed,
            isIndoors = data.isIndoors,
            biome = data.biome
        }
    else
        Util.Log('WARN', 'Temperature external failed, switching to internal')
        GES_Temp.mode = 'internal'
        internal()
    end
end

local function detectExternal()
    for _,name in ipairs(Config.Temperature.ExternalResources or {}) do
        if Util.TryResource(name) then
            GES_Temp.externalRes = name
            break
        end
    end
    if Config.Temperature.Mode == 'external' or (Config.Temperature.Mode == 'auto' and GES_Temp.externalRes) then
        if GES_Temp.externalRes then
            GES_Temp.mode = 'external'
        else
            if Config.Core.Strict and not Config.Core.AllowFallback then
                Util.Log('ERROR', 'External temperature resource not found')
                StopResource(GetCurrentResourceName())
                return false
            else
                Util.Log('WARN', 'External temperature resource not found, using internal')
            end
        end
    end
    return true
end

function GES_Temp.Init()
    tickMs = Config.Temperature.TickMs or 2000
    if not detectExternal() then return end
    CreateThread(function()
        while true do
            if GES_Temp.mode == 'external' then external() else internal() end
            GES_Temp.state.tier = computeTier(GES_Temp.state.feelsLike or 0)
            TempState = GES_Temp.state
            TriggerEvent(CONST.Events.TempTick, GES_Temp.state)
            Wait(tickMs)
        end
    end)
end

function GES_Temp.GetTick()
    return GES_Temp.state
end

function GES_Temp.Get()
    return GES_Temp.state.feelsLike
end
