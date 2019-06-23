resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

--ui_page 'ui/index.html'

--[[
files {
  'ui/index.html',
  'ui/style.css',
  'ui/img/nova.png',
  'ui/script.js'
}
--]]

client_scripts {
    "client.lua",
    "heli_client.lua",
    "cnp.lua",
    "cl_slash.lua",
    "ping_cl.lua",
    "pointing.lua",
    "config.lua",
    "ko_client.lua",
    "traffic.lua",
    "rc_car.lua",
    "cl_drag.lua",
    "server"
    --"alert_cl.lua",
    --"water.lua"
}
exports {
  'open',
  'RCCarStart',
	'close'
}

server_scripts {
  "@es_extended/locale.lua",
  "server.lua",
  "ping_sv.lua",
  'heli_server.lua',
  "sv_drag.lua",
  --"alert_sv.lua",
  "sv_slash.lua"
}