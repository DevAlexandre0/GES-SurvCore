-- admin commands
RegisterCommand('blizzard', function(src, args)
    if src ~= 0 and not IsPlayerAceAllowed(src, 'ges.blizzard') then
        TriggerClientEvent('chat:addMessage', src, { args = { '[GES]', 'ไม่มีสิทธิ์' } })
        return
    end
    local intensity = tonumber(args[1]) or 1.0
    intensity = Util.Clamp(intensity, 0.0, 1.0)
    local duration = tonumber(args[2]) or 60
    TriggerClientEvent(CONST.Events.BlizzardStart, -1, intensity, duration)
    print(('^2 OK ^7blizzard %s %s by %s'):format(intensity, duration, src))
end, false)
