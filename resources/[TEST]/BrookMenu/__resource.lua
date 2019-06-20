resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}

client_scripts {
    "@NativeUI/NativeUI.lua",
    "@es_extended/locale.lua",
	"menu.lua"
}

server_scripts {
    "@es_extended/locale.lua",
    "server.lua"
}