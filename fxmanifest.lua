fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Sign Robbery'
version '1.1.0'

client_script 'client/*.lua'
server_script 'server/*.lua'

shared_script {
    'shared/config.lua',
    '@ox_lib/init.lua',
}
