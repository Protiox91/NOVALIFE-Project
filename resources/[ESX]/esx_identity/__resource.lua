resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Identity'

version '1.5.2'

server_scripts {
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'@es_extended/locale.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css'
}

dependency 'es_extended'

exports {
  'openRegistry'
}
