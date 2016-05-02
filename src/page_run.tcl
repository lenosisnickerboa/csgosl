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
        "enum" [list gamemodetype "Classic Casual" "Select the kind of game you want to play." [dict keys $gameModeMapper]]\
        "enum" [list mapgroup "mg_active" "Select which maps you want to play, defined in the map group editor.\nIf you enter a workshop collection id here that collection will be hosted." [dict keys $mapGroupsMapper]]\
        "enum" [list startmap "de_dust2" "The first maps the server starts hosting. If you enter a workshop map id here that map will be hosted." $allMaps]\
        "int"  [list players "16" "Defines max number of players including bots."]\
        "int"  [list bots "0" "Only used when fillwithbots is disabled, ignored otherwhise. Defines exact number of bots."]\
        "bool" [list fillwithbots "1" "Add bots until max number of players are reached."]\
        "enum" [list botskill "Normal" "How intelligent bots dou you want?" [dict keys $botSkillMapper]]\
        "bool" [list immediatestart "1" "Immediately start playing, no warmup time."]\
        "bool" [list friendlyfire "0" "Enable this option to be able to hurt your team mates."]\
        "int"  [list roundtime "10" "Limit match time to this many minutes."]\
        "bool" [list killcam "1" "Enable this option to be able to see who killed you and where he was located."]\
        "string" [list options "" "Expert option, everything added here is appended to the command line when starting the server."]\
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
        space   [list] \
        h2      [list "Players"] \
        line    [list] \
        space   [list] \
        parm    [list players] \
        parm    [list bots func] \
        parm    [list fillwithbots] \
        parm    [list botskill] \
    	parm    [list friendlyfire] \
        space   [list] \
        h2      [list "Misc"] \
        line    [list] \
        space   [list] \
        parm    [list immediatestart] \
        parm    [list killcam] \
        parm    [list roundtime] \
        parm    [list options] \
    ] \
]
