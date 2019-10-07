#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

#First flag states if plugin is risky or not
variable sourcemodPlugins [list \
    mapchooser [list false sm_mapchooser_enable sm_mapchooser_lanonly mapchooser.smx] \
    nominations [list false sm_nominations_enable sm_nominations_lanonly nominations.smx] \
    rockthevote [list false sm_rockthevote_enable sm_rockthevote_lanonly rockthevote.smx] \
    nextmap [list false sm_nextmap_enable sm_nextmap_lanonly nextmap.smx] \
    randomcycle [list false sm_randomcycle_enable sm_randomcycle_lanonly randomcycle.smx] \
    warmod [list false sm_warmod_enable sm_warmod_lanonly warmod.smx] \
    multi1v1 [list false sm_multi1v1_enable sm_multi1v1_lanonly multi1v1.smx] \
    multi1v1_flashbangs [list false sm_multi1v1_flashbangs_enable sm_multi1v1_flashbangs_lanonly multi1v1_flashbangs.smx] \
    multi1v1_kniferounds [list false sm_multi1v1_kniferounds_enable sm_multi1v1_kniferounds_lanonly multi1v1_kniferounds.smx] \
    multi1v1_online_stats_viewer [list false sm_multi1v1_online_stats_viewer_enable sm_multi1v1_online_stats_viewer_lanonly multi1v1_online_stats_viewer.smx] \
    gunmenu [list false sm_gunmenu_enable sm_gunmenu_lanonly csgo_gunmenu.smx] \
    cksurf [list false sm_cksurf_enable sm_cksurf_lanonly ckSurf.smx] \
    retakes [list false sm_retakes_enable sm_retakes_lanonly retakes.smx] \
    retakes_sitepicker [list false sm_retakes_sitepicker_enable sm_retakes_sitepicker_lanonly retakes_sitepicker.smx] \
    retakes_standardallocator [list false sm_retakes_standardallocator_enable sm_retakes_standardallocator_lanonly retakes_standardallocator.smx] \
    retakes_pistolallocator [list false sm_retakes_pistolallocator_enable sm_retakes_pistolallocator_lanonly retakes_pistolallocator.smx] \
    influx [list false sm_influx_enable sm_influx_lanonly "influx_*.smx"] \
    splewis_get5 [list false sm_splewis_get5_enable sm_splewis_get5_lanonly get5.smx] \
    shanapu_myweaponallocator [list false sm_shanapu_myweaponallocator_enable sm_shanapu_myweaponallocator_lanonly MyWeaponAllocator.smx] \
    splewis_pugsetup [list false sm_splewis_pugsetup_enable sm_splewis_pugsetup_lanonly pugsetup.smx] \
    franug_weaponpaints [list true sm_franug_weaponpaints_enable sm_franug_weaponpaints_lanonly franug_weaponpaints_public.smx] \
    franug_knifes [list true sm_franug_knifes_enable sm_franug_knifes_lanonly sm_franugknife.smx]
]

## Sourcemod config
variable sourcemodConfig [CreateConfig \
    [list \
        name     "sourcemodConfig" \
        prefix   "Sourcemod" \
        fileName "$configFolder/sourcemod.cfg" \
        saveProc "SaveConfigFileSourcemod" \
    ] \
    [list \
        "bool"      [list enable "1" "Controls if sourcemod functionality is enabled. If disabled ALL other plugins below are also disabled." onchange "SetSourcemodState"]\
        "bool"      [list lanonly "0" "Only enable sourcemod in lanonly mode"]\
        "bool"      [list banprotection "1" "Disables all known unsafe plugins and sets FollowCSGOServerGuidelines to \"yes\".\nWhen you disable ban protection FollowCSGOServerGuidelines is set to \"no\" to allow plugins full access.\nDO NOT DISABLE THIS OPTION UNLESS YOU HAVE READ THE HELP PAGE FIRST!\nYOUR SERVER MAY BE BANNED!"]\
        "string"    [list admins "" "List all users (separated by space) you want to give admin permissions on your server\nA user is identified by their steam id (e.g STEAM_1:1:12345678) or ip address (e.g. 192.168.1.123).\nSee help page for more information about how to obtain your steam id or find users ip address."]\
        "bool"      [list sm_mapchooser_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodMapChooserState"]\
        "bool"      [list sm_mapchooser_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_mapchooser_mapvote_endvote "1" "Specifies if MapChooser should run an end of map vote."]\
        "bool"      [list sm_nominations_enable "0" "Controls if this sourcemod plugin is enabled.\nRequires mapchooser enabled." onchange "SetSourcemodNominationsState"]\
        "bool"      [list sm_nominations_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_rockthevote_enable "0" "Controls if this sourcemod plugin is enabled.\nRequires mapchooser enabled." onchange "SetSourcemodRockTheVoteState"]\
        "bool"      [list sm_rockthevote_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_nextmap_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodNextMapState"]\
        "bool"      [list sm_nextmap_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_randomcycle_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodRandomCycleState"]\
        "bool"      [list sm_randomcycle_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_warmod_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodWarmodState"]\
        "bool"      [list sm_warmod_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_multi1v1_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodMulti1v1State"]\
        "bool"      [list sm_multi1v1_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_multi1v1_flashbangs_enable "0" "Controls if this sourcemod plugin is enabled."]\
        "bool"      [list sm_multi1v1_flashbangs_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_multi1v1_kniferounds_enable "0" "Controls if this sourcemod plugin is enabled."]\
        "bool"      [list sm_multi1v1_kniferounds_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_multi1v1_online_stats_viewer_enable "0" "Controls if this sourcemod plugin is enabled."]\
        "bool"      [list sm_multi1v1_online_stats_viewer_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_gunmenu_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodGunMenuState"]\
        "bool"      [list sm_gunmenu_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_cksurf_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodCkSurfState"]\
        "bool"      [list sm_cksurf_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_retakes_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodRetakesState"]\
        "bool"      [list sm_retakes_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_retakes_sitepicker_enable "0" "Controls if this sourcemod plugin is enabled."]\
        "bool"      [list sm_retakes_sitepicker_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_retakes_standardallocator_enable "0" "Controls if this sourcemod plugin is enabled.\nExcludes sm_retakes_pistolallocator" onchange "SetSourcemodRetakesPistolAllocatorValue"]\
        "bool"      [list sm_retakes_standardallocator_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_retakes_pistolallocator_enable "0" "Controls if this sourcemod plugin is enabled.\nExcludes sm_retakes_standardallocator" onchange "SetSourcemodRetakesStandardAllocatorValue"]\
        "bool"      [list sm_retakes_pistolallocator_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_influx_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodInfluxState"]\
        "bool"      [list sm_influx_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_splewis_get5_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodSplewisGet5State"]\
        "bool"      [list sm_splewis_get5_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_shanapu_myweaponallocator_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodShanapuMyWeaponAllocatorState"]\
        "bool"      [list sm_shanapu_myweaponallocator_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_splewis_pugsetup_enable "0" "Controls if this sourcemod plugin is enabled." onchange "SetSourcemodSplewisPugSetupState"]\
        "bool"      [list sm_splewis_pugsetup_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_franug_weaponpaints_enable "0" "Controls if this sourcemod plugin is enabled.\nType !ws in chat to use." onchange "SetSourcemodFranugWeaponPaintsState"]\
        "bool"      [list sm_franug_weaponpaints_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
        "bool"      [list sm_franug_weaponpaints_onlyadmin "1" "This feature is only for admins. 1 = enabled, 0 = disabled.\n(Use the value 1 and try to keep this plugin secret for the normal users because they can report it)"]\
        "bool"      [list sm_franug_weaponpaints_c4 "1" "Enable or disable that people can apply paints to the C4. 1 = enabled, 0 = disabled"]\
        "int"       [list sm_franug_weaponpaints_saytimer "-1" "Time in seconds for block that show the plugin commands in chat when someone type a command.\n-1 = never show the commands in chat"]\
        "int"       [list sm_franug_weaponpaints_roundtimer "-1" "Time in seconds roundstart for can use the commands for change the paints.\n-1 = always can use the command"]\
        "bool"      [list sm_franug_weaponpaints_rmenu "0" "Re-open the menu when you select a option. 1 = enabled, 0 = disabled."]\
        "bool"      [list sm_franug_weaponpaints_zombiesv "1" "Enable this for prevent crashes in zombie and 1v1 servers for knifes.\n1 = enabled, 0 = disabled. (Use the value 1 if you use my knife plugin)"]\
        "bool"      [list sm_franug_knifes_enable "0" "Controls if this sourcemod plugin is enabled.\nType !knife in chat to use." onchange "SetSourcemodFranugKnifesState"]\
        "bool"      [list sm_franug_knifes_lanonly "1" "Only enable this sourcemod plugin in lanonly mode"]\
    ] \
]

variable sourcemodLayout [CreateLayout \
    [list \
        configName  "sourcemodConfig" \
        tabName     "Sourcemod" \
        help        "Sourcemod" \
    ] \
    [list \
        h1      [list "Sourcemod settings"] \
        space   [list] \
        h2      [list "General"] \
        line    [list] \
        space   [list] \
        parm    [list enable] \
        parm    [list lanonly] \
        parm    [list admins] \
        space   [list] \
        h2      [list "Plugin: mapchooser"] \
        parm    [list sm_mapchooser_enable] \
        parm    [list sm_mapchooser_lanonly] \
        parm    [list sm_mapchooser_mapvote_endvote] \
        space   [list] \
        h2      [list "Plugin: nominations"] \
        parm    [list sm_nominations_enable] \
        parm    [list sm_nominations_lanonly] \
        space   [list] \
        h2      [list "Plugin: rockthevote"] \
        parm    [list sm_rockthevote_enable] \
        parm    [list sm_rockthevote_lanonly] \
        space   [list] \
        h2      [list "Plugin: nextmap"] \
        parm    [list sm_nextmap_enable] \
        parm    [list sm_nextmap_lanonly] \
        space   [list] \
        h2      [list "Plugin: randomcycle"] \
        parm    [list sm_randomcycle_enable] \
        parm    [list sm_randomcycle_lanonly] \
        space   [list] \
        h2      [list "Plugin: warmod"] \
        parm    [list sm_warmod_enable] \
        parm    [list sm_warmod_lanonly] \
        space   [list] \
        h2      [list "Plugin: multi1v1"] \
        parm    [list sm_multi1v1_enable] \
        parm    [list sm_multi1v1_lanonly] \
        space   [list] \
        h2      [list "Plugin: multi1v1_flashbangs"] \
        parm    [list sm_multi1v1_flashbangs_enable] \
        parm    [list sm_multi1v1_flashbangs_lanonly] \
        space   [list] \
        h2      [list "Plugin: multi1v1_kniferounds"] \
        parm    [list sm_multi1v1_kniferounds_enable] \
        parm    [list sm_multi1v1_kniferounds_lanonly] \
        space   [list] \
        h2      [list "Plugin: multi1v1_online_stats_viewer"] \
        parm    [list sm_multi1v1_online_stats_viewer_enable] \
        parm    [list sm_multi1v1_online_stats_viewer_lanonly] \
        space   [list] \
        h2      [list "Plugin: gunmenu"] \
        parm    [list sm_gunmenu_enable] \
        parm    [list sm_gunmenu_lanonly] \
        space   [list] \
        h2      [list "Plugin: cksurf"] \
        parm    [list sm_cksurf_enable] \
        parm    [list sm_cksurf_lanonly] \
        space   [list] \
        h2      [list "Plugin: retakes"] \
        parm    [list sm_retakes_enable] \
        parm    [list sm_retakes_lanonly] \
        space   [list] \
        h2      [list "Plugin: retakes_sitepicker"] \
        parm    [list sm_retakes_sitepicker_enable] \
        parm    [list sm_retakes_sitepicker_lanonly] \
        space   [list] \
        h2      [list "Plugin: retakes_standardallocator"] \
        parm    [list sm_retakes_standardallocator_enable] \
        parm    [list sm_retakes_standardallocator_lanonly] \
        space   [list] \
        h2      [list "Plugin: retakes_pistolallocator"] \
        parm    [list sm_retakes_pistolallocator_enable] \
        parm    [list sm_retakes_pistolallocator_lanonly] \
        space   [list] \
        h2      [list "Plugin: influx"] \
        parm    [list sm_influx_enable] \
        parm    [list sm_influx_lanonly] \
        space   [list] \
        h2      [list "Plugin: splewis_get5"] \
        parm    [list sm_splewis_get5_enable] \
        parm    [list sm_splewis_get5_lanonly] \
        space   [list] \
        h2      [list "Plugin: shanapu_myweaponallocator"] \
        parm    [list sm_shanapu_myweaponallocator_enable] \
        parm    [list sm_shanapu_myweaponallocator_lanonly] \
        space   [list] \
        h2      [list "Plugin: splewis_pugsetup"] \
        parm    [list sm_splewis_pugsetup_enable] \
        parm    [list sm_splewis_pugsetup_lanonly] \
        space   [list] \
        warning [list "All plugins below this line require the banprotection to be disabled. Read the help page carefully before"] \
        warning [list "disabling banprotection. Running misbehaving sourcemod plugins may cause your server to be banned by Valve."] \
        warning [list "*** I take no responsibility for if your server gets banned ***"] \
        line    [list] \
        space   [list] \
        parm    [list banprotection] \
        warning [list "The first time you enable banprotection you need to update the server by clicking the \"Update Server\" button"] \
        warning [list "above. This will install the plugins below. The plugins will still be disabled until you enable them below. If you"] \
        warning [list "decide to reenable banprotection read the help page for instructions on how to ensure that plugins below are"] \
        warning [list "completely removed from the file system."] \
        space   [list] \
        h2      [list "Plugin: Franug-Weapon_Paints"] \
        parm    [list sm_franug_weaponpaints_enable] \
        parm    [list sm_franug_weaponpaints_lanonly] \
        parm    [list sm_franug_weaponpaints_onlyadmin] \
        parm    [list sm_franug_weaponpaints_c4] \
        parm    [list sm_franug_weaponpaints_saytimer] \
        parm    [list sm_franug_weaponpaints_roundtimer] \
        parm    [list sm_franug_weaponpaints_rmenu] \
        parm    [list sm_franug_weaponpaints_zombiesv] \
        space   [list] \
        h2      [list "Plugin: Franug-Knifes"] \
        parm    [list sm_franug_knifes_enable] \
        parm    [list sm_franug_knifes_lanonly] \
    ] \
]

proc SetSourcemodState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list lanonly banprotection admins sm_mapchooser_enable sm_mapchooser_lanonly sm_mapchooser_mapvote_endvote\
                  sm_nominations_enable sm_nominations_lanonly sm_rockthevote_enable sm_rockthevote_lanonly\
                  sm_nextmap_enable sm_nextmap_lanonly sm_randomcycle_enable sm_randomcycle_lanonly\
                  sm_warmod_enable sm_warmod_lanonly sm_multi1v1_enable sm_multi1v1_lanonly sm_multi1v1_flashbangs_enable\
                  sm_multi1v1_flashbangs_lanonly sm_multi1v1_kniferounds_enable sm_multi1v1_kniferounds_lanonly\
                  sm_multi1v1_online_stats_viewer_enable sm_multi1v1_online_stats_viewer_enable sm_multi1v1_online_stats_viewer_lanonly\
                  sm_gunmenu_enable sm_gunmenu_lanonly sm_cksurf_enable sm_cksurf_lanonly\
                  sm_retakes_enable sm_retakes_lanonly sm_retakes_sitepicker_enable sm_retakes_sitepicker_lanonly\
                  sm_retakes_standardallocator_enable sm_retakes_standardallocator_lanonly sm_retakes_pistolallocator_enable sm_retakes_pistolallocator_lanonly\
                  sm_influx_enable sm_influx_lanonly\
                  sm_splewis_get5_enable sm_splewis_get5_lanonly\
                  sm_shanapu_myweaponallocator_enable sm_shanapu_myweaponallocator_lanonly\
                  sm_splewis_pugsetup_enable sm_splewis_pugsetup_lanonly\
                  sm_franug_weaponpaints_enable sm_franug_weaponpaints_lanonly sm_franug_weaponpaints_onlyadmin\
                  sm_franug_weaponpaints_c4 sm_franug_weaponpaints_saytimer sm_franug_weaponpaints_roundtimer sm_franug_weaponpaints_rmenu\
                  sm_franug_weaponpaints_zombiesv sm_franug_knifes_enable sm_franug_knifes_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    global sourcemodConfig
    SetSourcemodMapChooserState [expr $enabled && [GetConfigItem $sourcemodConfig sm_mapchooser_enable]]
    SetSourcemodNominationsState [expr $enabled && [GetConfigItem $sourcemodConfig sm_nominations_enable]]
    SetSourcemodRockTheVoteState [expr $enabled && [GetConfigItem $sourcemodConfig sm_rockthevote_enable]]
    SetSourcemodNextMapState [expr $enabled && [GetConfigItem $sourcemodConfig sm_nextmap_enable]]
    SetSourcemodRandomCycleState [expr $enabled && [GetConfigItem $sourcemodConfig sm_randomcycle_enable]]
    SetSourcemodWarmodState [expr $enabled && [GetConfigItem $sourcemodConfig sm_warmod_enable]]
    SetSourcemodMulti1v1State [expr $enabled && [GetConfigItem $sourcemodConfig sm_multi1v1_enable]]
    SetSourcemodGunMenuState [expr $enabled && [GetConfigItem $sourcemodConfig sm_gunmenu_enable]]
    SetSourcemodCkSurfState [expr $enabled && [GetConfigItem $sourcemodConfig sm_cksurf_enable]]
    SetSourcemodRetakesState [expr $enabled && [GetConfigItem $sourcemodConfig sm_retakes_enable]]
    SetSourcemodInfluxState [expr $enabled && [GetConfigItem $sourcemodConfig sm_influx_enable]]
    SetSourcemodSplewisGet5State [expr $enabled && [GetConfigItem $sourcemodConfig sm_splewis_get5_enable]]
    SetSourcemodShanapuMyWeaponAllocatorState [expr $enabled && [GetConfigItem $sourcemodConfig sm_shanapu_myweaponallocator_enable]]
    SetSourcemodSplewisPugSetupState [expr $enabled && [GetConfigItem $sourcemodConfig sm_splewis_pugsetup_enable]]
    SetSourcemodFranugWeaponPaintsState [expr $enabled && [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_enable]]
    SetSourcemodFranugKnifesState [expr $enabled && [GetConfigItem $sourcemodConfig sm_franug_knifes_enable]]
    return $value
}


proc SetSourcemodMapChooserState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_mapchooser_lanonly sm_mapchooser_mapvote_endvote] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}

proc SetSourcemodNominationsState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_nominations_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}

proc SetSourcemodRockTheVoteState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_rockthevote_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}

proc SetSourcemodNextMapState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_nextmap_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodRandomCycleState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_randomcycle_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodWarmodState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_warmod_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodMulti1v1State { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_multi1v1_lanonly sm_multi1v1_flashbangs_enable\
                  sm_multi1v1_flashbangs_lanonly sm_multi1v1_kniferounds_enable sm_multi1v1_kniferounds_lanonly\
                  sm_multi1v1_online_stats_viewer_enable sm_multi1v1_online_stats_viewer_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodGunMenuState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_gunmenu_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodCkSurfState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_cksurf_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodRetakesState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_retakes_lanonly sm_retakes_sitepicker_enable\
                  sm_retakes_sitepicker_lanonly sm_retakes_standardallocator_enable sm_retakes_standardallocator_lanonly\
                  sm_retakes_pistolallocator_enable sm_retakes_pistolallocator_lan_only] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodRetakesPistolAllocatorValue { value } {
    global sourcemodConfig
    if { $value == "0" } {
        return $value
    }
    set otherValue [GetConfigItem $sourcemodConfig sm_retakes_pistolallocator_enable]
    if { $otherValue == "1"} {
        SetConfigItem $sourcemodConfig sm_retakes_pistolallocator_enable "0"
    }
    return $value
}
proc SetSourcemodRetakesStandardAllocatorValue { value } {
    global sourcemodConfig
    if { $value == "0" } {
        return $value
    }
    set otherValue [GetConfigItem $sourcemodConfig sm_retakes_standardallocator_enable]
    if { $otherValue == "1"} {
        SetConfigItem $sourcemodConfig sm_retakes_standardallocator_enable "0"
    }
    return $value
}
proc SetSourcemodInfluxState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_influx_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodSplewisGet5State { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_splewis_get5_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodShanapuMyWeaponAllocatorState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_shanapu_myweaponallocator_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
proc SetSourcemodSplewisPugSetupState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_splewis_pugsetup_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}

proc SetSourcemodFranugWeaponPaintsState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_franug_weaponpaints_lanonly sm_franug_weaponpaints_onlyadmin\
                  sm_franug_weaponpaints_c4 sm_franug_weaponpaints_saytimer sm_franug_weaponpaints_roundtimer sm_franug_weaponpaints_rmenu\
                  sm_franug_weaponpaints_zombiesv] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}

proc SetSourcemodFranugKnifesState { value } {
    global sourcemodLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list sm_franug_knifes_lanonly] {
        SetConfigItemState $cp.sourcemod $sourcemodLayout $parm $enabled
    }
    return $value
}
