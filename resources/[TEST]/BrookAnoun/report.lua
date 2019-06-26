ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function report(_name, msg)
    local embeds = {
        {
            ["type"] = "rich",
            ["title"] = "Nouveaux REPORT :" ,
            ["fields"] =  {
                            {
                                ["name"]= "Nom de l'envoyeur :",
                                ["value"]= _name,
                            },
                            {
                                ["name"]= "Message :",
                                ["value"]= msg,
                            },
                    },
            ["color"] = 6807172,
            ["footer"] =  {
                        ["text"]= os.date("%A %x"),
                        },
        }}
    PerformHttpRequest("https://discordapp.com/api/webhooks/591666145946501150/_cBResPX1QJxsbtycwirfSV_0ssWjx6NlT1_b5bFN2LzTJwtzJCqVST9GXaNehqia4f0", function(err, text, headers) end, 'POST', json.encode({ embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('Brook:report')
AddEventHandler('Brook:report', function(msg)
    local _source = source
    local XPlayer = ESX.GetPlayerFromId(_source)
    report(XPlayer.name, msg)
    TriggerClientEvent('esx:showNotification', _source, "Votre report a bien été pris en compte !")
end)

--TriggerEvent('es:addGroupCommand', 'report', 'user', function(source, args, user)
    --TriggerClientEvent('Brook:Display', source)
--end, function(source, args, user)
    --TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ERREUR' } })
--end, {help = "Reporter un mauvais comportement ou un problème aux admins", params = {}})