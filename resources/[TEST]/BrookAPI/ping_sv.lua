local limitping = 700

RegisterServerEvent('pingKicker:check')
AddEventHandler('pingKicker:check', function()
	local _source = source
	local currentPing = GetPlayerPing(_source)

	TriggerClientEvent('pingKicker:return', _source, currentPing)
end)

RegisterServerEvent('pingKicker:kick')
AddEventHandler('pingKicker:kick', function(finalPing)
	local _source = source

	DropPlayer(_source, "Ton PING est trop haut ! (" .. finalPing .. "ms/" .. limitping .. "ms limite)")
end)