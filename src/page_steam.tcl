#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Steam config
set steamCmdUrl "http://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
if {$currentOs == "windows"} {
    set steamCmdUrl "http://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip"    
}
variable steamConfig [CreateConfig \
    [list \
        name     "steamConfig" \
        prefix   "Steam" \
        fileName "$configFolder/steam.cfg" \
        saveProc "SaveConfigFileSteam" \
    ] \
    [list \
        "string"    [list gameserverlogintoken "" "Required to host public servers, see http://steamcommunity.com/dev/managegameservers"]\
        "string"    [list apiauthkey "" "Required to download maps from the workshop, register here: http://steamcommunity.com/dev/apikey"]\
        "bool"      [list autoupdateonstart "0" "Automatically perform update when csgosl is launched."]\
        "bool"      [list validateinstall "0" "Perform install validation when updating."]\
        "url"       [list steamcmdurl "$steamCmdUrl" "URL to steamcmd"]\
    ] \
]

variable steamLayout [CreateLayout \
    [list \
        configName  "steamConfig" \
        tabName     "Steam" \
        help        "Steam" \
    ] \
    [list \
        h1      [list "Steam settings"] \
        space   [list] \
        h2      [list "Authorization"] \
        line    [list] \
        space   [list] \
        parm    [list gameserverlogintoken] \
        parm    [list apiauthkey] \
        space   [list] \
        h2      [list "Installation"] \
        line    [list] \
        space   [list] \
        parm    [list autoupdateonstart] \
        parm    [list validateinstall] \
        parm    [list steamcmdurl] \
    ] \
]
