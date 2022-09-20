fx_version "cerulean"

description "DuCity Illegal Doctor"
author "DuCity"
version '1.0.0'

lua54 'yes'

games {
  "gta5",
}

shared_scripts {
  "config.lua",
}
client_script "client/**/*"
server_script "server/**/*"

dependency {
  "qb-core",
  "qb-menu",
  "qb-target"
}