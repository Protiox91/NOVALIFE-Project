ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--
RegisterServerEvent('esx_joblisting:postApplication')
AddEventHandler('esx_joblisting:postApplication', function(dataTemp)
	
	local data = dataTemp
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.fetchAll(
	'SELECT * FROM users WHERE identifier = @identifier', 
	{
      ['@identifier'] = xPlayer.identifier
    }, 
	function(rows)
				
		for i = 1, #rows, 1 do
			_name = rows[i].firstname .. ' ' .. rows[i].lastname
		end

		if data.type == "police" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.police)
		elseif data.type == "ambulance" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.ambulance)
		elseif data.type == "unicorn" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.unicorn)
		elseif data.type == "cardealer" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.cardealer)
		elseif data.type == "mechanic" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.mechanic)
		elseif data.type == "realestate" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.realestate)
		elseif data.type == "taxi" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.taxi)
		elseif data.type == "bus" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.bus)
		elseif data.type == "armurier" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.armurier)
		elseif data.type == "bahama" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.bahama)
		elseif data.type == "bank" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.bank)
		elseif data.type == "casino" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.casino)
		elseif data.type == "epi" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.epi)
		elseif data.type == "avocat" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.avocat)
		elseif data.type == "prison" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.prison)
		elseif data.type == "oasis" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.oasis)
		elseif data.type == "tabac" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.tabac)
		elseif data.type == "vigne" then
			postApp(_name, data.pres, data.phone, data.licenses, data.moti, data.exp, Config.Webhook.vigne)
		end
	end)

end)

function postApp(_name, pres, phone, licenses, moti, exp, webhook)
	local embeds = {
	{
		["type"] = "rich",
		["title"] = "Nouvelle demande d'emploi:" ,
		["fields"] =  {
						{
						    ["name"]= "Nom:",
						    ["value"]= _name,
						},
						{
						    ["name"]= "Présentation:",
						    ["value"]= pres,
						},
						{
							["name"]= "Moyens de contact:",
							["value"]= phone,
						},
						{
							["name"]= "Permis:",
							["value"]= licenses,
						},
						{
							["name"]= "Motivations:",
							["value"]= moti,
						},
						{
							["name"]= "Expériences:",
							["value"]= exp,
						},
				},
		["color"] = 6807172,
		["footer"] =  {
					["text"]= os.date("%A %x"),
					},
	}}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ embeds = embeds}), { ['Content-Type'] = 'application/json' })
end		