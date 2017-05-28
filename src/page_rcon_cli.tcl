#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}
#Source for most below: http://wiki.multiplay.co.uk/CS:GO/Command_list

## rcon client config
variable rconCliConfig [CreateConfig \
    [list \
        name     "rconCliConfig" \
        prefix   "RconCli" \
        fileName "$configFolder/rconcli.cfg" \
        saveProc "SaveConfigFileRconCli" \
    ] \
    [list \
        "string"  [list overrideip "" "Use this ip address instead of the automatically detected ip address.\nCan be used if auto detection fails or if you want to connect to some other server.\nKeep blank if you don't understand what this is."]\
        "int"     [list overrideport "" "Use this port instead of the port configured for your csgo server.\nCan be used if you want to connect to some other server.\nKeep blank if you don't understand what this is."]\
        "string"  [list overridepassword "" "Use this password instead of the password configured for rcon to your csgo server.\nCan be used if you want to connect to some other server.\nKeep blank if you don't understand what this is."]\
    ] \
]

variable rconCliLayout [CreateLayout \
    [list \
        configName  "rconCliConfig" \
        tabName     "RconCli" \
        help        "RconCli" \
    ] \
    [list \
        h1      [list "RconCli settings"] \
        space   [list] \
        h2      [list "Shortcuts"] \
        line    [list] \
        space   [list] \
        buttons [list [list text tgeneral "General"] \
                      [list push clear clear {rcon::ClearLog} "Clear the console log window"] \
                      [list push status status {rcon::ExecuteCommand status} "Show server status"] \
                      [list push stats stats {rcon::ExecuteCommand stats} "Show server stats"] \
                      [list push reload reload {rcon::ExecuteCommand reload} "Reload the current map and start fresh"] \
                      [list push serverlogon serverlogon {rcon::ExecuteCommand log on} "Enable server logging"] \
                      [list push serverlogoff serverlogoff {rcon::ExecuteCommand log off} "Disable server logging"] \
                      [list push cheatson cheatson {rcon::ExecuteCommand "sv_cheats 1"} "Allow cheats"] \
                      [list push cheatsoff cheatsoff {rcon::ExecuteCommand "sv_cheats 0"} "Don't allow cheats."] \
                      [list push pausableon pausableon {rcon::ExecuteCommand "sv_pausable 1"} "Server can be paused."] \
                      [list push pausableoff pausableoff {rcon::ExecuteCommand "sv_pausable 0"} "Server can't be paused."] \
                      [list push voiceon voiceon {rcon::ExecuteCommand "sv_voiceenable 1"} "Allow clients to use mic."] \
                      [list push voiceoff voiceoff {rcon::ExecuteCommand "sv_voiceenable 0"} "Don't allow clients to use mic."] \
                      [list push spectatorson spectatorson {rcon::ExecuteCommand "mp_spectators_max 8"} "Allow (8) spectators on the server."] \
                      [list push spectatorsoff spectatorsoff {rcon::ExecuteCommand "mp_spectators_max 0"} "Don't allow spectators on the server."] \
                ] \
        buttons [list [list text tusers "Users"] \
                      [list push users users {rcon::ExecuteCommand users} "List currently connected users"] \
                      [list entry kick kick {rcon::ExecuteCommand kick} "Kick user name entered in text box" rconCliCommandKickEntry] \
                      [list entry ban30min ban30min {rcon::ExecuteCommand banid 30} "Ban user id entered in text box for 30 minutes" rconCliCommandBanEntry] \
                      [list entry permban permban {rcon::ExecuteCommand banid 0} "Permanently ban user id entered in text box" rconCliCommandPermBanEntry] \
                      [list push kickallbots kickallbots {rcon::ExecuteCommand "bot_kick all"} "Kick all bots"] \
                      [list push autoteambalanceon autoteambalanceon {rcon::ExecuteCommand "mp_autoteambalance 1"} "Force clients to auto-join the opposite team if they are not balanced."] \
                      [list push autoteambalanceoff autoteambalanceoff {rcon::ExecuteCommand "mp_autoteambalance 0"} "Don't force clients to auto-join the opposite team if they are not balanced."] \
                ] \
        buttons [list [list text tusers "Users(2)"] \
                      [list push autokickon autokickon {rcon::ExecuteCommand "mp_autokick 1"} "Kick idle/team-killing players."] \
                      [list push autokickoff autokickoff {rcon::ExecuteCommand "mp_autokick 0"} "Don't kick idle/team-killing players."] \
                      [list push tkpunishon tkpunishon {rcon::ExecuteCommand "mp_tkpunish 1"} "Punish team killers on next round."] \
                      [list push tkpunishoff tkpunishoff {rcon::ExecuteCommand "mp_tkpunish 0"} "Don't punish team killers on next round."] \
                ] \
        buttons [list [list text tgameplay "Gameplay"] \
                      [list push friendlyfireon friendlyfireon {rcon::ExecuteCommand "mp_friendlyfire 1"} "Turn on friendlyfire."] \
                      [list push friendlyfireoff friendlyfireoff {rcon::ExecuteCommand "mp_friendlyfire 0"} "Turn off friendlyfire."] \
                      [list push forcecameraon forcecameraon {rcon::ExecuteCommand "mp_forcecamera 1"} "Force dead players to first person mode, effectively disabling freelook."] \
                      [list push forcecameraoff forcecameraoff {rcon::ExecuteCommand "mp_forcecamera 0"} "Don't force dead players to first person mode, effectively disabling freelook."] \
                      [list push alltalkon alltalkon {rcon::ExecuteCommand "sv_alltalk 1"} "Players can hear all other players, no team restrictions."] \
                      [list push alltalkoff alltalkoff {rcon::ExecuteCommand "sv_alltalk 0"} "Players can't hear all other players, no team restrictions."] \
                ] \
        buttons [list [list text tgotv "GOTV"] \
                      [list push status status {rcon::ExecuteCommand "tv_status"} "Shows GOTV specific information."] \
                      [list push clients clients {rcon::ExecuteCommand "tv_clients"} "Shows a list of all spectator clients connect to local GOTV server."] \
                      [list push on on {rcon::ExecuteCommand "tv_enable 1"} "Activates GOTV on local game server."] \
                      [list push off off {rcon::ExecuteCommand "tv_enable 0"} "Deactivates GOTV on local game server."] \
                      [list push stop stop {rcon::ExecuteCommand "tv_stop"} "Stops broadcasting the game via GOTV."] \
                      [list entry startrecord startrecord {rcon::ExecuteCommand "tv_record"} "Starts a GOTV demo recording that records all entities & events (master only) with the name entered in text box" rconCliCommandStartRecordEntry] \
                      [list push stoprecord stoprecord {rcon::ExecuteCommand "tv_stoprecord"} "Stops GOTV demo recording (master only)."] \
                      [list push autorecordon autorecordon {rcon::ExecuteCommand "tv_autorecord 1"} "Automatically records every game, demo file name format is auto-YYYYMMDD-hhmm-map.dem."] \
                      [list push autorecordoff autorecordoff {rcon::ExecuteCommand "tv_autorecord 0"} "Stop autorecording."] \
                      [list push debugon debugon {rcon::ExecuteCommand "tv_debug 1"} "Enables additional debugging messages."] \
                      [list push debugoff debugoff {rcon::ExecuteCommand "tv_debug 0"} "Disables additional debugging messages."] \
                ] \
        space   [list] \
        h2      [list "Console"] \
        line    [list] \
        text    [list "Use CRSR-UP/DOWN for command history."] \
        func    [list LayoutFuncRconCli] \
        warning [list "You may get a firewall warning when running rcon commands, simply allow and remember the access."] \
        line    [list] \
        text    [list "These settings are only used to override the automatic rcon functionality. Leave blank or read the help text carefully."] \
        parm    [list overrideip] \
        parm    [list overrideport] \
        parm    [list overridepassword] \
    ] \
]
