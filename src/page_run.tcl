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
        "enum" [list gamemodetype "Classic Casual" "Which kind of game you want to play, mapped to game_mode and game_type." [dict keys $gameModeMapper]]\
        "enum" [list mapgroup "mg_active" "Which maps you want to play, defined in the map group editor. If you enter a workshop collection id here that collection will be hosted." \
                [dict keys $mapGroupsMapper]]\
        "enum" [list startmap "de_dust2" "Which maps you want to play, defined in the map group editor. If you enter a workshop map id here that map will be hosted." \
                $allMaps]\
        "int"  [list players "16" "Defines max number of players"]\
        "bool" [list fillwithbots "1" "Add bots until max number of players are reached"]\
        "enum" [list botskill "Normal" "How intelligent bots dou you want?" [dict keys $botSkillMapper]]\
        "bool" [list immediatestart "1" "Immediately start playing, no warmup time"]\
        "bool" [list friendlyfire "0" "Want to be able to kill your team mates?"]\
        "int"  [list roundtime "10" "Limit match time to this many minutes"]\
        "bool" [list killcam "1" "Want to see who killed you and where he was located?"]\
        "string" [list options "" "srcds options added at the end of the command line when starting server"]\
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
