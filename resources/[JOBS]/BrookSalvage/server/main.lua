ESX = nil
local PlayersVente = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_oceansalvage:GiveItem')
AddEventHandler('esx_oceansalvage:GiveItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

	if Quantity >= 15 then
		TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
	else
		local amount = Config.Zones.Vente.ItemAdd
		local item = Config.Zones.Vente.ItemDb_name
		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('esx:showNotification', _source, _U('salvage_collected'))
	end

end)

-------------Light Diving suit
ESX.RegisterUsableItem('plongee1', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('plongee1', 1)
        TriggerClientEvent('esx_tenues:settenueplongee', _source)
end)

-------------diving suit
ESX.RegisterUsableItem('plongee2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem('plongee2', 1)
        TriggerClientEvent('esx_tenues:settenueplongee', _source)
end)

local function Vente(source)

	SetTimeout(Config.Zones.Vente.ItemTime, function()

		if PlayersVente[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

			if Quantity < Config.Zones.Vente.ItemRemove then
				TriggerClientEvent('esx:showNotification', _source, _U('sell_nomorebills'))
				PlayersVente[_source] = false
			else
				local amount = Config.Zones.Vente.ItemRemove
				local item = Config.Zones.Vente.ItemRequires

				Citizen.Wait(1500)
				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(Config.Zones.Vente.ItemPrice)
				TriggerClientEvent('esx:showNotification', _source, _U('sell_earned', ESX.Math.GroupDigits(Config.Zones.Vente.ItemPrice)))
				Vente(_source)
			end

		end
	end)
end

RegisterServerEvent('esx_oceansalvage:startVente')
AddEventHandler('esx_oceansalvage:startVente', function()
	local _source = source

	if PlayersVente[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, _U('sell_nobills'))
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
		TriggerClientEvent('esx:showNotification', _source, _U('sell_cashing'))
		Vente(_source)
	end
end)

RegisterServerEvent('esx_oceansalvage:stopVente')
AddEventHandler('esx_oceansalvage:stopVente', function()
	local _source = source

	if PlayersVente[_source] == true then
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
	end
end)
