--[[
##################################################################
Author : Deediezi
-----------------------------------------------------------------
Gitlab : https://gitlab.com/Deediezi/gta5_scripts
-----------------------------------------------------------------
Discord : Deediezi#0794
##################################################################
]]

description "An optimized spawn manager with cool things !"

client_script 'client/client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/config.lua',
	'server/utils.lua',
	'server/main.lua'
}