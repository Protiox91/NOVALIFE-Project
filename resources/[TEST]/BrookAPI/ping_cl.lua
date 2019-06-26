local strikes = 0
local playerPing = 0
local strikesmax = 3
local limitping = 700

RegisterNetEvent('pingKicker:return')
AddEventHandler('pingKicker:return', function(ping)
	playerPing = ping
end)

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent('pingKicker:check')
		
		Wait(5000)

		if playerPing >= limitping then
			strikes = strikes + 1

			-- Displays in the clients F8 console
			print('Votre PING (' .. playerPing .. ') est au dessus de la limite. (' .. strikes .. '/' .. limitping .. ')')
		else
			if strikes > 0 then
				strikes = strikes - 1
			end
		end

		if strikes >= strikesmax then
			TriggerServerEvent('pingKicker:kick', playerPing)
		end
	end
end)