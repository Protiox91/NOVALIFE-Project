ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'gouvernor', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'gouvernor', 'gouvernor', 'society_gouvernor', 'society_gouvernor', 'society_gouvernor', {type = 'private'})


local players = {}

RegisterServerEvent("esx_gouvernor:addPlayer")
AddEventHandler("esx_gouvernor:addPlayer", function(jobName)
	local _source = source
	players[_source] = jobName
end)

RegisterServerEvent("esx_gouvernor:sendSonnette")
AddEventHandler("esx_gouvernor:sendSonnette", function()
	local _source = source
	for i,k in pairs(players) do
		if(k~=nil) then
			if(k == "gouvernor") then
				TriggerClientEvent("esx_gouvernor:sendRequest", i, GetPlayerName(_source), _source)
			end
		end
	end
end)

RegisterServerEvent("esx_gouvernor:sendStatusToPoeple")
AddEventHandler("esx_gouvernor:sendStatusToPoeple", function(id, status)
	TriggerClientEvent("esx_gouvernor:sendStatus", id, status)
end)

RegisterServerEvent('esx_gouvernor:btnI1')
AddEventHandler('esx_gouvernor:btnI1', function()
	local _source = source
	local result = MySQL.Sync.fetchAll('SELECT id, name, montant, job FROM gouv_taxe')
	TriggerClientEvent('esx_gouvernor:btnI1re', _source, result)
end)

RegisterServerEvent('esx_gouvernor:btnI2')
AddEventHandler('esx_gouvernor:btnI2', function(typet, nom, montant)
	local _source = source
	TriggerClientEvent('esx:showNotification', _source, 'Sinä lisäsit verotuksen.')
	MySQL.Async.execute("INSERT INTO gouv_taxe(name,montant, job) VALUES (@a, @b, @c)", {['@a'] = nom, ['@b'] = montant, ['@c'] = typet})
end)

RegisterServerEvent('esx_gouvernor:btnI3')
AddEventHandler('esx_gouvernor:btnI3', function(id)
	local _source = source
	MySQL.Async.execute("DELETE FROM gouv_taxe WHERE `id` = @id", {['@id'] = id})
	TriggerClientEvent('esx:showNotification', _source, 'Sinä poistit verotuksen.')
end)

RegisterServerEvent('esx_gouvernor:btnI4')
AddEventHandler('esx_gouvernor:btnI4', function()
	local _source = source
	local result = MySQL.Sync.fetchAll('SELECT name, montant FROM gouv_taxe')
	TriggerClientEvent('esx_gouvernor:btnI4re', _source, result)
end)

RegisterServerEvent('esx_gouvernor:btnE1')
AddEventHandler('esx_gouvernor:btnE1', function()
	local _source = source
	local result = MySQL.Sync.fetchAll('SELECT job,	responsable FROM central_account')
	TriggerClientEvent('esx_gouvernor:btnE1re', _source, result)
end)

RegisterServerEvent('esx_gouvernor:btnE3')
AddEventHandler('esx_gouvernor:btnE3', function(nom)
	local _source = source
	MySQL.Async.fetchAll("SELECT id, status2 FROM central_account WHERE job = @a", {['@a'] = nom}, function (resultd)
	if resultd[1] ~= nil then
		if resultd[1].status2 == "0" then
			MySQL.Async.execute("UPDATE central_account SET status2 = '1' WHERE `job` = @nom", {['@nom'] = nom})
			TriggerClientEvent('esx:showNotification', _source, 'Sinä estit yrityksen '.. nom ..'.')
		else
			MySQL.Async.execute("UPDATE central_account SET status2 = '0' WHERE `job` = @nom", {['@nom'] = nom})
			TriggerClientEvent('esx:showNotification', _source, 'Sinä estit yrityksen '.. nom ..'.')
		end
	else
		TriggerClientEvent('esx:showNotification', _source, 'Virheellinen yritys.')
	end
  end)
end)

-- Stock
RegisterServerEvent('esx_gouvernor:getStockItem')
AddEventHandler('esx_gouvernor:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernor', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)
  end)
end)

ESX.RegisterServerCallback('esx_gouvernor:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernor', function(inventory)
    cb(inventory.items)
  end)
end)

RegisterServerEvent('esx_gouvernor:putStockItems')
AddEventHandler('esx_gouvernor:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernor', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
  end)
end)

RegisterServerEvent('gouv:sendNotif')
AddEventHandler('gouv:sendNotif', function(id, msg)
  TriggerClientEvent('esx:showNotification', id, msg)
end)

RegisterServerEvent('gouv:showBadgeTo')
AddEventHandler('gouv:showBadgeTo', function(t)
	TriggerClientEvent('gouv:showMePlate', t)
end)

RegisterServerEvent('gouv:drag')
AddEventHandler('gouv:drag', function(target)
  local _source = source
  TriggerClientEvent('gouv:drag', target, _source)
end)

RegisterServerEvent('gouv:putInVehicle')
AddEventHandler('gouv:putInVehicle', function(target)
  TriggerClientEvent('gouv:putInVehicle', target)
end)

RegisterServerEvent('gouv:OutVehicle')
AddEventHandler('gouv:OutVehicle', function(target)
  TriggerClientEvent('gouv:OutVehicle', target)
end)

RegisterServerEvent('gouv:confiscatePlayerItem')
AddEventHandler('gouv:confiscatePlayerItem', function(target, itemType, itemName, amount)

  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if itemType == 'item_standard' then

    local label = sourceXPlayer.getInventoryItem(itemName).label
    local playerItemCount = targetXPlayer.getInventoryItem(itemName).count

    if playerItemCount <= amount then
      targetXPlayer.removeInventoryItem(itemName, amount)
      sourceXPlayer.addInventoryItem(itemName, amount)
    else
      TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', 'Agentti', _U('you_have_confinv') .. amount .. ' ' .. label .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. _U('confinv') .. amount .. ' ' .. label )
  end

  if itemType == 'item_account' then

    targetXPlayer.removeAccountMoney(itemName, amount)
    sourceXPlayer.addAccountMoney(itemName, amount)

    TriggerClientEvent('esx:showNotification', 'Agentti', _U('you_have_confdm') .. amount .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. _U('confdm') .. amount)
  end

  if itemType == 'item_weapon' then

    targetXPlayer.removeWeapon(itemName)
    sourceXPlayer.addWeapon(itemName, amount)

    TriggerClientEvent('esx:showNotification', 'Agentti', _U('you_have_confweapon') .. ESX.GetWeaponLabel(itemName) .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. _U('confweapon') .. ESX.GetWeaponLabel(itemName))
  end
end)

ESX.RegisterServerCallback('gouvernor:getOtherPlayerData', function(source, cb, target)

  if Config.EnableESXIdentity then

    local xPlayer = ESX.GetPlayerFromId(target)

    local identifier = GetPlayerIdentifiers(target)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
      ['@identifier'] = identifier
    })

    local user      = result[1]
    local firstname     = user['firstname']
    local lastname      = user['lastname']
    local sex           = user['sex']
    local dob           = user['dateofbirth']
    local height        = user['height'] .. " Inches"
	local drunki = nil

    local data = {
      name        = GetPlayerName(target),
      job         = xPlayer.job,
      inventory   = xPlayer.inventory,
      accounts    = xPlayer.accounts,
      weapons     = xPlayer.loadout,
      firstname   = firstname,
      lastname    = lastname,
      sex         = sex,
      dob         = dob,
      height      = height,
	  drunk       = drunki
    }

    TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    if Config.EnableLicenses then

      TriggerEvent('esx_license:getLicenses', target, function(licenses)
        data.licenses = licenses
        cb(data)
      end)

    else
      cb(data)
    end

  else

    local xPlayer = ESX.GetPlayerFromId(target)
	local drunki = nil
    local data = {
      name       = GetPlayerName(target),
      job        = xPlayer.job,
      inventory  = xPlayer.inventory,
      accounts   = xPlayer.accounts,
	  drunk      = drunki,
      weapons    = xPlayer.loadout
    }

    TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    TriggerEvent('esx_license:getLicenses', target, function(licenses)
      data.licenses = licenses
    end)

    cb(data)
  end
end)


ESX.RegisterServerCallback('esx_gouvernor:getVaultWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouvernor', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end
    cb(weapons)
  end)
end)

ESX.RegisterServerCallback('esx_gouvernor:addVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouvernor', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end
    store.set('weapons', weapons)
    cb()
  end)
end)

ESX.RegisterServerCallback('esx_gouvernor:removeVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_gouvernor', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end
    store.set('weapons', weapons)
     cb()
  end)
end)

ESX.RegisterServerCallback('esx_gouvernor:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })
end)
