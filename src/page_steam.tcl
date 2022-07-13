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
        "bool"      [list validateinstall "0" "Perform install validation when updating, i.e the downloaded server update is checked for validity."]\
        "url"       [list steamcmdurl "$steamCmdUrl" "URL to steamcmd. Leave as is if you don't have a very good reason to change this."]\
        "bool"      [list validateworkshopmaps "0" "On csgosl startup always check that installed workshop maps are still present at Steam.\nNo longer existing maps will be moved to a folder named workshop-DISABLED next to the workshop folder."]\
        "string"    [list hostworkshopmap "" "The steam id of a workshop map to *permanently* host, i.e. this map will always be hosted\nuntil cleared in this setting."]\
        "string"    [list hostworkshopmapgroup "" "The steam id of a workshop mapgroup to *permanently* host, i.e. this mapgroup will always be hosted\nuntil cleared in this setting."]\
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
        parm    [list validateinstall] \
        parm    [list steamcmdurl] \
        parm    [list validateworkshopmaps] \
        space   [list] \
        h2      [list "Host a workshop mapgroup or map"] \
        line    [list] \
        space   [list] \
        parm    [list hostworkshopmap] \
        buttons [list [list push SteamWorkshopMaps SteamWorkshopMaps {Browser "https://steamcommunity.com/workshop/browse?appid=730"} "Go to Steam Workshop, maps section."] \
                      ] \
        parm    [list hostworkshopmapgroup] \
        buttons [list [list push SteamWorkshopMaps SteamWorkshopMaps {Browser "https://steamcommunity.com/workshop/browse/?section=collections&appid=730"} "Go to Steam Workshop, mapgroups section."] \
                      ] \
    ] \
]
