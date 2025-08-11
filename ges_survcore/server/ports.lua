-- server exports
exports('Blizzard_Start', function(intensity, duration)
    TriggerClientEvent(CONST.Events.BlizzardStart, -1, intensity, duration)
end)
