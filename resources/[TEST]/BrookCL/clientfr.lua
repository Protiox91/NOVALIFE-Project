-- FONCTIONNEL --
ESX                           = nil
local IsEngineOn = true
local interactionDistance = 3.5
local player = GetPlayerPed(-1)
local coords = GetEntityCoords(player)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
	end

end)

function Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

RegisterNetEvent('Brook:Lock')
AddEventHandler('Brook:Lock', function()
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local hasAlreadyLocked = false
		cars = ESX.Game.GetVehiclesInArea(coords, 8)
		local carstrie = {}
		local cars_dist = {}		
		notowned = 0
		if #cars == 0 then
			ESX.ShowNotification("Il n'y a pas de véhicule vous appartenant à proximité.")
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
				local plate = Trim(GetVehicleNumberPlateText(carstrie[i]))
				ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
					if owner and hasAlreadyLocked ~= true then
						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
						vehicleLabel = GetLabelText(vehicleLabel)
						local lock = GetVehicleDoorLockStatus(carstrie[i])
						if lock == 1 or lock == 0 then
							lockLights(carstrie[i])
							SetVehicleDoorShut(carstrie[i], 0, false)
							SetVehicleDoorShut(carstrie[i], 1, false)
							SetVehicleDoorShut(carstrie[i], 2, false)
							SetVehicleDoorShut(carstrie[i], 3, false)
							SetVehicleDoorsLocked(carstrie[i], 2)
							PlayVehicleDoorCloseSound(carstrie[i], 1)
							if vehicleLabel == "NULL" then
								ESX.ShowNotification('Vous avez ~r~verrouillé~s~ votre ~y~véhicule~s~.')
							else
								ESX.ShowNotification('Vous avez ~r~verrouillé~s~ votre ~y~'..vehicleLabel..'~s~.')
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							hasAlreadyLocked = true
						elseif lock == 2 then
							lockLights(carstrie[i])
							SetVehicleDoorsLocked(carstrie[i], 1)
							PlayVehicleDoorOpenSound(carstrie[i], 0)
							if vehicleLabel == "NULL" then
								ESX.ShowNotification('Vous avez ~r~déverrouillé~s~ votre ~y~véhicule~s~.')
							else
								ESX.ShowNotification('Vous avez ~g~déverrouillé~s~ votre ~y~'..vehicleLabel..'~s~.')
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							hasAlreadyLocked = true
						end
					else
						notowned = notowned + 1
					end
					if notowned == #carstrie then
						ESX.ShowNotification("Il n'y a pas de véhicule vous appartenant à proximité.")
					end	
				end, plate)
			end			
		end
end)


RegisterNetEvent('Brook:Engine')
AddEventHandler('Brook:Engine',function() 
	local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		
		if IsEngineOn == true then
			IsEngineOn = false
			--SetVehicleEngineOn(vehicle,false,false,false)

            SetVehicleEngineOn(GetVehiclePedIsIn( GetPlayerPed(-1), false ), true, false, true)
            SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false)
            DisableControlAction(0,20,true)	
		else
			IsEngineOn = true
			--SetVehicleUndriveable(vehicle,false)
			--SetVehicleEngineOn(vehicle,true,false,false)

			SetVehicleEngineOn(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false, false, true)
			SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), true)
			EnableControlAction(0,20,true)
		end
		
		while (IsEngineOn == false) do
			--SetVehicleUndriveable(vehicle,true)
			SetVehicleUndriveable(GetVehiclePedIsIn( GetPlayerPed(-1), false ), false)
			DisableControlAction(0,20,true)	
			DisableControlAction(0,32,true)	
			Citizen.Wait(2)
		end
	end
end)

-- NON FONCTIONNEL --

RegisterNetEvent('Brook:trunk')
AddEventHandler('Brook:trunk',function() 
	TriggerEvent('Brook:opentrunk')
	--exports.esx_inventoryhud_trunk:openmenuvehicle()
end)

RegisterNetEvent('Brook:rdoors')
AddEventHandler('Brook:rdoors',function()
	local player = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local lock = GetVehicleDoorLockStatus(vehicle)
	if (IsPedSittingInAnyVehicle(player)) then 
		if lock == 1 or lock == 0 then
			local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
			if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,2,0,0)
				SetVehicleDoorOpen(vehicle,3,0,0)
			else
				SetVehicleDoorShut(vehicle,2,0)
				SetVehicleDoorShut(vehicle,3,0)
			end
		elseif lock == 2 then
			ESX.ShowNotification("Le véhicule est vérouillé, impossible d'ouvrir !")
		end
	else
		ESX.ShowNotification("Vous devez être dans un véhicule !")
	end	
end) 


function ShowNotification(text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage("CHAR_HUMANDEFAULT" , "CHAR_HUMANDEFAULT", true, 1, "Vehicule", false, text);
    DrawNotification(false, true);
end

function lockLights(vehicle)
	StartVehicleHorn(vehicle, 75, 1, false)
	SetVehicleLights(vehicle, 2)
	Wait (25)
	SetVehicleLights(vehicle, 0)
	Wait (25)
	StartVehicleHorn(vehicle, 75, 1, false)
	SetVehicleLights(vehicle, 2)
	Wait (200)
	SetVehicleLights(vehicle, 0)
	StartVehicleHorn(vehicle, 100, 1, false)
	Wait (200)
	SetVehicleLights(vehicle, 2)
	Wait (400)
	SetVehicleLights(vehicle, 0)
end
