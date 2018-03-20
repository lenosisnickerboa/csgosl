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
        "string"    [list tags "" "Any server tags you want to add separated by commas, e.g. 128fps,nisse,some,stuff."]\
        "bool"      [list autorestart "0" "If enabled the server is auto restarted if it crashes (or is closed down, so you need to kill cmd.exe using ps/task manager prior to killing the server window)"]\
        "bool"      [list startserveronstart "0" "Launch the csgo server when csgosl is launched. If updateserveronstart is enabled it will be performed first.\nNote that it will take a while (10s+) before the server starts, specially if it is updated first."]\
        "string"    [list restartserverat "" "Enter space separated times when your server should be restarted. if updateserveronrestart is enabled the server will be updated as well.\nEnter time in 24h format, e.g. 9:27 or 23:59:14.\nMultiple times can be entered, e.g. 6:00 12:00 18:00 00:00:10\nRequires csgosl restart to take effect." onchange "ServerSetUpdateServerOnRestartState"]\
        "bool"      [list updateserveronstart "0" "Automatically perform server update when csgosl is launched."]\
        "bool"      [list updateserveronrestart "1" "Perform server update prior to restarting the server"]\
        "string"    [list bindip "" "IP address which your server should bind to.\nLeave blank if you don't have a problem with connecting to the server.\nMay e.g. be used when running on a VLAN to force the server to bind to the VLAN."]\
        "int"       [list port "27015" "Your server port."]\
        "bool"      [list lanonly "1" "If enabled server is only available on your LAN. Default enabled for security reasons, disable when you want to play with friends over the Internet."]\
        "int"       [list tickrate "128" "Server tickrate, that is the frequency with which the server and connecting clients communicate. Connecting clients are automatically instructed to use this frequency."]\
        "int"       [list minrate "" "Leave blank to let csgosl manage this setting for you, corresponds to sv_minrate."]\
        "int"       [list maxrate "" "Leave blank to let csgosl manage this setting for you, corresponds to sv_maxrate."]\
        "bool"      [list rcon "0" "Enable servers Remote Console. This allows you (and anyone else with the rcon password) to connect to your server and control it using commands." onchange "ServerSetRconPasswordState"]\
        "string"    [list rconpassword "$hostName" "Your RCON password, set to your hostname by default. If you enable rcon set a better password!"]\
        "int"       [list rconbanpenalty "0" "Number of minutes to ban users who fail rcon authentication." mappedto [list sv_rcon_banpenalty]]\
        "int"       [list rconmaxfailures "10" "Max number of times a user can fail rcon authentication before being banned.\n<0-20>" mappedto [list sv_rcon_maxfailures]]\
        "int"       [list netmaxfilesize "64" "Controls how large maps clients are allowed to download from your server. Leave as is if you don't know what this is."]\
        "bool"      [list standalonescript "0" "Generate standalone start/stop scripts in the csgosl installation folder which can be used to control the csgo server without\nstarting the csgosl GUI. The script will be automatically regenerated when parameter changes are\nsaved so it always stays up-to-date with your configuration."]\
        "bool"      [list standaloneupdate "0" "Include a server update in the standalone script."]\
        "bool"      [list standalonestart "0" "Include a server start in the standalone script."]\
        "bool"      [list pausable "0" "Anyone can pause the server." mappedto [list sv_pausable]]\
        "bool"      [list clientconsistency "0" "Force clients to pass consistency check for critical files before joining server" mappedto [list sv_consistency]]\
        "bool"      [list voice "0" "Allow clients to use mic." mappedto [list sv_voiceenable]]\
        "bool"      [list spectators "0" "Allow spectators on the server." mappedto [list mp_allowspectators]]\
        "bool"      [list logenable "0" "Enable server logging?" mappedto [list log]]\
        "bool"      [list logbans "0" "Log server bans in the server logs." mappedto [list sv_logbans]]\
        "bool"      [list logecho "1" "Echo log information to the console." mappedto [list sv_logecho]]\
        "bool"      [list logfile "1" "Log server information in the log file." mappedto [list sv_logfile]]\
        "bool"      [list logonefile "0" "Log server information to only one file." mappedto [list sv_log_onefile]]\
        "bool"      [list alltalk "0" "Players can hear all other players, no team restrictions." mappedto [list sv_alltalk]]\
        "bool"      [list cheats "0" "Allow cheats on server." mappedto [list sv_cheats]]\
        "int"       [list gravity "800" "World Gravity" mappedto [list sv_gravity]]\
        "bool"      [list autoteambalance "0" "Balance teams automatically (please find better help text...)." mappedto [list mp_autoteambalance]]\
        "bool"      [list autokick "0" "Kick idle/team-killing players."]\
        "bool"      [list tkpunish "0" "Punish team killers on next round?" mappedto [list mp_tkpunish]]\
        "bool"      [list fastdl "0" "Enable fastDL support.\nFastDL allows the client to download custom server content\n(maps, materials, models, particles, sounds, fonts, images) from a web server." onchange "ServerSetFastDLOptions"]\
        "string"    [list fastdlurl "http://some-url/" "URL used for fastDL"]\
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
        parm    [list tags] \
        space   [list] \
        h2      [list "Connection"] \
        line    [list] \
        space   [list] \
        parm    [list port] \
        parm    [list lanonly] \
        space   [list] \
        h2      [list "Rcon"] \
        line    [list] \
        space   [list] \
        parm    [list rcon] \
        parm    [list rconpassword] \
        parm    [list rconbanpenalty] \
        parm    [list rconmaxfailures] \
        space   [list] \
        h2      [list "FastDL"] \
        line    [list] \
        space   [list] \
        parm    [list fastdl] \
        parm    [list fastdlurl] \
        space   [list] \
        h2      [list "Logging"] \
        line    [list] \
        space   [list] \
        parm    [list logenable] \
        parm    [list logbans] \
        parm    [list logecho] \
        parm    [list logfile] \
        parm    [list logonefile] \
        space   [list] \
        h2      [list "Startup server options"] \
        line    [list] \
        space   [list] \
        parm    [list updateserveronstart] \
        parm    [list startserveronstart] \
        space   [list] \
        h2      [list "Restart server options"] \
        line    [list] \
        space   [list] \
        parm    [list restartserverat] \
        parm    [list updateserveronrestart] \
        space   [list] \
        h2      [list "Standalone script generation"] \
        line    [list] \
        space   [list] \
        parm    [list standalonescript] \
        parm    [list standaloneupdate] \
        parm    [list standalonestart] \
        space   [list] \
        h2      [list "Misc"] \
        line    [list] \
        space   [list] \
        parm    [list tickrate] \
        parm    [list minrate] \
        parm    [list maxrate] \
        parm    [list voice] \
        parm    [list alltalk] \
        parm    [list cheats] \
        parm    [list autokick] \
        parm    [list autoteambalance] \
        parm    [list tkpunish] \
        parm    [list gravity] \
        parm    [list spectators] \
        parm    [list clientconsistency] \
        parm    [list pausable] \
        parm    [list bindip] \
        parm    [list autorestart] \
        parm    [list netmaxfilesize] \        
    ] \
]

proc ServerSetRconPasswordState { value } {
    global serverLayout
    set cp [GetCp]
    set enabled [expr $value == 1]
    SetConfigItemState $cp.server $serverLayout rconpassword $enabled
    SetConfigItemState $cp.server $serverLayout rconbanpenalty $enabled
    SetConfigItemState $cp.server $serverLayout rconmaxfailures $enabled
    return $value
}

proc ServerSetUpdateServerOnRestartState { {value ""} } {
    global serverLayout
    set cp [GetCp]
    set enabled [expr [llength $value] > 0]
    SetConfigItemState $cp.server $serverLayout updateserveronrestart $enabled
    return $value    
}

proc ServerSetFastDLOptions { value } {
    global serverLayout
    set cp [GetCp]
    set enabled [expr $value == 1]
    SetConfigItemState $cp.server $serverLayout fastdlurl $enabled
    return $value
}
