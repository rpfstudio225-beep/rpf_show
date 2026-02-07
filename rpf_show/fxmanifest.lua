games { 'rdr3' }

fx_version 'bodacious'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts { 'client/moviesandshows.lua' }

ui_page {
	'html/index.html'
}

files {
	'html/index.html',
    'html/shop.png',
}

client_scripts {
	'config.lua',
    'client/client.lua',
    'client/store.lua',
}

server_scripts {
	'config.lua',
	'server/server.lua',
	'server/main.lua',
}