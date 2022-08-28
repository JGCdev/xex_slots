fx_version 'adamant'

game 'gta5'

lua54 'on'

description 'XeX Slots - ESX Framework Slot Machines'

version '1.0.1'

ui_page 'html/ui.html'

client_scripts {
  '@es_extended/locale.lua',
  'locales/*.lua',
	'config.lua',
	'client.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/*.lua',
  'config.lua',
	'server.lua'
}

files {
  'html/ui.html',
  'html/*.js',
  'html/*.json',
  'html/design.css',
  'html/img/*.png',
  'html/audio/*.mp3'
}

dependencies {
	'es_extended',
}

escrow_ignore {
  '*',
  'locales/*'
}