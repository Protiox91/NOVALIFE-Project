if data.current.value == 'mk3' then
	local modelHash = ''

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		modelHash = GetHashKey(Mark3)

		ESX.Streaming.RequestModel(modelHash, function()
			SetPlayerModel(PlayerId(), modelHash)
			SetModelAsNoLongerNeeded(modelHash)

			TriggerEvent('esx:restoreLoadout')
		end)
	end)
end

if data.current.value == 'antend' then
	local modelHash = ''

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		modelHash = GetHashKey(Antman_Teamsuit)

		ESX.Streaming.RequestModel(modelHash, function()
			SetPlayerModel(PlayerId(), modelHash)
			SetModelAsNoLongerNeeded(modelHash)

			TriggerEvent('esx:restoreLoadout')
		end)
	end)
end