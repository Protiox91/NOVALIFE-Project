resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


dependencies {
  "mysql-async",
  "esx_datastore",
  "esx_society",
  "esx_billing",
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'client/esx_brinks_cl.lua',
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'server/esx_brinks_sv.lua',
}