function advancednotify(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
end

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(950)
        if (IsInVehicle()) then
            local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
            if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
                local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
                local fuel = math.ceil(round(GetVehicleFuelLevel(vehicle), 1))
                if fuel == 100 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est plein !")
        
                elseif fuel == 75 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est remplis à "..fuel.."% de gasoil.")
        
                elseif fuel == 50 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est remplis à "..fuel.."% de gasoil. N'oubliez pas de passer à la station d'essence !")

                elseif fuel == 25 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est remplis à "..fuel.."% de gasoil. N'oubliez pas de passer à la station d'essence !")

                elseif fuel == 10 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est remplis à "..fuel.."% de gasoil. Il faut passer en urgence à la station !")

                elseif fuel == 5 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est remplis à "..fuel.."% de gasoil. Il faut passer en urgence à la station !")
                elseif fuel < 5 then
                    advancednotify("CHAR_HUMANDEFAULT", 1, "Véhicule", false, "Votre véhicule est remplis à va bientôt être à sec ! Allez à la station la plus proche !")
                end
            end
        end
    end
end)