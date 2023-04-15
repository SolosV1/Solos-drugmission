fx_version 'cerulean'
game 'gta5'

author 'Solos#7777'
description 'solos-drugmission - simple missions for players to obtain illegal items or ingredients'
version '1.0.0'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client.lua',
    'config.lua'
}

server_script {
    'server.lua'
}

escrow_ignore {
    'config.lua',
    'server.lua',
    'client.lua'
}

lua54 'yes'