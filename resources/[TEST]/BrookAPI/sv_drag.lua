 -- @Date:   2017-09-16
  -- @Project: FX Interactions
  -- @Owner: Jink Left
  -- @LICENSE: NO LICENSE/LICENSE
  -- @Last modified time: 2017-09-16
--------------------------------------------------------------
--------------------[   DATA   ]--------------------

----------------------------------------------------
---------------[	FUNCTIONS 		]---------------
----------------------------------------------------

----------------------------------------------------
---------------[	THREADS 		]---------------
---------------------------------------------------- 

----------------------------------------------------
---------------[	EVENTS 		]-------------------
----------------------------------------------------
RegisterServerEvent('fx:getHandStatus')
AddEventHandler('fx:getHandStatus', function(event,targetID)
	-- print("triggered Hand status")
	TriggerClientEvent("fx:getHandStatusPlayer",-1,event,targetID)
end)

RegisterServerEvent('fx:sendHandStatus')
AddEventHandler('fx:sendHandStatus', function(event,targetID,hands)
	TriggerClientEvent(event,targetID,hands)
end)

RegisterServerEvent('fx:reSendHandStatus')
AddEventHandler('fx:reSendHandStatus', function(event,targetID,hands)
	-- print("recieved hand status")
	-- print("event is : " .. tostring(event))
	-- print("Target Id is : " .. tostring(targetID))
	-- print("hands are : " .. tostring(hands))	
end)

RegisterServerEvent('fx:dragRequest')
AddEventHandler('fx:dragRequest', function(dPlayer)
	TriggerClientEvent('fx:toggleDrag', dPlayer, source)
end)

RegisterServerEvent('print')
AddEventHandler('print', function(text)
    print(text)
end)