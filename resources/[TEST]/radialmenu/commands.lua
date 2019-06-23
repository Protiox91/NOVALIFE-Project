RegisterCommand("lock", function(source, args, rawCommand)
    TriggerEvent('Brook:Lock')
end)

RegisterCommand("engine", function(source, args, rawCommand)
    TriggerEvent('Brook:Engine')
end)

RegisterCommand("trunk", function(source, args, rawCommand)
    TriggerEvent('Brook:trunk')
end)

RegisterCommand("hood", function(source, args, rawCommand)
    TriggerEvent('Brook:hood')
end)

RegisterCommand("rdoors", function(source, args, rawCommand)
    TriggerEvent('Brook:rdoors')
end)