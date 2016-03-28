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
        "string"    [list name "Your server at $hostName operated by $name" ""]\
        "string"    [list password "" "Your server password, leave empty for no password."]\
        "bool"      [list autorestart "0" "If enabled the server is auto restarted if it crashes (or is closed down, so you need to kill cmd.exe using ps/task manager prior to killing the server window)"]\
        "int"       [list port "27015" "Your server port"]\
        "bool"      [list lanonly "1" "If enabled server is only available on your LAN. Default for security reasons, disable when you want to play beyond your lan."]\
        "int"       [list tickrate "128" "Server tickrate"]\
        "bool"      [list rcon "0" "Enable servers Remote Console. You really should set a password!"]\
        "string"    [list rconpassword "$hostName" "Your RCON password, set to your hostname by default."]\
        "int"       [list netmaxfilesize "64" "Fix to allow clients to download maps without problems TBD"]\
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
        parm    [list autorestart] \
        parm    [list tickrate] \
        parm    [list netmaxfilesize] \        
    ] \
]
