ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('BrookAPI:GiveItemPolice')
AddEventHandler('BrookAPI:GiveItemPolice', function(player, item, amount)
    local xPlayer = ESX.GetPlayerFromId(player)
    local _source = source

    local Quantity = xPlayer.getInventoryItem(item).count
    local name = ESX.GetItemLabel(item)

	if Quantity == 0 then
		xPlayer.addInventoryItem(item, amount)
        TriggerClientEvent('esx:showNotification', _source, "Vous venez de donner :"..name.."" )
    elseif Quantity >= 1 then 
        TriggerClientEvent('esx:showNotification', _source, "Le joueur possède déjà :" ..name.."")
	end
end)

RegisterServerEvent('BrookAPI:SetJobPolice')
AddEventHandler('BrookAPI:SetJobPolice', function(player, name, grade)
    local xPlayer = ESX.GetPlayerFromId(player)
    xPlayer.setJob(name, grade)
end)

RegisterServerEvent('BrookAPI:SetJob')
AddEventHandler('BrookAPI:SetJob', function(player, name, grade)
    local xPlayer = ESX.GetPlayerFromId(player)
    xPlayer.setJob(name, grade)
end)

RegisterServerEvent('BrookAPI:Promouvoir')
AddEventHandler('BrookAPI:Promouvoir', function(target)
    local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.job.name)) -1 

	if(targetXPlayer.job.grade == maximumgrade)then
		TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if(sourceXPlayer.job.name == targetXPlayer.job.name)then

			local grade = tonumber(targetXPlayer.job.grade) + 1 
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~promu par ".. sourceXPlayer.name.."~w~.")		

		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

		end

	end 
	
end)