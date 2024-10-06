fx_version 'cerulean'

game 'gta5'

author 'ITZ ISMA'
description 'Pack de bienvenida para el servidor'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

dependency 'mysql-async'