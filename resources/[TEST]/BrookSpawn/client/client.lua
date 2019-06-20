--[[
##################################################################
Author : Deediezi
-----------------------------------------------------------------
Gitlab : https://gitlab.com/Deediezi/gta5_scripts
-----------------------------------------------------------------
Discord : Deediezi#0794
##################################################################
]]

----------------------------------------------
-- Initialize some vars ######################
-- - - - - - - - - - - - - - - - - - - - - - -
local alreadySpawned, isLoaded = false

----------------------------------------------
-- Customize the spawn of the player #########
-- - - - - - - - - - - - - - - - - - - - - - -
RegisterNetEvent('deed:spawnUser')
AddEventHandler('deed:spawnUser', function(x, y, z)
	local ped = GetPlayerPed(-1)
	if(not isLoaded)then
		SetEntityCoords(ped, x, y, z, 1.0, 1, 0, 0, 1)
		FreezeEntityPosition(ped, true)
		Citizen.Wait(1500)
		FreezeEntityPosition(ped, false)

		isLoaded = true
	end
end)

----------------------------------------------
-- Send the actual position to the server ####
-- - - - - - - - - - - - - - - - - - - - - - -
RegisterNetEvent('deed:sendPosToServer')
AddEventHandler('deed:sendPosToServer', function()
	local ped = GetPlayerPed(-1)
	local x, y, z = table.unpack(GetEntityCoords(ped, true))
	local pos = {x, y, z}

	TriggerServerEvent('deed:sendPosToServer', pos)
end)

----------------------------------------------
-- When the player spawn #####################
-- - - - - - - - - - - - - - - - - - - - - - -
AddEventHandler('playerSpawned', function()
	if(not alreadySpawned)then
		TriggerServerEvent("deed:createUser")
		alreadySpawned = 1
		Citizen.CreateThread(function()
			while true do
				Wait(6000)
				TriggerEvent('deed:sendPosToServer')
			end
		end)
	end
end)