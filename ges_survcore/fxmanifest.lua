fx_version 'cerulean'
lua54 'yes'

author 'GES'
description 'Blizzard Survival Core'

shared_scripts {
    'config.lua',
    'shared/constants.lua',
    'shared/util.lua'
}

client_scripts {
    'client/modules/temp.lua',
    'client/modules/wetness.lua',
    'client/modules/heat.lua',
    'client/modules/blizzard.lua',
    'client/modules/hud_demo.lua',
    'client/ports.lua',
    'client/main.lua'
}

server_scripts {
    'server/ports.lua',
    'server/admin_cmds.lua',
    'server/main.lua'
}
