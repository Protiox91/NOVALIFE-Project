local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local menuIsShowed				  = false
local hasAlreadyEnteredMarker     = false
local lastZone                    = nil
local isInJoblistingMarker 		  = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


function ShowProfessionMenu()
	ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Surgery",
	{
	  css = 'emploi',
	  title = ("Job Center"),
	  align = "top-left",
	  elements = {
		--{label = "Choose profession", value = "choose"},
		{label = "Envoyer une Candidature", value = "apply"}
	  }
	},
	function(data, menu)
	  menu.close()
  
	  if data.current.value == "choose" then
		ShowJobListingMenu()
	  elseif data.current.value == "apply" then
		openGui()
	  end
	end,
	function(data, menu)
	  menu.close()
	end)
end

-- MENU
function openGui()
	SendNUIMessage({openMenu = true})
	Citizen.CreateThread(function()
	  Citizen.Wait(500)
	  SetNuiFocus(true, true)
	end)
end
  
function closeGui()
	SetNuiFocus(false)
	SendNUIMessage({openMenu = false})
end
  
RegisterNUICallback('closeMenu', function(data, cb)
	closeGui()
	cb('ok')
end)
  
RegisterNUICallback('postApplication', function(data, cb)
	
	TriggerServerEvent('esx_joblisting:postApplication', data)
	
	cb('ok')
end)
-- Menu


AddEventHandler('esx_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		isInJoblistingMarker  = false
		local currentZone = nil
		for i=1, #Config.Zones, 1 do
			if GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < 2 then
				isInJoblistingMarker  = true
				SetTextComponentFormat('STRING')
            	AddTextComponentString(_U('access_job_center'))
            	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end
		if isInJoblistingMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInJoblistingMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_joblisting:hasExitedMarker')
		end
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, Keys['E']) and GetLastInputMethod(2) and isInJoblistingMarker and not menuIsShowed then
			ShowProfessionMenu()
		end
	end
end)

RegisterNetEvent('NB:openJobMenu')
AddEventHandler('NB:openJobMenu', function()
	ShowProfessionMenu()
end)
