--Déclaration des EventHandler
RegisterServerEvent("projectEZ:savelastpos")
--Intégration de la position dans MySQL
AddEventHandler("projectEZ:savelastpos", function( LastPosX , LastPosY , LastPosZ , LastPosH )
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
		--Récupération du SteamID.
		local player = user.getIdentifier()
		--Formatage des données en JSON pour intégration dans MySQL.
		local LastPos = "{" .. LastPosX .. ", " .. LastPosY .. ",  " .. LastPosZ .. ", " .. LastPosH .. "}"
		--Exécution de la requêtes SQL.
		MySQL.Async.execute("UPDATE users SET `lastpos`=@lastpos WHERE identifier = @username", {['@username'] = player, ['@lastpos'] = LastPos})
		TriggerEvent("lg:pos", GetPlayerName(source) .. " Save Position: " .. LastPos)
		end
	end)
end)

RegisterServerEvent("projectEZ:SpawnPlayer")
AddEventHandler("projectEZ:SpawnPlayer", function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		--Récupération du SteamID.
		if (user) then
		local player = user.getIdentifier()
		--Récupération des données générée par la requête.
		local result = MySQL.Sync.fetchScalar("SELECT lastpos FROM users WHERE identifier = @username", {['@username'] = player})	
		-- Vérification de la présence d'un résultat avant de lancer le traitement.
		if(result ~= nil)then
				-- Décodage des données récupérées
				local ToSpawnPos = json.decode(result)
				TriggerClientEvent("projectEZ:spawnlaspos", source, ToSpawnPos[1], ToSpawnPos[2], ToSpawnPos[3])
		end
	end
	end)
end)