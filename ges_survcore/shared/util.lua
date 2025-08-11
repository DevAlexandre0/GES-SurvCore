Util = {}

-- simple logger with color codes
function Util.Log(level, msg)
    if level == 'ERROR' then
        print('^1 ERROR ^7' .. msg)
    elseif level == 'WARN' then
        print('^3 WARN ^7' .. msg)
    else
        print('^2 OK ^7' .. msg)
    end
end

function Util.Clamp(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

function Util.TryResource(name)
    return GetResourceState(name) == 'started'
end
