function advancednotify(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
end

RegisterNetEvent("BrookAPI:polalertcl")
AddEventHandler("BrookAPI:polalertcl", function()
    DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 600)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0);
        Wait(0);
    end
    if GetOnscreenKeyboardResult() then
        local msg = GetOnscreenKeyboardResult()
        advancednotify("CHAR_CALL911", 1, "Police", false, msg)
    end
end)

RegisterNetEvent("BrookAPI:ambalertcl")
AddEventHandler("BrookAPI:polalertcl", function()
    DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 600)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0);
        Wait(0);
    en
    if GetOnscreenKeyboardResult() then
        local msg = GetOnscreenKeyboardResult()
        advancednotify("CHAR_CALL911", 1, "EMS", false, msg)
    end
end)