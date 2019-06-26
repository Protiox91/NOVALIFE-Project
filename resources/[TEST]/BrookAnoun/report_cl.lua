RegisterNetEvent('Brook:Display')
AddEventHandler('Brook:Display',function()
    local limit = 999
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", limit)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
        TriggerServerEvent('Brook:report', text)
    else
        TriggerEvent('esx:showNotification', _source, "Il faut un message pour report !")
    end  
end)