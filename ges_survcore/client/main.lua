-- client entry
local resource = GetCurrentResourceName()

Framework = Framework or {}
Framework.name, Framework.obj = Util.DetectFramework()
Ox = {
    lib = Util.GetOxResource('ox_lib'),
    inventory = Util.GetOxResource('ox_inventory'),
    mysql = Util.GetOxResource('oxmysql')
}

TempState = TempState or {}

local function validate()
    if type(Config) ~= 'table' then
        Util.Log('ERROR', 'config.lua missing or invalid')
        return false
    end
    if type(Config.Core) ~= 'table' or type(Config.Core.Strict) ~= 'boolean' then
        Util.Log('ERROR', 'Config.Core.Strict missing')
        return false
    end
    if type(Config.Features) ~= 'table' then
        Util.Log('ERROR', 'Config.Features missing')
        return false
    end
    return true
end

if not validate() then
    Util.Log('ERROR', 'Initialization failed')
    return
end

GES_Temp.Init()
if Config.Features.Heat then GES_Heat.Init() end
if Config.Features.Wetness then GES_Wetness.Init() end
if Config.Features.Blizzard then GES_Blizzard.Init() end

