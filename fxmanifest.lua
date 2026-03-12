fx_version 'cerulean'
games {'gta5'}
lua54 "yes"

author 'Walter Cain'
description 'Cain QB Road Work Job'
version '1.0.0'

client_scripts {
	'language.lua',
	'config.lua',
	'client/main.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
}

server_scripts {
	'language.lua',
	'config.lua',
	'server/main.lua',
	'@oxmysql/lib/MySQL.lua',
}

ui_page 'nui/index.html'

exports {
	
}

server_exports {

}


escrow_ignore {
    "config.lua",
    "language.lua",
    "client/*.lua",
    "server/*.lua",
}

dependencies {
	'/assetpacks',
	'qb-core',
}

shared_scripts {
	'@qb-core/shared/locale.lua',
}

files {
    
}