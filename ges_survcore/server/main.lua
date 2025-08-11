-- server entry
local resource = GetCurrentResourceName()

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
