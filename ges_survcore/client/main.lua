-- client entry
local resource = GetCurrentResourceName()

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
    StopResource(resource)
    return
end

GES_Temp.Init()
if Config.Features.Heat then GES_Heat.Init() end
if Config.Features.Wetness then GES_Wetness.Init() end
if Config.Features.Blizzard then GES_Blizzard.Init() end
if Config.Features.HUDDemo then GES_HUD.Init() end
