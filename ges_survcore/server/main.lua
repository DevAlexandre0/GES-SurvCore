-- server entry
local resource = GetCurrentResourceName()

Framework = Framework or {}
Framework.name, Framework.obj = Util.DetectFramework()
Ox = {
    lib = Util.GetOxResource('ox_lib'),
    inventory = Util.GetOxResource('ox_inventory'),
    mysql = Util.GetOxResource('oxmysql')
}

local function validate()
    if type(Config) ~= 'table' then
        print('^1 ERROR ^7config.lua missing or invalid')
        return false
    end
    if type(Config.Core) ~= 'table' or type(Config.Core.Strict) ~= 'boolean' then
        print('^1 ERROR ^7Config.Core.Strict missing')
        return false
    end
    return true
end

if not validate() then
    StopResource(resource)
    return
end

