#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Run config
variable runConfig [CreateConfig \
    [list \
        name     "runConfig" \
        prefix   "Run" \
        fileName "$configFolder/run.cfg" \
        saveProc "SaveConfigFileRun" \
    ] \
    [list \
        "enum" [list gamemodetype "Classic Casual" "Select the kind of game you want to play." [dict keys $gameModeMapper] onchange "RunGameModeTypeChanged"]\
        "enum" [list mapgroup "<allmaps>" "Select which maps you want to play, defined in the map group editor.\nIf you enter a workshop collection id here that collection will be hosted." [dict keys $mapGroupsMapper] onchange "RunMapGroupChanged"]\
        "bool" [list automapgroup "1" "If enabled, mapgroup \"auto_<current gamemodetype>\" will be automatically selected.\nE.g. If gamemodetype is \"Armsrace\" mapgroup \"auto_Armsrace\" will be selected.\nNote: Spaces in gamemodetype will be ignored, i.e. create map group without spaces, e.g. \"auto_ClassicCasual\"." onchange "RunAutoMapGroupChanged"]\
        "enum" [list startmap "de_dust2" "The first maps the server starts hosting. If you enter a workshop map id here that map will be hosted." ""]\
        "bool" [list randomstartmap "0" "Select a random start map from the selected map group when the server is started" onchange "RunRandomStartMapChanged"]\
        "int"  [list players "16" "Defines max number of players including bots." mappedto [list bot_quota]]\
        "int"  [list bots "0" "Only used when fillwithbots is disabled, ignored otherwise. Defines exact number of bots." mappedto [list bot_quota]]\
        "bool" [list fillwithbots "1" "Add bots until max number of players are reached." mappedto [list bot_quota bot_quota_mode] onchange "RunSetBotsState"]\
        "enum" [list botskill "Normal" "How intelligent bots do you want?" [dict keys $botSkillMapper] mappedto [list bot_difficulty]]\
        "bool" [list friendlyfire "0" "Enable this option to be able to hurt your team mates." mappedto [list mp_friendlyfire]]\
        "int"  [list roundtime "10" "Limit match time to this many minutes." mappedto [list mp_roundtime]]\
        "bool" [list killcam "1" "Allow dead players to spectate the other team." mappedto [list mp_forcecamera]]\
        "string" [list options "" "Expert option, everything added here is appended to the command line when starting the server."]\
        "int"  [list buytime "30" "Seconds you are allowed to buy stuff when the match begins." mappedto [list mp_buytime]]\
        "int"  [list warmuptime "0" "Seconds to warm up before the match begins." mappedto [list mp_warmuptime]]\
        "int"  [list freezetime "0" "How many seconds to keep players frozen when the round starts." mappedto [list mp_freezetime]]\
        "int"  [list startmoney "800" "Amount of money each player gets when they reset." mappedto [list mp_startmoney]]\
        "bool"  [list mp_consecutive_loss_aversion "1" "How loss streak is affected with round win: disable = win fully resets loss bonus,\nenable = win reduces the loss counter by one" mappedto [list mp_consecutive_loss_aversion]]\
        "int"  [list mp_consecutive_loss_max "4" "This is the limit to how many times the loss bonus will increase, but does not limit the loss counter itself." mappedto [list mp_consecutive_loss_max]]\
        "int"  [list cash_team_winner_bonus_consecutive_rounds "0" "Amount the winner bonus increases by per win" mappedto [list cash_team_winner_bonus_consecutive_rounds]]\
        "int"  [list cash_team_loser_bonus_consecutive_rounds "500" "Amount the loss bonus increases by per loss" mappedto [list cash_team_loser_bonus_consecutive_rounds]]\
        "int"  [list c4timer "40" "The amount of time in seconds before bomb explodes after planted.\n<10-90>" mappedto [list mp_c4timer]]\
        "int"  [list fraglimit "0" "Amount of frags a player can exceed before changing maps." mappedto [list mp_fraglimit]]\
        "int"  [list maxrounds "30" "Amount of rounds to play before server changes maps." mappedto [list mp_maxrounds]]\
        "int"  [list winlimit "30" "Max number of rounds one team can win before server changes maps." mappedto [list mp_winlimit]]\
        "bool" [list enablebunnyhopping "0" "Disables the air-velocity clamping to 110% of maximum running speed." mappedto [list sv_enablebunnyhopping]]\
        "bool" [list autobunnyhopping "0" "Holding +jump causes players to automatically re-jump at the exact landing tick." mappedto [list sv_autobunnyhopping]]\
        "int"  [list airaccelerate "10" "Makes you accelerate faster or slower when in the air." mappedto [list sv_airaccelerate]]\
        "enum" [list solidteammates "Fully" "How solid are team mates? Controls collision." [dict keys $solidTeamMatesMapper] mappedto [list mp_solid_teammates]]\
    ] \
]

variable runLayout [CreateLayout \
    [list \
        configName  "runConfig" \
        tabName     "Run" \
        help        "Run" \
    ] \
    [list \
        h1      [list "Run settings"] \
        space   [list] \
        h2      [list "Game mode"] \
        line    [list] \
        space   [list] \
        parm    [list gamemodetype] \
        space   [list] \
        h2      [list "Maps"] \
        line    [list] \
        space   [list] \
        parm    [list mapgroup] \
        parm    [list startmap] \
        parm    [list randomstartmap] \
        parm    [list automapgroup] \
        space   [list] \
        h2      [list "Players"] \
        line    [list] \
        space   [list] \
        parm    [list players] \
        parm    [list bots] \
        parm    [list fillwithbots] \
        parm    [list botskill] \
        space   [list] \
        h2      [list "Gameplay"] \
        line    [list] \
        space   [list] \
    	parm    [list friendlyfire] \
        parm    [list killcam] \
        parm    [list solidteammates] \
        parm    [list enablebunnyhopping] \
        parm    [list autobunnyhopping] \
        parm    [list airaccelerate] \
        space   [list] \
        h2      [list "Round"] \
        line    [list] \
        parm    [list roundtime] \
        parm    [list warmuptime] \
        parm    [list buytime] \
        parm    [list freezetime] \
        parm    [list c4timer] \
        parm    [list fraglimit] \
        parm    [list maxrounds] \
        parm    [list winlimit] \
        space   [list] \
        h2      [list "Money"] \
        line    [list] \
        space   [list] \
        parm    [list startmoney] \
    	parm    [list mp_consecutive_loss_aversion] \
        parm    [list mp_consecutive_loss_max] \
        parm    [list cash_team_winner_bonus_consecutive_rounds] \
        parm    [list cash_team_loser_bonus_consecutive_rounds] \
        space   [list] \
        h2      [list "Misc"] \
        line    [list] \
        space   [list] \
        parm    [list options] \
    ] \
]

proc RunGameModeTypeChanged { value1 {value2 ""} } {
    set value [string trim "$value1 $value2"]
    UpdateRunPage
    return "$value"
}

proc RunMapGroupChanged { value } {
    UpdateRunPage
    return "$value"
}

proc RunAutoMapGroupChanged { value } {
    UpdateRunPage
    return "$value"
}

proc RunSetBotsState { value } {
    global runLayout
    set cp [GetCp]
    set enabled [expr $value == 0]
    SetConfigItemState $cp.run $runLayout bots $enabled
    return $value
}

proc RunRandomStartMapChanged { value } {
    global runLayout
    set cp [GetCp]
    set enabled [expr $value == 0]
    SetConfigItemState $cp.run $runLayout startmap $enabled
    return $value
}
