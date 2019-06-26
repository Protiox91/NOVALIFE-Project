ESX = nil

local InMarker = false
local IsMenuOpen = false
local Time = 0
local zone = Config.Zones[Config.CurrentZone]
local transactionInProgress = false
local transactionTimeout = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function OpenMenu()

end

function CloseMenu()
  if transactionInProgress then
    transactionInProgress = false
    ESX.ClearTimeout(transactionTimeout)
    ESX.TriggerServerCallback('esx_darkspider:punish')
  end
  EnableAllControlActions(0)
  SetNuiFocus(false)
  IsMenuOpen = false
  SendNUIMessage({
    hide = true
  })
end

RegisterNUICallback('escape', function(data, cb)
  CloseMenu()
  cb('ok')
end)

RegisterNUICallback('transaction', function(data, cb)
  transactionInProgress = true
  ESX.TriggerServerCallback('esx_darkspider:getBlackMoney', function(blackMoney)
    local charge = {}
    for i=1, #Config.Charges, 1 do
      if Config.Charges[i].Amount <= blackMoney then
        charge = Config.Charges[i]
      end
    end
    
    transactionTimeout = ESX.SetTimeout(charge.Timer, function()
      ESX.TriggerServerCallback('esx_darkspider:washBlackMoney', function()
        transactionInProgress = false
        SendNUIMessage({
          endTransaction = true
        })
      end)
    end)
  end)
  cb('ok')
end)

-- Render markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(0)		
    DrawMarker(1, zone.x, zone.y, zone.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 0, 0, 0, false, true, 2, false, false, false, false)
	end
end)

-- Keypresses
Citizen.CreateThread(function()
	while true do
    Wait(0)		
    local coords = GetEntityCoords(GetPlayerPed(-1))

    if GetDistanceBetweenCoords(coords, zone.x, zone.y, zone.z, true) < 1.5 then
      InMarker = true
      if not IsMenuOpen then
        SetTextComponentFormat('STRING')
        AddTextComponentString("Appuie sur ~INPUT_CONTEXT~ pour ~r~Blanchir votre argent")
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      end
    elseif InMarker then
      InMarker = false
      CloseMenu()
    end
  end
end)

Citizen.CreateThread(function()
	while true do
    Wait(0)
    
    if IsMenuOpen then
      DisableControlAction(0, 1,    true) -- LookLeftRight
      DisableControlAction(0, 2,    true) -- LookUpDown
      DisableControlAction(0, 25,   true) -- Input Aim
      DisableControlAction(0, 106,  true) -- Vehicle Mouse Control Override

      DisableControlAction(0, 24,   true) -- Input Attack
      DisableControlAction(0, 140,  true) -- Melee Attack Alternate
      DisableControlAction(0, 141,  true) -- Melee Attack Alternate
      DisableControlAction(0, 142,  true) -- Melee Attack Alternate
      DisableControlAction(0, 257,  true) -- Input Attack 2
      DisableControlAction(0, 263,  true) -- Input Melee Attack
      DisableControlAction(0, 264,  true) -- Input Melee Attack 2

      DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
      DisableControlAction(0, 14,   true) -- Weapon Wheel Next
      DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
      DisableControlAction(0, 16,   true) -- Select Next Weapon
      DisableControlAction(0, 17,   true) -- Select Prev Weapon
    else
      if InMarker and IsControlJustReleased(0, 38) and GetLastInputMethod(2) then
        IsMenuOpen = true
        ESX.TriggerServerCallback('esx_darkspider:getBlackMoney', function(blackMoney)
          local charge = {}
          for i=1, #Config.Charges, 1 do
            if Config.Charges[i].Amount <= blackMoney then
              charge = Config.Charges[i]
            end
          end
          SendNUIMessage({
            show = true,
            amount = blackMoney,
            fee = charge.Fee,
            timer = charge.Timer
          })
        end)
        SetNuiFocus(true)
      elseif IsControlPressed(0, 18) and IsMenuOpen then
        CloseMenu() 
      end
    end
  end
end)