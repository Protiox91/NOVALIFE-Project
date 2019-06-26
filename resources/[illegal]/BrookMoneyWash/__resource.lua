description 'ESX Dark Spider'

version '1.0.0'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/script.js',
  'html/style.css'
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  '@mysql-async/lib/MySQL.lua',
  'locales/en.lua',
  'config.lua',
  'server.lua'
}
