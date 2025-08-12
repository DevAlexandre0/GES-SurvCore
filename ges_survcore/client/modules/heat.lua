-- simple heat sources
GES_Heat = { sources = {} }

function GES_Heat.Init() end -- placeholder

function GES_Heat.RegisterSource(id, coords, radius, power)
    GES_Heat.sources[id] = { coords = coords, radius = radius, power = power }
end

function GES_Heat.UnregisterSource(id)
    GES_Heat.sources[id] = nil
end

function GES_Heat.GetAt(coords)
    for _,v in pairs(GES_Heat.sources) do
        local dx = coords.x - v.coords.x
        local dy = coords.y - v.coords.y
        local dz = coords.z - v.coords.z
        local distSq = dx*dx + dy*dy + dz*dz
        if distSq <= (v.radius * v.radius) then
            return true, v.power
        end
    end
    return false, 0.0
end
