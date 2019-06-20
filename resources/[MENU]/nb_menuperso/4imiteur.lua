------------------------------------------------------------------------------------------------regulateur
local speedLimit = 0
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )   
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local vehicleModel = GetEntityModel(vehicle)
        local speed = GetEntitySpeed(vehicle)
        local inVehicle = IsPedSittingInAnyVehicle(ped)
        local float Max = GetVehicleMaxSpeed(vehicleModel)
        if ped and inVehicle then
            if IsControlJustPressed(1, 96) then
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    if CruiseControl == 0 then
                        speedLimit = speed
                        SetEntityMaxSpeed(vehicle, speedLimit)
						drawNotification("~y~Régulateur: ~g~Active\n~s~MAX speed ".. math.floor((speedLimit*3.6)+1).."kmh")
						Citizen.Wait(1000)
				        DisplayHelpText("Ajuster votre vitesse avec Page Up - Page Down")
						PlaySound(-1, "COLLECTED", "HUD_AWARDS", 0, 0, 1)
                        CruiseControl = 1
                    else
                        SetEntityMaxSpeed(vehicle, Max)
						drawNotification("~y~Régulateur: ~r~Désactivé")						
                        CruiseControl = 0
                    end
                else
				    drawNotification("Action disponible en voiture")						
                end
            elseif IsControlJustPressed(1, 10) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit + 0.276
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					DisplayHelpText("Vitesse Maximale ".. math.floor((speedLimit*3.6)+1).. "kmh")
                end
            elseif IsControlJustPressed(1, 11) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit - 0.276 --1.38
					if speedLimit < 0 then speedLimit = 0 end
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
					DisplayHelpText("Vitesse Maximale ".. math.floor((speedLimit*3.6)+1).. "kmh")
                end
            end
        end
    end
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end