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
local timer = 0
local Users = {}
local x, y, z = nil
local updateLaunched = false

----------------------------------------------
-- Create the user object ####################
-- - - - - - - - - - - - - - - - - - - - - - -
RegisterServerEvent('deed:createUser')
AddEventHandler('deed:createUser', function()
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]

	GetSpawnPos(identifier, function(spawnPos, group)
		Citizen.CreateThread(function()
			while true do
				Wait(50)
				timer = timer + 50

				if(timer > 10000)then
					break
				end

				if(spawnPos and spawnPos ~= 'nil')then
					Users[src] =  CreateSpawnManager(src, spawnPos, group)
					local x, y, z = spawnPos['x'] or spawnPos[1], spawnPos['y'] or spawnPos[2], spawnPos['z'] or spawnPos[3]
					TriggerClientEvent('deed:spawnUser', src, x, y, z)
					if not updateLaunched then
						TriggerEvent('deed:launchAutoUpdate')
						updateLaunched = true
					end
					break
				else
					Users[src] = CreateSpawnManager(src, nil, group)
					if not updateLaunched then
						TriggerEvent('deed:launchAutoUpdate')
						updateLaunched = true
					end
					break
				end
			end
		end)
	end)
end)

----------------------------------------------
-- Get player position to update the class ###
-- - - - - - - - - - - - - - - - - - - - - - -
RegisterServerEvent('deed:sendPosToServer')
AddEventHandler('deed:sendPosToServer', function(pos)
	local src = source
	if pos then
		returnUser(src, function(user)
			if user then
				user.set('actualPos', pos)
			end
		end)
	end
end)

----------------------------------------------
-- Launch the auto update function ###########
-- - - - - - - - - - - - - - - - - - - - - - -
RegisterServerEvent('deed:launchAutoUpdate')
AddEventHandler('deed:launchAutoUpdate', function()
	if globalConf['MAIN'].autoUpdate then
		autoUpdate()
	end
end)

----------------------------------------------
-- Returns a player or all players ###########
-- - - - - - - - - - - - - - - - - - - - - - -
function returnUser(who, cb)
	if(type(who) == 'number')then
		if(Users[who])then
			cb(Users[who])
		else
			cb()
		end
	elseif(who == 'all')then
		cb(Users)
	end
end

----------------------------------------------
-- When a player disconnecting ###############
-- - - - - - - - - - - - - - - - - - - - - - -
AddEventHandler('playerDropped', function()
	local src = source
	returnUser(src, function(user)
		if(user)then
			user.save()
		end
	end)
	Users[src] = nil
end)

----------------------------------------------
-- Rcon save command #########################
-- - - - - - - - - - - - - - - - - - - - - - -
if(globalConf['COMMANDS'].rconSave)then
	AddEventHandler('rconCommand', function(commandName, args)
		if(commandName == 'save')then
			for k, v in pairs(Users) do
				if Users[k] ~= nil then
					v.save()
				end
			end
			if globalConf['MSG'].save_message then
				if GetConvar('mysql_debug', 'true') == 'false' then
					print(txt[lang].has_been_saved)
				end
			end
		CancelEvent()
		end
	end)
end