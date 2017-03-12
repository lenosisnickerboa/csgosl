#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

proc CreateItemsFromConfigs {configs} {
    set items [dict create]
    foreach config $configs {        
        set meta [dict get $config meta]
        dict for {key metaInfo} $meta {
            set type [dict get $metaInfo type]
            set help [dict get $metaInfo help]
            set items [dict set items $key [list $type "$help"]]
        }
    }
    set itemsList [list]
    dict for {key meta} $items {
        set type [lindex $meta 0]
        set help [lindex $meta 1]
        lappend itemsList $type [list $key "" "$help"]
    }
    return $itemsList
}

set gameModeConfigs [list \
                     $gameModeArmsraceConfig $gameModeClassicCasualConfig \
                     $gameModeClassicCompetitiveConfig $gameModeDemolitionConfig \
                     $gameModeDeathmatchConfig $gameModeTrainingConfig $gameModeCustomConfig \
                     $gameModeCooperativeConfig]

variable gameModeAllConfig [CreateConfig \
    [list \
        name     "gameModeAllConfig" \
        prefix   "All_Modes" \
        fileName "$configFolder/gamemode_all.cfg" \
        saveProc "SaveConfigFileGameModeAll" \
        addCVar  "yes" \
    ] \
    [CreateItemsFromConfigs $gameModeConfigs\
    ] \
]
