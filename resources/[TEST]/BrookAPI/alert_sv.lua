RegisterServerEvent("BrookAPI:polalertsv")
AddEventHandler("BrookAPI:polalertsv", function ()
    TriggerClientEvent("BrookAPI:polalertcl")
end)

RegisterServerEvent("BrookAPI:ambalertsv")
AddEventHandler("BrookAPI:ambalertsv", function ()
    TriggerClientEvent("BrookAPI:ambalertcl")
end)
