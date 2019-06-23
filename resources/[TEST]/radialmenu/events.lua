IsEngineOn = true
interactionDistance = 3.5
local player = GetPlayerPed(-1)
local coords = GetEntityCoords(player)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end

end)

RegisterNetEvent('Brook:Engine')
AddEventHandler('Brook:Engine',function() 
	local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		
		if IsEngineOn == true then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		
		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(2)
		end
	end
end)

RegisterNetEvent('Brook:trunk')
AddEventHandler('trunk',function() 
	--local player = GetPlayerPed(-1)		
	--local vehicle = ESX.Game.GetClosestVehicle(coords)
	--local isopen = GetVehicleDoorAngleRatio(vehicle,5)
	--local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	cars = ESX.Game.GetVehiclesInArea(coords, 30)
	local carstrie = {}
	local cars_dist = {}		
	if #cars == 0 then
		ESX.ShowNotification("Il n'y a pas de véhicule à proximité.")
	else
		for j=1, #cars, 1 do
			local coordscar = GetEntityCoords(cars[j])
			local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
			table.insert(cars_dist, {cars[j], distance})
		end
		for k=1, #cars_dist, 1 do
			local z = -1
			local distance, car = 999
			for l=1, #cars_dist, 1 do
				if cars_dist[l][2] < distance then
					distance = cars_dist[l][2]
					car = cars_dist[l][1]
					z = l
				end
			end
			if z ~= -1 then
				table.remove(cars_dist, z)
				table.insert(carstrie, car)
			end
		end
		for i=1, #carstrie, 1 do
			if owner and hasAlreadyLocked ~= true then
				local lock = GetVehicleDoorLockStatus(carstrie[i])
				if lock == 1 or lock == 0 then
					exports.esx_inventoryhud_trunk:openmenuvehicle()
				elseif lock == 2 then
					ESX.ShowNotification("Le véhicule est vérouillé, impossible d'ouvrir !")
				end
			end
		end			
	end	
--[[
	if distanceToVeh <= interactionDistance then
		if (isopen == 0) then
		    SetVehicleDoorOpen(vehicle,5,0,0)
		else
		    SetVehicleDoorShut(vehicle,5,0)
	    end
	else
		ShowNotification("~r~Rapprochez vous du véhicule pour faire cela !")
	end--]]
end)

RegisterNetEvent('Brook:hood')
AddEventHandler('Brook:hood',function() 
	local coords = GetEntityCoords(GetPlayerPed(-1))
	cars = ESX.Game.GetVehiclesInArea(coords, 30)
	local carstrie = {}
	local cars_dist = {}		
	if #cars == 0 then
		ESX.ShowNotification("Il n'y a pas de véhicule à proximité.")
	else
		for j=1, #cars, 1 do
			local coordscar = GetEntityCoords(cars[j])
			local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
			table.insert(cars_dist, {cars[j], distance})
		end
		for k=1, #cars_dist, 1 do
			local z = -1
			local distance, car = 999
			for l=1, #cars_dist, 1 do
				if cars_dist[l][2] < distance then
					distance = cars_dist[l][2]
					car = cars_dist[l][1]
					z = l
				end
			end
			if z ~= -1 then
				table.remove(cars_dist, z)
				table.insert(carstrie, car)
			end
		end
		for i=1, #carstrie, 1 do
			if owner and hasAlreadyLocked ~= true then
				local lock = GetVehicleDoorLockStatus(carstrie[i])
				if lock == 1 or lock == 0 then
					local isopen = GetVehicleDoorAngleRatio(carstrie[i],4)
					if (isopen == 0) then
						SetVehicleDoorOpen(carstrie[i],4,0,0)
					else
						SetVehicleDoorShut(carstrie[i],4,0)
					end
				elseif lock == 2 then
					ESX.ShowNotification("Le véhicule est vérouillé, impossible d'ouvrir !")
				end
			end
		end			
	end
	--[[local player = GetPlayerPed(-1)
	local vehicle = ESX.Game.GetClosestVehicle(coords)	
	local isopen = GetVehicleDoorAngleRatio(vehicle,4)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)		
	if distanceToVeh <= interactionDistance then
		if (isopen == 0) then
			SetVehicleDoorOpen(vehicle,4,0,0)
		else
			SetVehicleDoorShut(vehicle,4,0)
		end
	else
		ShowNotification("~r~Rapprochez vous du véhicule pour faire cela !")
	end--]]
end)

RegisterNetEvent('Brook:rdoors')
AddEventHandler('Brook:rdoors',function() 
	local coords = GetEntityCoords(GetPlayerPed(-1))
	cars = ESX.Game.GetVehiclesInArea(coords, 30)
	local carstrie = {}
	local cars_dist = {}		
	if #cars == 0 then
		ESX.ShowNotification("Il n'y a pas de véhicule à proximité.")
	else
		for j=1, #cars, 1 do
			local coordscar = GetEntityCoords(cars[j])
			local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
			table.insert(cars_dist, {cars[j], distance})
		end
		for k=1, #cars_dist, 1 do
			local z = -1
			local distance, car = 999
			for l=1, #cars_dist, 1 do
				if cars_dist[l][2] < distance then
					distance = cars_dist[l][2]
					car = cars_dist[l][1]
					z = l
				end
			end
			if z ~= -1 then
				table.remove(cars_dist, z)
				table.insert(carstrie, car)
			end
		end
		for i=1, #carstrie, 1 do
			if owner and hasAlreadyLocked ~= true then
				local lock = GetVehicleDoorLockStatus(carstrie[i])
				if lock == 1 or lock == 0 then
					local isopen = GetVehicleDoorAngleRatio(carstrie[i],2) and GetVehicleDoorAngleRatio(carstrie[i],3)
					if (isopen == 0) then
						SetVehicleDoorOpen(carstrie[i],2,0,0)
						SetVehicleDoorOpen(carstrie[i],3,0,0)
					else
						SetVehicleDoorShut(carstrie[i],2,0)
						SetVehicleDoorShut(carstrie[i],3,0)
					end
				elseif lock == 2 then
					ESX.ShowNotification("Le véhicule est vérouillé, impossible d'ouvrir !")
				end
			end
		end			
	end
	--[[local player = GetPlayerPed(-1)		
	local vehicle = ESX.Game.GetClosestVehicle(coords)
	local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
	if distanceToVeh <= interactionDistance then
		if (isopen == 0) then
			SetVehicleDoorOpen(vehicle,2,0,0)
			SetVehicleDoorOpen(vehicle,3,0,0)
		else
			SetVehicleDoorShut(vehicle,2,0)
			SetVehicleDoorShut(vehicle,3,0)
		end
	else
		ShowNotification("~r~Rapprochez vous du véhicule pour faire cela !")
	end--]]
end) 


function ShowNotification(text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage("CHAR_HUMANDEFAULT" , "CHAR_HUMANDEFAULT", true, 1, "Vehicule", false, text);
    DrawNotification(false, true);
end