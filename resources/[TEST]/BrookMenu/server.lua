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
    ESX.RegisterServerCallback('Brook:Facture', function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
    
        local bills = {}
    
        MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            for i = 1, #result, 1 do
                table.insert(bills, {
                    id         = result[i].id,
                    identifier = result[i].identifier,
                    sender     = result[i].sender,
                    targetType = result[i].target_type,
                    target     = result[i].target,
                    label      = result[i].label,
                    amount     = result[i].amount
                })
            end
    
            cb(bills)
        end)
    end)
end)

