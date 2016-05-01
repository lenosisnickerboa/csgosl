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
        "string"    [list steamusername "" "Your user name on steam"]\
        "string"    [list steamid "" "Your user id on steam, looks something like STEAM_1:1:12345678. See help page for more information about how to obtain your steam id."]\
        "bool"      [list makemeadmin "1" "Enable to be the sourcemod admin for your server. Requires steamusername and steamuserid to be filled in."]\
        "string"    [list gameserverlogintoken "" "Required to host public servers, see help page for more information."]\
        "string"    [list apiauthkey "" "Required to download maps from the workshop, see help page for more information."]\
        "bool"      [list autoupdateonstart "0" "Automatically perform server update when csgosl is launched."]\
        "bool"      [list validateinstall "0" "Perform install validation when updating, i.e the downloaded server update is checked for validity."]\
        "url"       [list steamcmdurl "$steamCmdUrl" "URL to steamcmd. Leave as is if you don't have a very good reason to change this."]\
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
        parm    [list steamusername] \
        parm    [list steamid] \
        parm    [list makemeadmin] \
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
