ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_darkspider:getBlackMoney', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)
  local account = xPlayer.getAccount('black_money')

  cb(account.money)

end)

ESX.RegisterServerCallback('esx_darkspider:washBlackMoney', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)
  local black_money = xPlayer.getAccount('black_money').money

  local charge = {}
  for i=1, #Config.Charges, 1 do
    if Config.Charges[i].Amount <= black_money then
      charge = Config.Charges[i]
    end
  end

  local profit = math.floor(black_money * (1-charge.Fee))

  xPlayer.removeAccountMoney('black_money', black_money)
  xPlayer.addMoney(profit)

  MySQL.Async.execute(
    'INSERT INTO darkspider_log (transaction_time, customer, amount, profit) VALUES (NOW(), @customer, @amount, @profit)',
    {
      ['@customer'] = xPlayer.identifier,
      ['@amount'] = black_money,
      ['@profit'] = profit
    },
    function(rowsChanged)
      
    end
  )

  cb(profit)

end)

ESX.RegisterServerCallback('esx_darkspider:punish', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)
  local black_money = xPlayer.getAccount('black_money').money

  local punishAmount = math.floor(black_money * (math.random()/3 + 0.2))
  xPlayer.removeAccountMoney('black_money', punishAmount)
  TriggerClientEvent('esx:showNotification', source, 'You were charged ~r~$' .. punishAmount .. '~s~ for cancelling the transaction')

  MySQL.Async.execute(
    'INSERT INTO darkspider_log (transaction_time, customer, amount, profit) VALUES (NOW(), @customer, @amount, @profit)',
    {
      ['@customer'] = xPlayer.identifier,
      ['@amount'] = black_money,
      ['@profit'] = 0-punishAmount
    },
    function(rowsChanged)
      
    end
  )

end)