RegisterNetEvent('Brook:Display')
AddEventHandler('Brook:Display',function()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end)