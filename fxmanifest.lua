fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

author 'NN TEAM'
description 'Advanced Fivem HUD System'
version '1.0.0'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/app.js'
}   

client_script 'client/client.lua'
shared_script {
    '@ox_lib/init.lua',
}
