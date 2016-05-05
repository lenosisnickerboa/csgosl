#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Server config
variable serverConfig [CreateConfig \
    [list \
        name     "serverConfig" \
        prefix   "Server" \
        fileName "$configFolder/server.cfg" \
        saveProc "SaveConfigFileServer" \
    ] \
    [list \
        "string"    [list name "Your server at $hostName operated by $name" "This is the server name which is presented in the list of servers in the csgo game."]\
        "string"    [list password "" "Your server password which anyone connecting to your server must enter to log in and play.\nWhen running a LAN only server this can be left empty for no password.\nIf you run a public server it is *HIGHLY* recommended to set a password."]\
        "bool"      [list autorestart "0" "If enabled the server is auto restarted if it crashes (or is closed down, so you need to kill cmd.exe using ps/task manager prior to killing the server window)"]\
        "string"    [list bindip "" "IP address which your server should bind to.\nLeave blank if you don't have a problem with connecting to the server.\nMay e.g. be used when running on a VLAN to force the server to bind to the VLAN."]\
        "int"       [list port "27015" "Your server port."]\
        "bool"      [list lanonly "1" "If enabled server is only available on your LAN. Default enabled for security reasons, disable when you want to play with friends over the Internet."]\
        "int"       [list tickrate "128" "Server tickrate, that is the frequency with which the server and connecting clients communicate. Connecting clients are automatically instructed to use this frequency."]\
        "bool"      [list rcon "0" "Enable servers Remote Console. This allows you (and anyone else with the rcon password) to connect to your server and control it using commands."]\
        "string"    [list rconpassword "$hostName" "Your RCON password, set to your hostname by default. If you enable rcon set a better password!"]\
        "int"       [list netmaxfilesize "64" "Controls how large maps clients are allowed to download from your server. Leave as is if you don't know what this is."]\
    ] \
]

variable serverLayout [CreateLayout \
    [list \
        configName  "serverConfig" \
        tabName     "Server" \
        help        "Server" \
    ] \
    [list \
        h1      [list "Server settings"] \
        space   [list] \
        h2      [list "General"] \
        line    [list] \
        space   [list] \
        parm    [list name] \
        parm    [list password] \
        space   [list] \
        h2      [list "Connection"] \
        line    [list] \
        space   [list] \
        parm    [list port] \
        parm    [list lanonly] \
        parm    [list rcon] \
        parm    [list rconpassword] \
        space   [list] \
        h2      [list "Misc"] \
        line    [list] \
        space   [list] \
        parm    [list bindip] \
        parm    [list autorestart] \
        parm    [list tickrate] \
        parm    [list netmaxfilesize] \        
    ] \
]
