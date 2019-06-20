ESX = nil

--ESX.RegisterServerCallback('Brook:getUsergroup', function(source, cb)
--  local xPlayer = ESX.GetPlayerFromId(source)
--  local group = xPlayer.getGroup()
--  cb(group)
--end)

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 

    ESX.RegisterServerCallback('Brook:getUsergroup', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        local group = xPlayer.getGroup()
        cb(group)
        if xPlayer ~= nil then
            print("BrookAPI : Menu ---> Xplayer = nil (à régler) ")
        end
    end)

    ESX.RegisterServerCallback('Brook:getItemAmount', function(source, cb, item)
        print('Brook call item : ' .. item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end)
end)

