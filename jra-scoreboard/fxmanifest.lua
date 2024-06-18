--[[
      _ ____      _      ____                 _                                  _       
     | |  _ \    / \    |  _ \  _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ ___ 
  _  | | |_) |  / _ \   | | | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __/ __|
 | |_| |  _ <  / ___ \  | |_| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_\__ \
  \___/|_| \_\/_/   \_\ |____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|___/
                                                     |_|                                 
                       

	JRA Developments | 

]]--

fx_version 'cerulean'
game 'gta5'

author 'JRA Developments'
description 'Customisable Scoreboard for QBCORE & ESX built using ox_lib context menu'
version '1.0'
lua54 'yes'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}
client_script {
    'client/client.lua'
}
server_script {
    'server/server.lua'
}