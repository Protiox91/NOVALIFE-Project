--[[
##################################################################
Author : Deediezi
-----------------------------------------------------------------
Gitlab : https://gitlab.com/Deediezi/gta5_scripts
-----------------------------------------------------------------
Discord : Deediezi#0794
##################################################################
]]

----------------------------------------------
-- Utils functions ###########################
-- - - - - - - - - - - - - - - - - - - - - - -
function IsRemote()
	if globalConf['SERVER'].remote_database then
		return true
	else
		return false
	end
end

----------------------------------------------
-- CreateSpawnManager global function ########
-- - - - - - - - - - - - - - - - - - - - - - -
function CreateSpawnManager(src, spawnPos, group)
	local self = {}

	self.source 		= src
	self.spawnPos 		= spawnPos
	self.actualPos 		= nil
	self.group 			= group

	local rTable = {}

	rTable.get = function(k)
		return self[k]
	end 

	rTable.set = function(k, v)
		self[k] = v
	end

	rTable.save = function()
		if(self.actualPos)then
			local user = {encodedPos = json.encode(self.actualPos), identifier = GetPlayerIdentifiers(self.source)[1]}
			local column_name = globalConf['DB'].column_name

			if(IsRemote())then
				MySQL.Async.execute('UPDATE users SET ' .. column_name .. ' = @actualPos WHERE identifier = @identifier', {actualPos = user.encodedPos, identifier = user.identifier})
			else
				MySQL.Sync.execute('UPDATE users SET ' .. column_name .. ' = @actualPos WHERE identifier = @identifier', {actualPos = user.encodedPos, identifier = user.identifier})
			end
		end
	end

	return rTable
end

----------------------------------------------
-- GetSpawnPos global function ###############
-- - - - - - - - - - - - - - - - - - - - - - -
function GetSpawnPos(identifier, cbPos)
	local column_name = globalConf['DB'].column_name
	
	if(IsRemote())then
		MySQL.Async.fetchScalar('SELECT '.. column_name .. ' FROM users WHERE identifier = @identifier', {identifier = identifier}, function(position)
			if(type(position) == 'table')then
				cbPos(position)
			elseif(type(position) ~= 'table')then
				if(position == nil or position == '' or position == '[]')then
					cbPos('nil')
				else
					cbPos(json.decode(position))
				end
			end
		end)
	else
		local position = MySQL.Sync.fetchScalar('SELECT ' .. column_name .. ' FROM users WHERE identifier = @identifier', {identifier = identifier})
		if(type(position) == 'table')then
			cbPos(position)
		elseif(type(position) ~= 'table')then
			if(position == nil or position == '' or position == '[]')then
				cbPos('nil')
			else
				cbPos(json.decode(position))
			end
		end
	end
end

----------------------------------------------
-- autoUpdate global function ################
-- - - - - - - - - - - - - - - - - - - - - - -
function autoUpdate()
	SetTimeout(globalConf['MAIN'].autoUpdate_timer, function()
		returnUser('all', function(Users)
			if Users then
				for k, v in pairs(Users) do
					if Users[k] ~= nil then
						v.save()
					end
				end
				if globalConf['MSG'].save_message then
					if GetConvar('mysql_debug', 'true') == 'false' then
						print(txt[lang].has_been_saved)
					end
				end
			end
		end)
		autoUpdate()
	end)
end

