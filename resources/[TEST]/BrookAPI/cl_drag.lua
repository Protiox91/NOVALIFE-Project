-- @Date:   2017-09-12
  -- @Project: FX Interactions
  -- @Owner: Jink Left
  -- @LICENSE: NO LICENSE/LICENSE
  -- @Last modified time: 2017-09-12
--------------------------------------------------------------
--------------------[  CHANGEABLE DATA   ]--------------------
-------------------------------------------------------------- 
local controls = { -- Change the number located next to the key for the control to which ever combination you want to use. https://wiki.fivem.net/wiki/Controls
	['handsup'] = { key = 73 },
	['grabbing'] = { key1 = 244, key2 = 244 },
}
----------------------------------------------------
--------------------[   DATA   ]--------------------
----------------------------------------------------
local hands = "down"
local status = "standing"
local animation = false
local pedindex = {}
----------------------------------------------------
---------------[	FUNCTIONS 		]---------------
----------------------------------------------------
function GetHandStatus()
	return hands
end
--
function SetClosestEntity() -- This function will set the closest entity to you as the variable entity.
	local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    local lPed = GetPlayerPed(-1)

    repeat --Thanks to Supa https://forum.fivem.net/t/how-to-supas-helper-scripts/41100
        if not IsEntityDead(ped) then
                pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

	for peds,_ in pairs(pedindex) do
		local lcoord = GetEntityCoords(lPed, true)
		local pcoord = GetEntityCoords(peds, true)
		local distance = GetDistanceBetweenCoords(lcoord.x, lcoord.y, lcoord.z, pcoord.x, pcoord.y, pcoord.z, true)
		if distance < 4 and distance > 0 then -- Had to add > 0 because when populating the ped index some peds indexed 0.0 distance away. This fixed the issue.
			entity = peds 
		end
	end

	if entity ~= nil then -- If the entity exists this will run. This function should be ran in a loop.
		local lcoord = GetEntityCoords(lPed, true)
		local ecoord = GetEntityCoords(entity, true)
		local distance = GetDistanceBetweenCoords(lcoord.x, lcoord.y, lcoord.z, ecoord.x, ecoord.y, ecoord.z, true)
		if distance > 2 then -- If distance is > a number 4 worked well for me. Then it will reset the entity to nil.
			entity = nil 
		end
	end

	return entity
end
 
function GetPlayers() -- compliments of Cops by Kyominii https://github.com/Kyominii/Cops_FiveM
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer() -- compliments of Cops by Kyominii https://github.com/Kyominii/Cops_FiveM
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

--- Describe what AnimationComplete does (checks for animations to be complete or total cycles before moving on).
-- @param player	The ped who doing the animation.
-- @param animationD	Animation dictionary http://www.los-santos-multiplayer.com/en/dev.airdancer?cxt=anim
-- @param animationN	Animation name http://www.los-santos-multiplayer.com/en/dev.airdancer?cxt=anim
-- @param time	Total between 0-1 float.  It's a percentage of the animation completed.
-- @param cycles	The amount of cycles to be completed before loop breaks.
local function AnimationComplete( player, animationD, animationN, time, cycles )
	local animation = true
	local count = 0
	repeat 
		if ( GetEntityAnimCurrentTime( player, animationD, animationN ) < time ) then
			Citizen.Wait(100)
		end
		count = count + 1
		animation = IsEntityPlayingAnim(player, animationD, animationN , 3)
	until (not animation or count == cycles)

	return true
end

function LoadAnimationDictionary(animationD) -- Simple way to load animation dictionaries to save lines.
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(100)
	end
end

function CheckActions()
	local lPed = GetPlayerPed(-1)
	if hands ~= nil and not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
		return true
	else
		return false
	end
end

function DisableActions()
	local lPed = GetPlayerPed(-1)
	if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) or IsEntityPlayingAnim(lPed, "combat@drag_ped@", "injured_pickup_front_plyr", 3) or IsEntityPlayingAnim(lPed, "combat@drag_ped@", "injured_drag_plyr", 3)  then
		if hands ~= nil then -- There is possibility to disable actions based on the status of the hands in the future --JINK
				DisableControlAction(1, 23, true)  -- F
				DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
				DisableControlAction(1, 140, true) --Disables Melee Actions
				DisableControlAction(1, 141, true) --Disables Melee Actions
				DisableControlAction(1, 142, true) --Disables Melee Actions	
			if hands ~= "dragging" then	
				DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
				DisablePlayerFiring(lPed, true) -- Disable weapon firing
			end
		end 
	end
end


----------------------------------------------------
---------------[	THREADS 		]---------------
---------------------------------------------------- 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(150)
		local lPed = GetPlayerPed(-1)
		local entity = SetClosestEntity()
		local player, distance = GetClosestPlayer()
		if DoesEntityExist(lPed) and not animation then
			if IsControlPressed(1, controls['handsup'].key) and CheckActions() then		
	 				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
					LoadAnimationDictionary("random@mugging3")
					if hands == "down" then
						hands = "up"
						TriggerServerEvent('fx:getHandStatus', hands,lPed)	
						TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, .01, 49, 0, 0, 0, 0)
						animation = true
					end	
			elseif IsControlPressed(1, controls['grabbing'].key1) and IsControlPressed(1, controls['grabbing'].key2) and CheckActions() and hands == "down" and entity ~= nil and IsPedDeadOrDying(entity, 1) or IsControlPressed(1, controls['grabbing'].key1) and IsControlPressed(1, controls['grabbing'].key2) and CheckActions() and hands == "down" and player ~= -1 and IsPedDeadOrDying(player, 1) then
				hands = "dragging"
				LoadAnimationDictionary("combat@drag_ped@")	
				TaskPlayAnim(lPed, "combat@drag_ped@", "injured_pickup_front_plyr", 8.0, -8, -1, 33, 0, 0, 0, 0)
				AnimationComplete(lPed, "combat@drag_ped@", "injured_pickup_front_plyr", 0.85, 85)
				TaskPlayAnim(lPed, "combat@drag_ped@", "injured_drag_plyr", 8.0, -8, -1, 33, 0, 0, 0, 0)
				if entity ~= nil then 
					SetEntityAsMissionEntity(entity, true, true)
					ResurrectPed(entity) 
					AttachEntityToEntity(entity, lPed, 11816, 4103, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					TaskPlayAnim(entity, "combat@drag_ped@", "injured_drag_ped", 8.0, -8, -1, 33, 0, 0, 0, 0)
					SetEntityAsNoLongerNeeded(entity)
				elseif (player ~= nil and distance ~= -1 and distance < 3) then
					local dPlayer = GetPlayerServerId(player)
					local loc = GetEntityCoords(player, false)
					TriggerServerEvent('fx:dragRequest', dPlayer)
					NetworkResurrectLocalPlayer(loc.x, loc.y, loc.z, true, true, false)
					AttachEntityToEntity(player, lPed, 11816, 4103, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					TaskPlayAnim(player, "combat@drag_ped@", "injured_drag_ped", 8.0, -8, -1, 33, 0, 0, 0, 0)
				end
				animation = true
			elseif IsControlPressed(1, controls['grabbing'].key1) and IsControlPressed(1, controls['grabbing'].key2) and CheckActions() and hands == "down" and entity ~= nil and not IsPedDeadOrDying(entity, 1) or IsControlPressed(1, controls['grabbing'].key1) and IsControlPressed(1, controls['grabbing'].key2) and CheckActions() and hands == "down" and player ~= -1 and not IsPedDeadOrDying(player, 1) then
				hands = "cuffing"
				LoadAnimationDictionary("mp_arrest_paired")
				LoadAnimationDictionary("mp_arresting")	
				LoadAnimationDictionary("missprologueig_2")	
				TaskPlayAnim(lPed, "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
				if entity ~= nil then 
					SetEntityAsMissionEntity(entity, true, true)
					AttachEntityToEntity(entity, lPed, 11816, 4103, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					TaskPlayAnim(entity, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
					if AnimationComplete(lPed, "mp_arrest_paired", "cop_p2_back_right", 0.89, 300) then
						TaskPlayAnim(lPed, "missprologueig_2", "main_brad", 8.0, -8, -1, 49, 0, 0, 0, 0)
						TaskPlayAnim(entity, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
						SetEntityAsNoLongerNeeded(entity)
					end
					status = "cuffed"
				elseif (player ~= nil and distance ~= -1 and distance < 3) then
					local dPlayer = GetPlayerServerId(player)
					local loc = GetEntityCoords(player, false)
					TriggerServerEvent('fx:dragRequest', dPlayer)
					NetworkResurrectLocalPlayer(loc.x, loc.y, loc.z, true, true, false)
					AttachEntityToEntity(player, lPed, 11816, 4103, 0.48, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					TaskPlayAnim(player, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
					status = "cuffed"
				end
				animation = true
			end
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(150)
		local lPed = GetPlayerPed(-1)
		local entity = entity
		DisableActions()
		if IsControlReleased(1, controls['handsup'].key) and animation then
			if hands == "up" then
	  			hands = "down"
	  			TriggerServerEvent('fx:getHandStatus', hands,lPed)
	  			ClearPedSecondaryTask(lPed)
	  			animation = false
			end
		end
		if IsControlReleased(1, controls['grabbing'].key1) and IsControlReleased(1, controls['grabbing'].key2) and animation then
			if hands == "dragging" and entity ~= nil or hands == "dragging" and player ~= nil then
				hands = "down"
				TriggerServerEvent('fx:getHandStatus', hands,lPed)
				ClearPedSecondaryTask(lPed)
				ClearPedSecondaryTask(entity)
				DetachEntity(lPed, 1, true)
				if player == nil then 
					DetachEntity(entity, 1, true)
					SetPedCanRagdoll(entity, true)
					SetPedToRagdoll(entity, 1, 1, 0, false, false, false)
				else
					DetachEntity(player, 1, true)
					SetPedCanRagdoll(player, true)
					SetPedToRagdoll(player, 1, 1, 0, false, false, false)
				end
				animation = false
			elseif hands == "cuffing" and entity ~= nil or hands == "cuffing" and player ~= nil then
				hands = "down"
				TriggerServerEvent('fx:getHandStatus', hands,lPed)
				ClearPedSecondaryTask(lPed)
				ClearPedSecondaryTask(entity)
				DetachEntity(lPed, 1, true)
				if player == nil then 
					DetachEntity(entity, 1, true)
				else
					DetachEntity(player, 1, true)
				end
				animation = false
			end
		end
	end
end)
----------------------------------------------------
---------------[	EVENTS 		]-------------------
----------------------------------------------------
RegisterNetEvent('fx:getHandStatusPlayer')
AddEventHandler('fx:getHandStatusPlayer',function(event,source)
	if hands ~= "down" then
		TriggerServerEvent("fx:reSendHandStatus",event,source,hands)
	elseif hands == "down" then		
		TriggerServerEvent("fx:reSendHandStatus",event,source,hands)
	end
end)

RegisterNetEvent('fx:toggleDrag')
AddEventHandler('fx:toggleDrag', function(dPlayer)
	if(status == "standing") then
		status = "dragged"
		player = dPlayer
	end
end)