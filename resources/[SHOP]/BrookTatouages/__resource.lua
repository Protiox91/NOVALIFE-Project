resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

--client_script 'client/tattoosList/list.lua'
--client_script 'client/config.lua'
--client_script 'client/client.lua'
--client_script "@NativeUI/NativeUI.lua"
--server_script '@mysql-async/lib/MySQL.lua'
--server_script 'server/server.lua'

client_scripts {
    "@NativeUI/NativeUI.lua",
    'client/client.lua',
    'client/config.lua',
    'client/tattoosList/list.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}