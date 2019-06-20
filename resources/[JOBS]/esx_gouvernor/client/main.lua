local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local isInMarker              = false
local isInPublicMarker        = false
local hintIsShowed            = false
local hintToDisplay           = "Ei vihjettä näytettäväksi"
local onDuty = false
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local in_service = false

PLATE = "VALTIO"

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
  local specialContact = {
    name       = _U('phone_gouvernor'),
    number     = 'gouvernor',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
  }

  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
  if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'gouvernor' and PlayerData.job.name == dispatchNumber then
    -- if esx_service is enabled
    if Config.MaxInService ~= -1 and not playerInService then
      CancelEvent()
    end
  end
end)

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function IsJobTrue()
  if PlayerData ~= nil then
    local IsJobTrue = false
    if PlayerData.job ~= nil and PlayerData.job.name == 'gouvernor' then
      IsJobTrue = true
    end
    return IsJobTrue
  end
end

function IsGradeBoss()
  if PlayerData ~= nil then
    local IsGradeBoss = false
    if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'secretary' then
      IsGradeBoss = true
    end
    return IsGradeBoss
  end
end

function setUniform(job, playerPed)

  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then

      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end

      if job == 'bullet_wear' then
        SetPedArmour(playerPed, 100)
      end

    else

      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end

      if job == 'bullet_wear' then
        SetPedArmour(playerPed, 100)
      end

    end

  end)
end

-- Cloackroom
function OpenCloakroomMenu()

    --local playerPed = PlayerPedId()
  --local grade = PlayerData.job.grade_name

  local elements = {
    {label = _U('emploie_outfit'), value = 'emploie_outfit'},
  {label = _U('citizen_wear'), value = 'citizen_wear'},
  {label = 'Luotiliivit', value = 'gilet'},
  }
  --if PlayerData.job.grade_name == 'bogyguard' then
    --table.insert(elements, {label = 'Luotiliivit', value = 'gilet'})
  --end
  ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'cloakroom',
      {
        title    = _U('cloakroom'),
        align    = 'bottom-right',
        elements = elements,
        },

        function(data, menu)
      

    if data.current.value == 'citizen_wear' then
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
        in_service = false
        onDuty = false
        local playerPed = GetPlayerPed(-1)
        SetPedArmour(playerPed, 0)
        TriggerServerEvent('esx_service:disableService', 'gouvernor')
      end)
      end
    if data.current.value == 'emploie_outfit' then
      ESX.TriggerServerCallback('esx_service:enableService', function(toogle, nb)
        if toogle == true then
          ESX.ShowNotification("Aloitit työt, paikalla " .. nb-1 .. " työkaveria")
          in_service = true
          onDuty = true
        else
          in_service = false
          ESX.ShowNotification("Et ole töissä täällä")
        end
          end, 'gouvernor')
      end
    if data.current.value == 'gilet' then
    local playerPed = GetPlayerPed(-1)
    SetPedArmour(playerPed, 100)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
      if skin.sex == 0 then
        SetPedComponentVariation(playerPed, 9, 4, 1, 2) 
      else
        SetPedComponentVariation(playerPed, 9, 6, 1, 2)
      end
    end)
    ESX.ShowNotification("Laitoit luotiliivit")
    end
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloakroom')
      CurrentActionData = {}
    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloakroom')
      CurrentActionData = {}
    end
    )
end

function OpenVaultMenu()

  if Config.EnableVaultManagement then

    local elements = {
      {label = _U('get_weapon'), value = 'get_weapon'},
      {label = _U('put_weapon'), value = 'put_weapon'},
      {label = _U('get_object'), value = 'get_stock'},
      {label = _U('put_object'), value = 'put_stock'}
    }

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vault',
      {
        title    = _U('vault'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'put_stock' then
           OpenPutStocksMenu()
        end

        if data.current.value == 'get_stock' then
           OpenGetStocksMenu()
        end
      end,
      function(data, menu)
        menu.close()

        CurrentAction     = 'menu_vault'
        CurrentActionMsg  = _U('open_vault')
        CurrentActionData = {}
      end
    )
  end
end

function OpenVehicleSpawnerMenu()

    local elements = {
        {label = 'Ota ajoneuvo', value = 'vehicle_list'},
    }

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'menu_vehicle_spawner',
        {
            title = 'Gouvernement',
            elements = elements
        },
        function(data, menu)
            if data.current.value == 'vehicle_list' then
                if Config.EnableSocietyOwnedVehicles then
                    local elements = {}
                    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
                        for i = 1, #vehicles, 1 do
                            table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
                        end

                        ESX.UI.Menu.Open(
                            'default', GetCurrentResourceName(), 'vehicle_spawner',
                            {
                                title = _U('service_vehicle'),
                                align = 'bottom-right',
                                elements = elements,
                            },
                            function(data, menu)
                                menu.close()
                                local vehicleProps = data.current.value
                                ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
                                    ESX.Game.SetVehicleProperties(vehicle, {plate = "GOUV" .. PLATE, health = 1000})
                                    local playerPed = GetPlayerPed(-1)
                                    TaskWarpPedIntoVehicle(playerPed, vehicle, - 1)
                                end)
                                TriggerServerEvent('esx_society:removeVehicleFromGarage', 'banque', vehicleProps)
                            end,
                            function(data, menu)
                                menu.close()
                            end
                        )
                    end, 'banque')
                else
                    local elements = {
              { value = 'schafter5',  label = 'schafter limo' },
              { value = 'cog552',  label = 'Berline 2' },
                    }

                    ESX.UI.Menu.CloseAll()
                    ESX.UI.Menu.Open(
                        'default', GetCurrentResourceName(), 'spawn_vehicle',
                        {
                            title = 'Ota ajoneuvo',
                            elements = elements
                        },
                        function(data, menu)
                            for i = 1, #elements, 1 do
                                if Config.MaxInService == -1 then
                                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 89.72, function(vehicle)
                                        ESX.Game.SetVehicleProperties(vehicle, {plate = "VALTIO" .. PLATE, health = 1000})
                                        local playerPed = GetPlayerPed(-1)
                                        TaskWarpPedIntoVehicle(playerPed, vehicle, - 1)
                                    end)
                                    break
                                else
                                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
                                        if canTakeService then
                                                ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 89.72, function(vehicle)
                                                    ESX.Game.SetVehicleProperties(vehicle, {plate = "VALTIO" .. PLATE, health = 1000})
                                                    local playerPed = GetPlayerPed(-1)
                                                    TaskWarpPedIntoVehicle(playerPed, vehicle, - 1)
                                                end)
                                        else
                                            ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
                                        end
                                    end, 'gouvernor')
                                    break
                                end
                            end
                            menu.close()
                        end,
                        function(data, menu)
                            menu.close()
                            OpenVehicleSpawnerMenu()
                        end
                    )
            end
        end
    end,
    function(data, menu)
    menu.close()
    CurrentAction = 'menu_vehicle_spawner'
    CurrentActionMsg = _U('open_actions')
    CurrentActionData = {}
    end
  )
end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_gouvernor:getStockItems', function(items)

    -- print(json.encode(items))
    local elements = {}
    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('gouvernor_stock'),
        elements = elements
      },
      function(data, menu)
        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)
            local count = tonumber(data2.value)
            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()
              TriggerServerEvent('esx_gouvernor:getStockItem', itemName, count)
            end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('esx_gouvernor:getPlayerInventory', function(inventory)

    local elements = {}
    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        elements = elements
      },
      function(data, menu)
        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)
            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_gouvernor:putStockItems', itemName, count)
            end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_gouvernor:getVaultWeapons', function(weapons)
    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vault_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
        menu.close()

        ESX.TriggerServerCallback('esx_gouvernor:removeVaultWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do
    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vault_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_gouvernor:addVaultWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)
    end,
    function(data, menu)
      menu.close()
    end
  )
end

AddEventHandler('esx_gouvernor:hasEnteredMarker', function(zone)

    if zone == 'BossActions' and IsGradeBoss() then
      CurrentAction     = 'menu_boss_actions'
      CurrentActionMsg  = _U('open_bossmenu')
      CurrentActionData = {}
    end

    if zone == 'Cloakrooms' then
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
  
  if zone == 'Helicopters' then
      CurrentAction     = 'menu_Helicopters'
      CurrentActionMsg  = _U('vehicle_spawner')
      CurrentActionData = {}
    end

    if Config.EnableVaultManagement then
      if zone == 'Vaults' then
        CurrentAction     = 'menu_vault'
        CurrentActionMsg  = _U('open_vault')
        CurrentActionData = {}
      end
    end

    if zone == 'Vehicles' then
      CurrentAction     = 'menu_vehicle_spawner'
      CurrentActionMsg  = _U('vehicle_spawner')
      CurrentActionData = {}
    end

    if zone == 'VehicleDeleters' then

      local playerPed = GetPlayerPed(-1)
      if IsPedInAnyVehicle(playerPed,  false) then
        local vehicle = GetVehiclePedIsIn(playerPed,  false)

        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end
    end

    if Config.EnableHelicopters then

      if zone == 'HelicopterDeleters' then

        local playerPed = GetPlayerPed(-1)

        if IsPedInAnyVehicle(playerPed,  false) then

          local vehicle = GetVehiclePedIsIn(playerPed,  false)

          CurrentAction     = 'delete_vehicle'
          CurrentActionMsg  = _U('store_vehicle')
          CurrentActionData = {vehicle = vehicle}
        end
      end
    end
end)

AddEventHandler('esx_gouvernor:hasExitedMarker', function(zone)

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)

-- Create blips
Citizen.CreateThread(function()

  local blipMarker = Config.Blips.Blip
  local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

  SetBlipSprite (blipCoord, blipMarker.Sprite)
  SetBlipDisplay(blipCoord, blipMarker.Display)
  SetBlipScale  (blipCoord, blipMarker.Scale)
  SetBlipColour (blipCoord, blipMarker.Colour)
  SetBlipAsShortRange(blipCoord, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(_U('map_blip'))
  EndTextCommandSetBlipName(blipCoord)
end)

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsJobTrue() then

      local coords = GetEntityCoords(GetPlayerPed(-1))

      for k,v in pairs(Config.Zones) do
        if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, false, false, false, false)
        end
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do

    Wait(0)
    if IsJobTrue() then

      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil

      for k,v in pairs(Config.Zones) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end

      if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
        TriggerEvent('esx_gouvernor:hasEnteredMarker', currentZone)
      end

      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_gouvernor:hasExitedMarker', LastZone)
      end
    end
  end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
  
    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0,  Keys['E']) and IsJobTrue() then

        if CurrentAction == 'menu_cloakroom' then
            OpenCloakroomMenu()
        end
    
    if CurrentAction == 'menu_Helicopters' then
      local helicopters = Config.Zones.Helicopters
      if not IsAnyVehicleNearPoint(helicopters.SpawnPoint.x, helicopters.SpawnPoint.y, helicopters.SpawnPoint.z,  3.0) then

        ESX.Game.SpawnVehicle('Supervolito2', {
        x = helicopters.SpawnPoint.x,
        y = helicopters.SpawnPoint.y,
        z = helicopters.SpawnPoint.z
        }, helicopters.Heading, function(vehicle)
        SetVehicleModKit(vehicle, 0)
        SetVehicleLivery(vehicle, 0)
        end)
      end
    end

        if CurrentAction == 'menu_vault' then
            OpenVaultMenu()
        end

        if CurrentAction == 'menu_fridge' then
            OpenFridgeMenu()
        end

        if CurrentAction == 'menu_shop' then
            OpenShopMenu(CurrentActionData.zone)
        end

        if CurrentAction == 'menu_vehicle_spawner' then
            OpenVehicleSpawnerMenu()
        end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then

            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicleInGarage', 'gouvernor', vehicleProps)
          else

            if
              GetEntityModel(vehicle) == GetHashKey('gouvernorbus')
            then
              TriggerServerEvent('esx_service:disableService', 'gouvernor')
            end
          end
          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end

        if CurrentAction == 'menu_boss_actions' and IsGradeBoss() then

          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_society:openBossMenu', 'gouvernor', function(data, menu)

            menu.close()
            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}
          end)
        end
        CurrentAction = nil
      end
    end
  if IsControlPressed(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'gouvernor' then
    if in_service == true then
      OpenGouvMenu()
    end
    end
  end
end)

local GouvGestionOpen = false
function openGui2()
  SetNuiFocus(true)
  SendNUIMessage({openGGestion = true})
end

function closeGui2()
  SetNuiFocus(false)
  SendNUIMessage({openGGestion = false})
  GouvGestionOpen = false
end

function OpenGouvMenu()

    local elements = {
    {label = _U('billing'),        value = 'billing'},
    }
    if Config.EnablePlayerManagement and PlayerData.job ~= nil then
    if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'secretary' or PlayerData.job.grade_name == 'minister' or PlayerData.job.grade_name == 'bogyguard' then
      table.insert(elements, {label = "Henkilöntoiminnot", value = 'citizen_interaction'})
    end
    if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'secretary' or PlayerData.job.grade_name == 'minister' then
      table.insert(elements, {label = "Ilmoita kansalaisille", value = 'alert'})
      table.insert(elements, {label = 'Valtion hallinta', value = 'gouv_gestion'})
    end
    end 

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'banque_menu',
        {
            title = _U('banquic'),
            elements = elements
        },
        function(data, menu)
      if data.current.value == 'gouv_gestion' then
    menu.close()
     if GouvGestionOpen then
        closeGui2()
        GouvGestionOpen = false
      else
        openGui2()
        GouvGestionOpen = true
      end
      end
    if data.current.value == 'alert' then
      ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'Gouv_alert',
                {
                  title    = "Ilmoituksen tyyppi :",
                  align    = 'bottom-right',
                  elements = {
                    {label = "Äänestä", type = 'Gvote'},
                    {label = "Sota",       type = 'Gguerre'},
                    {label = "Hyökkäys kaupungissa",            type = 'Gextraterre'},
                    {label = "Oma hälytys",         type = 'Gcustom'}
                  },
                },
                function(data3, menu3)
                  menu3.close()
                  TriggerEvent('LSPD_alerte:show', data3.current)
                end,
              function(data3, menu3)
                menu3.close()
              end)
      end
    
    if data.current.value == 'citizen_interaction' then

        local els = {
          {label = _U('id_card'),                 value = 'identity_card'},
          {label = _U('search'),                  value = 'body_search'},
          {label = _U('handcuff'),                  value = 'handcuff'},
          {label = _U('drag'),                    value = 'drag'},
          {label = _U('put_in_vehicle'),          value = 'put_in_vehicle'},
          {label = _U('out_the_vehicle'),         value = 'out_the_vehicle'}
        }
        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = 'Interaction Citoyen',
            align    = 'bottom-right',
            elements = els,
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()
              if distance ~= -1 and distance <= 3.0 then

                if data2.current.value == 'identity_card' then
                    TriggerServerEvent('gc:showIdentityOther', GetPlayerServerId(player))
                end

                if data2.current.value == 'body_search' then
                  OpenBodySearchMenu(player)
                end
                if data2.current.value == 'handcuff' then
			    	TriggerServerEvent('gouv:handcuff', GetPlayerServerId(player))
			    end

                if data2.current.value == 'drag' then
                  TriggerServerEvent('gouv:drag', GetPlayerServerId(player))
                end

                if data2.current.value == 'put_in_vehicle' then
                  TriggerServerEvent('gouv:putInVehicle', GetPlayerServerId(player))
                end

                if data2.current.value == 'out_the_vehicle' then
                    TriggerServerEvent('gouv:OutVehicle', GetPlayerServerId(player))
                end
        
              else
                ESX.ShowNotification(_U('no_players_nearby'))
              end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end
    
    if data.current.value == 'billing' then
          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'billing',
            {
              title = _U('invoice_amount')
            },
            function(data, menu)
              local amount = tonumber(data.value)
              if amount == nil then
                ESX.ShowNotification(_U('amount_invalid'))
              else
                menu.close()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                  ESX.ShowNotification(_U('no_players_nearby'))
                else
                  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_banque', 'gouvernor', amount)
                end
              end
            end,
          function(data, menu)
            menu.close()
          end
          )
        end

    end,
    function(data, menu)
    menu.close()
    end
  )
end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('gouvernor:getOtherPlayerData', function(data)
    local elements = {}
    TriggerServerEvent('gouv:sendNotif', GetPlayerServerId(player), '~o~Agentti tutkii sinua')
    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = _U('confiscate_dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Aseet ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then
          TriggerServerEvent('gouv:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
          OpenBodySearchMenu(player)
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
  end, GetPlayerServerId(player))
end

RegisterNetEvent('gouvernor:handcuff')
AddEventHandler('gouvernor:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
    end
  end)
end)

RegisterNetEvent('gouv:drag')
AddEventHandler('gouv:drag', function(cop)
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(10)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('gouv:putInVehicle')
AddEventHandler('gouv:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end
    end
  end
end)

RegisterNetEvent('gouv:OutVehicle')
AddEventHandler('gouv:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if GouvGestionOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(10)
  end
end)
-- TELEPORTERS
AddEventHandler('esx_gouvernor:teleportMarkers', function(position)
  SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
end)

-- Show top left hint
Citizen.CreateThread(function()
  while true do
    Wait(10)
    if hintIsShowed == true then
      SetTextComponentFormat("STRING")
      AddTextComponentString(hintToDisplay)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
  end
end)

-- Display teleport markers
Citizen.CreateThread(function()
  while true do
    Wait(10)

    if IsJobTrue() then

      local coords = GetEntityCoords(GetPlayerPed(-1))
      for k,v in pairs(Config.TeleportZones) do
        if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)

-- Activate teleport marker
Citizen.CreateThread(function()
  while true do
    Wait(10)
    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local position    = nil
    local zone        = nil

    if IsJobTrue() then

      for k,v in pairs(Config.TeleportZones) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInPublicMarker = true
          position = v.Teleport
          zone = v
          break
        else
          isInPublicMarker  = false
        end
      end

      if IsControlJustReleased(0, Keys["E"]) and isInPublicMarker then
        TriggerEvent('esx_gouvernor:teleportMarkers', position)
      end

      -- hide or show top left zone hints
      if isInPublicMarker then
        hintToDisplay = zone.Hint
        hintIsShowed = true
      else
        if not isInMarker then
          hintToDisplay = "Ei vihjettä näytettäväksi"
          hintIsShowed = false
        end
      end
    end
  end
end)

RegisterNetEvent('esx_gouvernor:btnI1re')
AddEventHandler('esx_gouvernor:btnI1re', function(listimpot)
  SendNUIMessage({
  openSection = "openbtnI1",
  list = listimpot
  })
end)

RegisterNetEvent('esx_gouvernor:btnI4re')
AddEventHandler('esx_gouvernor:btnI4re', function(listbenef)
  SendNUIMessage({
  openSection = "openbtnI4",
  list = listbenef
  })
end)

RegisterNetEvent('esx_gouvernor:btnE1re')
AddEventHandler('esx_gouvernor:btnE1re', function(listent)
  SendNUIMessage({
  openSection = "openbtnE1",
  list = listent
  })
end)

RegisterNUICallback('close', function(data, cb)
  closeGui2()
  cb('ok')
end)

RegisterNUICallback('btnI1', function(data, cb)
  TriggerServerEvent("esx_gouvernor:btnI1")
  cb('ok')
end)
RegisterNUICallback('btnI2result', function(data, cb)
  TriggerServerEvent("esx_gouvernor:btnI2", data.type, data.nom, data.montant)
  cb('ok')
end)
RegisterNUICallback('btnI3result', function(data, cb)
  TriggerServerEvent("esx_gouvernor:btnI3", data.id)
  cb('ok')
end)
RegisterNUICallback('btnI4', function(data, cb)
  TriggerServerEvent("esx_gouvernor:btnI4")
  cb('ok')
end)

RegisterNUICallback('btnE1', function(data, cb)
  TriggerServerEvent("esx_gouvernor:btnE1")
  cb('ok')
end)

RegisterNUICallback('btnE3result', function(data, cb)
  TriggerServerEvent("esx_gouvernor:btnE3", data.nom)
  cb('ok')
end)

RegisterNetEvent('plate:setPlate')
AddEventHandler('plate:setPlate', function(a)
    PLATE = a
end)

Citizen.CreateThread(function()
    Citizen.Wait(10)
--  local blip = AddBlipForCoord(113.148, -755.85, 45.00)
  SetBlipSprite(blip, 79)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Tuomioistuin")
  EndTextCommandSetBlipName(blip)
end)