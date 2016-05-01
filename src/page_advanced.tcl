#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir cvars.tcl]

variable gameModeArmsraceConfig [CreateSplitConfig \
    [list \
        name             "gameModeArmsraceConfig" \
        prefix           "Armsrace" \
        fileNameDefaults "$serverCfgPath/gamemode_armsrace.cfg" \
        fileName         "$serverCfgPath/gamemode_armsrace_server.cfg" \
        saveProc         "SaveConfigFileGameModeArmsrace" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeClassicCasualConfig [CreateSplitConfig \
    [list \
        name             "gameModeClassicCasualConfig" \
        prefix           "Classic_Casual" \
        fileNameDefaults "$serverCfgPath/gamemode_casual.cfg" \
        fileName         "$serverCfgPath/gamemode_casual_server.cfg" \
        saveProc         "SaveConfigFileGameModeClassicCasual" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeClassicCompetitiveConfig [CreateSplitConfig \
    [list \
        name             "gameModeClassicCompetitiveConfig" \
        prefix           "Classic_Competitive" \
        fileNameDefaults "$serverCfgPath/gamemode_competitive.cfg" \
        fileName         "$serverCfgPath/gamemode_competitive_server.cfg" \
        saveProc         "SaveConfigFileGameModeClassicCompetitive" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeDemolitionConfig [CreateSplitConfig \
    [list \
        name             "gameModeDemolitionConfig" \
        prefix           "Demolition" \
        fileNameDefaults "$serverCfgPath/gamemode_demolition.cfg" \
        fileName         "$serverCfgPath/gamemode_demolition_server.cfg" \
        saveProc         "SaveConfigFileGameModeDemolition" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeDeathmatchConfig [CreateSplitConfig \
    [list \
        name             "gameModeDeathmatchConfig" \
        prefix           "Deathmatch" \
        fileNameDefaults "$serverCfgPath/gamemode_deathmatch.cfg" \
        fileName         "$serverCfgPath/gamemode_deathmatch_server.cfg" \
        saveProc         "SaveConfigFileGameModeDeathmatch" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeTrainingConfig [CreateSplitConfig \
    [list \
        name             "gameModeTrainingConfig" \
        prefix           "Training" \
        fileNameDefaults "$serverCfgPath/gamemode_training.cfg" \
        fileName         "$serverCfgPath/gamemode_training_server.cfg" \
        saveProc         "SaveConfigFileGameModeTraining" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeCustomConfig [CreateSplitConfig \
    [list \
        name             "gameModeCustomConfig" \
        prefix           "Custom" \
        fileNameDefaults "$serverCfgPath/gamemode_custom.cfg" \
        fileName         "$serverCfgPath/gamemode_custom_server.cfg" \
        saveProc         "SaveConfigFileGameModeCustom" \
    ] \
    $gameModeConfigcsvars \
]

variable gameModeCooperativeConfig [CreateSplitConfig \
    [list \
        name             "gameModeCooperativeConfig" \
        prefix           "Cooperative" \
        fileNameDefaults "$serverCfgPath/gamemode_cooperative.cfg" \
        fileName         "$serverCfgPath/gamemode_cooperative_server.cfg" \
        saveProc         "SaveConfigFileGameModeCooperative" \
    ] \
    $gameModeConfigcsvars \
]

