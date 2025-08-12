AddEventHandler('ges:temperature:update', function(data)
    if type(data) ~= 'table' then return end
    -- relay ขึ้น server ให้ GES-Needs ใช้ policy คูณ decay
    TriggerServerEvent('ges:temperature:changed', data)
end)

AddEventHandler('ges:wetness:update', function(data)
    if type(data) ~= 'table' then return end
    TriggerServerEvent('ges:wetness:changed', data)
end)

AddEventHandler('ges:stamina:exhausted', function(payload)
    TriggerServerEvent('ges:stamina:exhausted', payload or {})
end)

AddEventHandler('ges:injury:update', function(data)
    if type(data) ~= 'table' then return end
    TriggerServerEvent('ges:injury:changed', data)
end)

AddEventHandler('ges:sickness:update', function(data)
    if type(data) ~= 'table' then return end
    TriggerServerEvent('ges:sickness:changed', data)
end)



-- client side exports
local caps = {
    temperature = GES_Temp,
    wetness = GES_Wetness,
    heat = GES_Heat,
    blizzard = GES_Blizzard
}

exports('Core_Call', function(cap, method, ...)
    local m = caps[cap]
    if m and type(m[method]) == 'function' then
        return m[method](...)
    end
end)

exports('Temp_GetTick', function() return GES_Temp.GetTick() end)
exports('Temp_Get', function() return GES_Temp.Get() end)
exports('Wetness_Get', function() return GES_Wetness.Get() end)
exports('Wetness_Add', function(delta) GES_Wetness.Add(delta) end)
exports('Heat_RegisterSource', function(id, coords, radius, power) GES_Heat.RegisterSource(id, coords, radius, power) end)
exports('Heat_UnregisterSource', function(id) GES_Heat.UnregisterSource(id) end)
exports('Heat_GetAt', function(coords) return GES_Heat.GetAt(coords) end)
exports('Blizzard_Start', function(intensity, duration) GES_Blizzard.Start(intensity, duration) end)
