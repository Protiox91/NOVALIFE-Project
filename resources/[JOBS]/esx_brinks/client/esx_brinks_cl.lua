local Keys = {["F6"] = 167, ["E"] = 38, ["DELETE"] = 178}
local isLoading         = true

ESX                     = nil
local playerData        = nil
local coords            = nil
local inVehicle         = false

local zoneList          = {} -- { {enable, gps, markerD, blipD, blip, name}, ...}
local alreadyInZone     = false
local lastZone          = nil

local currentAction     = nil
local currentActionMsg  = ''
local currentActionData = {}

local isWorking         = false
local isRunning         = false
local currentRun        = {}

-- debug msg
function printDebug(msg)
  if Config.debug then print(Config.debugPrint .. ' ' .. msg) end
end

-- init
Citizen.CreateThread(function()
  local startLoad = GetGameTimer()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(5)
  end
  -- load player
  while playerData == nil do
    Citizen.Wait(20)
    playerData = ESX.GetPlayerData()
  end
  while playerData.job == nil do
    Citizen.Wait(20)
    playerData = ESX.GetPlayerData()
  end
  while playerData.job.name == nil do
    Citizen.Wait(20)
    playerData = ESX.GetPlayerData()
  end
  coords     = GetEntityCoords(GetPlayerPed(-1))
  inVehicle  = false
  -- load zone
  for k,v in pairs(Config.zones) do
    local zone = v
    zone.name = k
    if k == 'cloakRoom' then zone.blip = drawBlip(zone.gps, zone.blipD)
    else zone.blip = nil end
    table.insert(zoneList, zone)
  end
  -- init end
  isLoading = false
  printDebug('Loaded in ' .. tostring(GetGameTimer() - startLoad) .. 'ms')
end)

-- MAIN
Citizen.CreateThread(function()
  while isLoading do Citizen.Wait(45) end
  while true do
    Citizen.Wait(250)
    -- refresh playerData ...
    local playerPed = GetPlayerPed(-1)
    playerData = ESX.GetPlayerData()
    coords     = GetEntityCoords(playerPed)
    inVehicle  = IsPedInAnyVehicle(playerPed, 0)
    -- quit job
    if isWorking and playerData.job.name ~= Config.jobName then isWorking = false end
    if isRunning and playerData.job.name ~= Config.jobName then isRunning = false end
    -- refresh zone
    for i=1, #zoneList, 1 do
      -- disable zone for old employees
      if playerData.job.name ~= Config.jobName and zoneList[i].enable then zoneList[i].enable = false
      -- enable cloakroom zone for new employees
      elseif playerData.job.name == Config.jobName and not zoneList[i].enable and zoneList[i].name == 'cloakRoom' then zoneList[i].enable = true end
    end
    -- others
  end
end)

-- blip
function drawBlip(gps, blipData)
  if not (blipData.name == nil) then printDebug('drawBlip: '.. blipData.name)
  else printDebug('drawBlip: market') end
  
  local blip = AddBlipForCoord(gps.x, gps.y, gps.z)
  if not (blipData.sprite == nil)  then SetBlipSprite (blip, blipData.sprite)     end
  if not (blipData.display == nil) then SetBlipDisplay(blip, blipData.display)    end
  if not (blipData.scale == nil)   then SetBlipScale  (blip, blipData.scale)      end
  if not (blipData.color == nil)   then SetBlipColour (blip, blipData.color)      end
  if not (blipData.range == nil)   then SetBlipAsShortRange(blip, blipData.range) end
  if not (blipData.route == nil)   then SetBlipRoute(blip, blipData.route)        end
  if not (blipData.name == nil)    then
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blipData.name)
    EndTextCommandSetBlipName(blip)
  end
  return blip
end
Citizen.CreateThread(function()
  while isLoading do Citizen.Wait(10) end
  while true do
    Citizen.Wait(3000)
    for i=1, #zoneList, 1 do
      -- for employees
      if playerData.job.name == Config.jobName then
        -- draw blip
        if zoneList[i].enable and not DoesBlipExist(zoneList[i].blip) then zoneList[i].blip = drawBlip(zoneList[i].gps, zoneList[i].blipD)
        -- remove blip execpt cloakroom
        elseif not zoneList[i].enable and DoesBlipExist(zoneList[i].blip) and zoneList[i].name ~= 'cloakRoom' then 
          RemoveBlip(zoneList[i].blip)
          zoneList[i].blip = nil
          printDebug('remove Blip: '.. zoneList[i].name)
        end
      -- for civil
      else
        -- remove blip execpt cloakroom
        if zoneList[i].name ~= 'cloakRoom' and DoesBlipExist(zoneList[i].blip) then 
          RemoveBlip(zoneList[i].blip)
          zoneList[i].blip = nil
          printDebug('remove Blip: '.. zoneList[i].name)
        end
      end
    end
  end
end)

-- marker
function showMarker(zone)
  DrawMarker(zone.markerD.type, 
    zone.gps.x, zone.gps.y, zone.gps.z, 
    0.0, 0.0, 0.0, 
    0, 0.0, 0.0, 
    zone.markerD.size.x , zone.markerD.size.y , zone.markerD.size.z, 
    zone.markerD.color.r, zone.markerD.color.g, zone.markerD.color.b, 100, 
    false, false, 2, false, false, false, false
  )
end
Citizen.CreateThread(function()
  while isLoading do Citizen.Wait(10) end
  while true do
    Citizen.Wait(75)
    if playerData.job.name == Config.jobName then
      for i=1, #zoneList, 1 do
        if zoneList[i].enable and GetDistanceBetweenCoords(coords, zoneList[i].gps.x, zoneList[i].gps.y, zoneList[i].gps.z, true) < zoneList[i].markerD.drawDistance then
          showMarker(zoneList[i])
        end
      end
    end
  end
end)

-- enter/exit zone
AddEventHandler('esx_brinks:hasEnteredMarker', function(zone)
  printDebug('hasEnteredMarker: ' .. zone.name)
  if zone.name == 'cloakRoom' then
    currentAction = 'brinksMenu'
    currentActionMsg = _U('cloakroom_action')
    currentActionData = {}
  elseif zone.name == 'vehicleSpawner' then
    currentAction = 'vehiclespawn_menu'
    currentActionMsg = _U('vehicleSpawner_action')
    currentActionData = {}
  elseif zone.name == 'market' then
    currentAction = 'harvestRun'
    currentActionMsg = _U('market_action')
    currentActionData = {}
  elseif zone.name == 'bank' then
    currentAction = 'sellRun'
    currentActionMsg = _U('bank_action')
    currentActionData = {}
  elseif zone.name == 'northBank' then
    currentAction = 'collectWeekly'
    currentActionMsg = _U('weeklyHarvest_action')
    currentActionData = {}
  elseif zone.name == 'unionDepository' then
    currentAction = 'destructWeekly'
    currentActionMsg = _U('weeklyDestruct_action')
    currentActionData = {}
  elseif zone.name == 'vehicleDeleter' then
    if inVehicle then
      currentAction = 'delete_vehicle'
      currentActionMsg = _U('vehicleDeleter_action')
      currentActionData = {}
    end
  end
end)
AddEventHandler('esx_brinks:hasExitedMarker', function(zone)
  printDebug('hasExitedMarker: ' .. zone.name)
  if zone.name == 'market' then TriggerServerEvent('esx_brinks:stopHarvestRun') 
  elseif zone.name == 'bank' then TriggerServerEvent('esx_brinks:stopSellRun') 
  elseif zone.name == 'northBank' then TriggerServerEvent('esx_brinks:stopWeeklyCollect') 
  elseif zone.name == 'unionDepository' then TriggerServerEvent('esx_brinks:stopWeeklyDestruct') end
  currentAction    = nil
  currentActionMsg = ''
  ESX.UI.Menu.CloseAll()
end)
Citizen.CreateThread(function()
  while isLoading do Citizen.Wait(10) end
  while true do
    Citizen.Wait(50)
    if playerData.job.name == Config.jobName then
      local isInMarker  = false
      local currentZone = nil
      for i=1, #zoneList, 1 do
        if zoneList[i].enable and GetDistanceBetweenCoords(coords, zoneList[i].gps.x, zoneList[i].gps.y, zoneList[i].gps.z, true) < zoneList[i].markerD.size.x * 0.75 then
          isInMarker    = true
          currentZone   = zoneList[i]
        end
      end
      if isInMarker and not alreadyInZone then
        alreadyInZone = true
        lastZone      = currentZone
        TriggerEvent('esx_brinks:hasEnteredMarker', currentZone)
      end
      if not isInMarker and alreadyInZone then
        alreadyInZone = false
        TriggerEvent('esx_brinks:hasExitedMarker', lastZone)
      end
    end
  end
end)

-- action
Citizen.CreateThread(function()
  while isLoading do Citizen.Wait(45) end
  while true do
    Citizen.Wait(75)
    if IsControlJustReleased(1, Keys["F6"]) and playerData.job.name == Config.jobName then openMobileBrinksMenu() end
    if currentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(currentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, - 1)
      if IsControlJustReleased(1, Keys["E"]) then
        if currentAction     == 'brinksMenu' then
          if not inVehicle then openBrinksActionsMenu() 
          else ESX.ShowNotification(_U('in_vehicle')) end
        elseif currentAction == 'vehiclespawn_menu' then
          if not inVehicle then vehicleMenu() 
          else ESX.ShowNotification(_U('in_vehicle')) end
        elseif currentAction == 'harvestRun' then
          if not inVehicle then
            TriggerServerEvent('esx_brinks:startHarvestRun')
          else ESX.ShowNotification(_U('in_vehicle')) end
        elseif currentAction == 'sellRun' then
          if not inVehicle then TriggerServerEvent('esx_brinks:startSellRun')
          else ESX.ShowNotification(_U('in_vehicle')) end
        elseif currentAction == 'collectWeekly' then
          if not inVehicle then 
            if playerData.job.grade >= Config.weeklyMinGrade then TriggerServerEvent('esx_brinks:startWeeklyCollect')
            else ESX.ShowNotification(_U('bad_grade')) end 
          else ESX.ShowNotification(_U('in_vehicle')) end
        elseif currentAction == 'destructWeekly' then
          if not inVehicle then 
            if playerData.job.grade >= Config.weeklyMinGrade then TriggerServerEvent('esx_brinks:startWeeklyDestruct')
            else ESX.ShowNotification(_U('bad_grade')) end 
          else ESX.ShowNotification(_U('in_vehicle')) end
        elseif currentAction == 'delete_vehicle' then
          if inVehicle then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local hash = GetEntityModel(vehicle)
            local plate = string.gsub(GetVehicleNumberPlateText(vehicle), " ", "")
            if string.find (plate, Config.platePrefix) then
              if hash == GetHashKey(Config.vehicles.truck.hash) or hash == GetHashKey(Config.vehicles.bossCar.hash) then
                if GetVehicleEngineHealth(vehicle) <= 500 or GetVehicleBodyHealth(vehicle) <= 500 then ESX.ShowNotification(_U('vehicle_broken'))
                else DeleteVehicle(vehicle) end
              end
            else ESX.ShowNotification(_U('bad_vehicle')) end
          end
        end
        currentAction = nil
      end
    end
  end
end)

-- take service
function takeService(work, value)
  printDebug('takeService ' .. value)
  isWorking = work
  -- enable/disable zone except market
  for i=1, #zoneList, 1 do
    if zoneList[i].name == 'vehicleSpawner' or 
       zoneList[i].name == 'vehicleDeleter' or 
       zoneList[i].name == 'bank' or 
       zoneList[i].name == 'northBank' or 
       zoneList[i].name == 'unionDepository'
    then 
       zoneList[i].enable = isWorking
    end
  end
  -- take service
  if isWorking then
    local playerPed = GetPlayerPed(-1)
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
        if Config.uniforms[value].male ~= nil then TriggerEvent('skinchanger:loadClothes', skin, Config.uniforms[value].male)
        else ESX.ShowNotification(_U('no_outfit')) end
      else
        if Config.uniforms[value].female ~= nil then TriggerEvent('skinchanger:loadClothes', skin, Config.uniforms[value].female)
        else ESX.ShowNotification(_U('no_outfit')) end
      end
    end)
    -- SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
  -- end service
  else
    -- disable market
    for i=1, #zoneList, 1 do
      if zoneList[i].name == 'market' then 
        zoneList[i].enable = false
        isRunning = false
        break
      end
    end
    -- change wear
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
      local model = nil
      if skin.sex == 0 then model = GetHashKey("mp_m_freemode_01")
      else model = GetHashKey("mp_f_freemode_01") end
      RequestModel(model)
      while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
      end
      SetPlayerModel(PlayerId(), model)
      SetModelAsNoLongerNeeded(model)
      TriggerEvent('skinchanger:loadSkin', skin)
      TriggerEvent('esx:restoreLoadout')
      local playerPed = GetPlayerPed(-1)
      -- SetPedArmour(playerPed, 0)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
    end)
  end
end

-- menu brinks
function openBrinksActionsMenu()
  printDebug('openBrinksActionsMenu')
  local elements = {}  
  if isWorking then table.insert(elements, {label = _U('end_service'), value = 'citizen_wear'})
  else table.insert(elements, {label = _U('take_service'), value = 'job_wear'}) end  
  if playerData.job.grade >= Config.storageMinGrade then 
    table.insert(elements, {label = _U('storage'),   value = 'storage'})
  end
  if playerData.job.grade >= Config.manageMinGrade then table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'}) end
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'brinks_actions',
    {
      css = 'job',
      title    = _U('cloakroom_blip'),
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'citizen_wear' then
        menu.close()
        takeService(false, data.current.value)
        openBrinksActionsMenu()
        ESX.ShowNotification(_U('end_service_notif'))
      elseif data.current.value == 'job_wear' then
        menu.close()
        takeService(true, data.current.value)
        openBrinksActionsMenu()
        ESX.ShowNotification(_U('take_service_notif'))
        ESX.ShowNotification(_U('start_job'))
      elseif data.current.value == 'storage' then
        menu.close()
        openBrinksStorageMenu()
      elseif data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'brinks', function(data, menu)
          menu.close()
        end)
      end
    end,
    function(data, menu)
      menu.close()
      TriggerEvent('esx_brinks:hasEnteredMarker', lastZone)
    end
  )
end
function openBrinksStorageMenu()
  printDebug('openBrinksStorageMenu')
  local elements = {}    
  table.insert(elements, {label = _U('deposit_stock'),   value = 'put_stock'})
  table.insert(elements, {label = _U('withdraw_stock'),  value = 'get_stock'})
  if playerData.job.grade >= Config.armoryMinGrade then 
    table.insert(elements, {label = _U('deposit_weapon'),   value = 'put_weapon'})
    table.insert(elements, {label = _U('withdraw_weapon'),  value = 'get_weapon'})
  end
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'brinks_storage',
    {
      css = 'job',
      title    = _U('storage'),
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'put_stock' then
        openPutStocksMenu()
      elseif data.current.value == 'get_stock' then
        openGetStocksMenu()
      elseif data.current.value == 'put_weapon' then
        openPutWeaponMenu()
      elseif data.current.value == 'get_weapon' then
        openGetWeaponMenu()
      end
    end,
    function(data, menu)
      menu.close()
      openBrinksActionsMenu()
    end
  )
  
end
function openGetStocksMenu()
  printDebug('openGetStocksMenu')
  ESX.TriggerServerCallback('esx_brinks:getStockItems', function(items)
    local elements = {}
    for i=1, #items, 1 do
      if items[i].count ~= 0 then
        table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
      end
    end
    if #elements == 0 then table.insert(elements, {label = 'empty', type = 'empty', value = 'empty'}) end
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'stocks_menu',
    {
      css = 'job',
      title    = _U('withdraw_stock'),
      elements = elements
    },
    function(data, menu)
      if data.current.value ~= 'empty' then
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
              TriggerServerEvent('esx_brinks:getStockItem', itemName, count)
              openGetStocksMenu()
            end
          end,
          function(data2, menu2)
            menu2.close()
          end
        )
      end
    end,
    function(data, menu)
      menu.close()
    end
    )
  end)
end
function openPutStocksMenu()
  printDebug('openPutStocksMenu')
  ESX.TriggerServerCallback('esx_brinks:getPlayerInventory', function(inventory)
    local elements = {}
    for i=1, #inventory.items, 1 do
      local item = inventory.items[i]
      if item.count > 0 then table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name}) end
    end
    if #elements == 0 then table.insert(elements, {label = 'empty', type = 'empty', value = 'empty'}) end
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
      css = 'job',
      title    = _U('deposit_stock'),
      elements = elements
      },
      function(data, menu)
        if data.current.value ~= 'empty' then
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
                TriggerServerEvent('esx_brinks:putStockItems', itemName, count)
                openPutStocksMenu()
              end
            end,
            function(data2, menu2)
              menu2.close()
            end
          )
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end
function openGetWeaponMenu()
  printDebug('openPutWeaponMenu')
  ESX.TriggerServerCallback('esx_brinks:getArmoryWeapons', function(weapons)
    local elements = {}
    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end
    if #elements == 0 then table.insert(elements, {label = 'empty', value = 'empty'}) end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
    {
      css = 'job',
      title    = _U('withdraw_weapon'),
      align    = 'top-left',
      elements = elements
    }, 
    function(data, menu)
      if data.current.value ~= 'empty' then
        menu.close()
        ESX.TriggerServerCallback('esx_brinks:removeArmoryWeapon', function() openGetWeaponMenu() end, data.current.value)
      end
    end, 
    function(data, menu)
      menu.close()
    end)
  end)

end
function openPutWeaponMenu()
  printDebug('openPutWeaponMenu')
  local elements   = {}
  local playerPed  = PlayerPedId()
  local weaponList = ESX.GetWeaponList()
  for i=1, #weaponList, 1 do
    local weaponHash = GetHashKey(weaponList[i].name)
    if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end
  end
  if #elements == 0 then table.insert(elements, {label = 'empty', value = 'empty'}) end
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
  {
    css = 'job',
    title    = _U('deposit_weapon'),
    align    = 'top-left',
    elements = elements
  }, 
  function(data, menu)
    if data.current.value ~= 'empty' then
      menu.close()
      ESX.TriggerServerCallback('esx_brinks:addArmoryWeapon', function() openPutWeaponMenu() end, data.current.value, true)
    end
  end, function(data, menu)
    menu.close()
  end)
end

-- menu Vehicle
function vehicleMenu()
  local elements = { {label = Config.vehicles.truck.label, value = Config.vehicles.truck} }
  if playerData.job.grade >= Config.armoryMinGrade then table.insert(elements, {label = Config.vehicles.bossCar.label, value = Config.vehicles.bossCar})end
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle',
    {
      css = 'job',
      title = _U('vehicle_menu_title'),
      elements = elements
    },
    function(data, menu)
        local playerPed = GetPlayerPed(-1)
        local gps = Config.zones.vehicleSpawnPoint.gps
        local heading = Config.zones.vehicleSpawnPoint.markerD.heading
        local plate = Config.platePrefix .. math.random(10, 99)
        ESX.Game.SpawnVehicle(data.current.value.hash, gps, heading, function(vehicle)
          if data.current.label == Config.vehicles.bossCar.label then SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0) end
          TaskWarpPedIntoVehicle(playerPed, vehicle, - 1)
          SetVehicleNumberPlateText(vehicle, plate)
        end)
        menu.close()
        TriggerEvent('esx_brinks:hasExitedMarker', lastZone)
    end,
    function(data, menu)
      menu.close()
      TriggerEvent('esx_brinks:hasEnteredMarker', lastZone)
    end
)
end

-- menu facturation
function openBrinksBilling()
  printDebug('openBrinksBilling')
  ESX.UI.Menu.Open(
    'dialog', GetCurrentResourceName(), 'billing',
    {
      title = _U('bill_amount')
    },
    function(data, menu)
      local amount = tonumber(data.value)
      if amount == nil then
        ESX.ShowNotification(_U('invalid_amount'))
      else              
        menu.close()              
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
          ESX.ShowNotification(_U('no_player_nearby'))
        else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_brinks', 'Brinks', amount)
        end
      end
    end,
  function(data, menu)
    menu.close()
  end
  )
end
function openMobileBrinksMenu()
  printDebug('openMobileBrinksMenu')
  ESX.UI.Menu.CloseAll()
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mobile_brinks_actions',
    {
      css = 'job',
      title    = _U('billing_title'),
      align    = 'top-left',
      elements = {
        {label = _U('billing'),   value = 'billing'},
      }
    },
    function(data, menu)
      if data.current.value == 'billing' then
        openBrinksBilling()
      end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

-- start/stop run
function randomizeList(list)
  local newlist = {}
  while #list > 0 do
    local index = GetRandomIntInRange(1, #list)
    table.insert(newlist, list[index])
    local tmpList = {}
    for i=1, #list, 1 do
      if i ~= index then table.insert(tmpList, list[i]) end
    end
    list = tmpList
  end
  return newlist
end
function genMarketList()
  local coordsList = {}
  -- liste random des quartiers
  local listQuartier = {}
  for i=1, #Config.market,1 do table.insert(listQuartier, i) end
  listQuartier = randomizeList(listQuartier)
  -- liste random des boites par quartier
  for i=1, #listQuartier, 1 do 
    local tmpList = randomizeList(Config.market[listQuartier[i]])
    for y=1, #tmpList,1 do table.insert(coordsList, tmpList[y]) end
  end
  currentRun = coordsList
  printDebug('genRunList: ' .. #currentRun)
end
RegisterNetEvent('esx_brinks:nextMarket')
AddEventHandler('esx_brinks:nextMarket', function()
  local tmpList = {}
  for i=1, #currentRun, 1 do
    if i ~= 1 then table.insert(tmpList, currentRun[i]) end
  end
  currentRun = tmpList
  if #currentRun == 0 then genMarketList() end
  for i=1, #zoneList, 1 do
    if zoneList[i].name == 'market' then 
      if DoesBlipExist(zoneList[i].blip) then RemoveBlip(zoneList[i].blip) end
      zoneList[i].gps = currentRun[1]
      zoneList[i].enable = true
      zoneList[i].blip = nil
      break
    end
  end
  ESX.ShowNotification(_U('gps_info'))
  printDebug('nextMarket: ' .. #currentRun)
end)
function startNativeRun()
  printDebug('startNativeRun: ' .. #currentRun)
  for i=1, #zoneList, 1 do
    if zoneList[i].name == 'market' then 
      zoneList[i].gps = currentRun[1]
      zoneList[i].enable = true
    end
  end
  ESX.ShowNotification(_U('gps_info'))
end
function stopNativeJob()
  printDebug('stopNativeJob: ' .. #currentRun)
  for i=1, #zoneList, 1 do
    if zoneList[i].name == 'market' then
      zoneList[i].enable = false
      break
    end
  end
  ESX.ShowNotification(_U('cancel_mission'))
end
Citizen.CreateThread(function()
  while isLoading do Citizen.Wait(10) end
  while true do
    Citizen.Wait(10)
    if IsControlJustReleased(1, Keys["DELETE"]) and isWorking then
      if #currentRun == 0 then genMarketList() end      
      if isRunning then
        stopNativeJob(true)
        isRunning = false
      else
        local playerPed = GetPlayerPed(-1)
        if inVehicle and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey(Config.vehicles.truck.hash)) then
          startNativeRun()
          isRunning = true
        else ESX.ShowNotification(_U('not_good_veh')) end
      end
    end
  end
end)

RegisterNetEvent("Brook:menubrinks")
AddEventHandler("Brook:menubrinks", function()
	openMobileBrinksMenu()
end)

