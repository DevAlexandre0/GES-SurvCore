-- simple HUD demo
GES_HUD = {}

function GES_HUD.Init()
    CreateThread(function()
        while Config.Features.HUDDemo do
            local temp = TempState and TempState.feelsLike or 0
            local wet = GES_Wetness and GES_Wetness.Get() or 0
            SetTextFont(0)
            SetTextScale(0.35, 0.35)
            SetTextColour(255,255,255,255)
            SetTextOutline()
            BeginTextCommandDisplayText('STRING')
            AddTextComponentSubstringPlayerName(('Temp %.1f\nWet %.1f'):format(temp, wet))
            EndTextCommandDisplayText(0.005, 0.005)
            Wait(500)
        end
    end)
end
