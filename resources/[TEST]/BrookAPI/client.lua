AddEventHandler("playerSpawned", function()
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(PlayerPedId(), true, true)
end)

Citizen.CreateThread(function()
	while true do
			Wait(50)
			playerPed = GetPlayerPed(-1)
			if playerPed then
					disableRadio(GetVehiclePedIsIn(playerPed, false))
			end
	end
end)

function disableRadio(car)
	if car then
		SetVehicleRadioEnabled(car, false)
	end
end

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
		local a=GetSelectedPedWeapon(ped)
		
		if ( GetFollowPedCamViewMode() ~= 5  ) then 
			if (a == GetHashKey("WEAPON_SNIPERRIFLE") or a == GetHashKey("WEAPON_MARKSMANRIFLE_MK2") or a == GetHashKey("WEAPON_MARKSMANRIFLE") or a == GetHashKey("WEAPON_HEAVYSNIPER") or a == GetHashKey("WEAPON_HEAVYSNIPER_MK2")) then
			else
				HideHudComponentThisFrame( 14 )
			end
		else
		end
    end 
end 

Citizen.CreateThread( function()
    while true do 
        ManageReticle()

        Citizen.Wait( 1 )
    end 
end )