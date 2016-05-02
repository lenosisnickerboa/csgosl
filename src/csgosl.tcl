#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

package require Tk
package require Img

#Handle case when not running in a starkit
namespace eval starkit {
if {! [info exists topdir] } {
    set topdir "bin"    
}
}

source [file join $starkit::topdir version.tcl]
source [file join $starkit::topdir os.tcl]
source [file join $starkit::topdir unzip.tcl]
source [file join $starkit::topdir untar.tcl]
source [file join $starkit::topdir config.tcl]
source [file join $starkit::topdir config_file.tcl]
source [file join $starkit::topdir config_page.tcl]
source [file join $starkit::topdir maps_support.tcl]
source [file join $starkit::topdir layout.tcl]
source [file join $starkit::topdir widgets.tcl]
source [file join $starkit::topdir executor.tcl]
source [file join $starkit::topdir server_support.tcl]
source [file join $starkit::topdir wget.tcl]
source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir sframe.tcl]

proc RunAssync {command} {
    global executorCommand
    set executorCommand "$command"
    ExecutorRun
}

proc Every {ms body} {
    if 1 $body
    after $ms [list after idle [info level 0]]
}

proc SaveProcDummy {} {
}

proc SaveAll {} {
    global serverPresent
    SaveConfigFileServer
    if { $serverPresent } {
        SaveConfigFileOrigServer
    }
    SaveConfigFileSteam
    if { $serverPresent } {
        SaveConfigFileMapGroups
        SaveConfigFileRun 
        SaveConfigFileApplication
        SaveConfigFileGameModeAll
        SaveConfigFileGameModeArmsrace
        SaveConfigFileGameModeClassicCasual
        SaveConfigFileGameModeClassicCompetitive
        SaveConfigFileGameModeDemolition
        SaveConfigFileGameModeDeathmatch
        SaveConfigFileGameModeTraining
        SaveConfigFileGameModeCustom
        SaveConfigFileGameModeCooperative
    }
}

proc SetStartStopServerButtonText {} {
    set status [DetectServerRunning]
    if { $status == "running" } {
        .title.startstop configure -text "Stop server" -command StopServer
    } else {
        .title.startstop configure -text "Start server" -command StartServer        
    }
}

#main

#Default value until config is read
set traceEnabled 0

variable currentOs [Os]

set serverControlScript "bin/server.sh"
if { $currentOs == "windows" } {
    set serverControlScript "bin/server"
}

set installFolder [pwd]
set serverFolder "$installFolder/server"
set serverPresent [DetectServerInstalled "$serverFolder"]
set serverCfgPath "$serverFolder/csgo/cfg"
set steamcmdFolder "$installFolder/steamcmd"

if { !$serverPresent } {
    tk_dialog .w "No installed server detected..." \
    "No installed server was detected. csgosl will start in minimal mode to allow a server to be installed. When install is finished restart csgosl to get access to the full application." \
    "" 0 "I understand"
}

set configFolder "cfg"
file mkdir $configFolder
set binFolder "bin"
file mkdir $binFolder

set name "csgosl"
set currentDir [pwd]
set windowWidth 800
set windowHeigth 600
set defaultPadY 5
set defaultPadX 5
set hostName [info hostname]
set status "Idle"

## Application config
source [file join $starkit::topdir page_application.tcl]

EnsureConfigFile applicationConfig
LoadConfigFile applicationConfig 
SetConfigItem $applicationConfig mainwingeometry [GetConfigValue $applicationConfig mainwingeometry]

proc SaveConfigFileApplication {} {
    SaveConfigFile applicationConfig
}

set traceEnabled [GetConfigValue $applicationConfig trace]

set tclConsoleEnabled [GetConfigValue $applicationConfig tclconsole]

if { $tclConsoleEnabled } {
    catch {console show}
}

variable mainWinGeometry [GetConfigValue $applicationConfig mainwingeometry]
variable oldMainWinGeometry $mainWinGeometry

CreateWindow $mainWinGeometry $name $version

SetTitle "$name $version - loading configuration..."

CreateSetDefaultImage
source [file join $starkit::topdir page_server.tcl]

EnsureConfigFile serverConfig
LoadConfigFile serverConfig
proc SaveConfigFileServer {} {
    SaveConfigFile serverConfig
}

variable serverOrigConfig [CreateConfig \
    [list \
        name     "serverOrigConfig" \
        prefix   "ServerOrig" \
        fileName "$serverFolder/csgo/cfg/server.cfg" \
        saveProc "SaveConfigFileOrigServer" \
    ] \
    [list \
        "int"       [list sv_maxrate "0" "dc"]\
        "int"       [list sv_minrate "100000" "dc"]\
        "int"       [list sv_maxupdaterate "128" "dc"]\
        "int"       [list sv_minupdaterate "128" "dc"]\
        "int"       [list sv_maxcmdrate "128" "dc"]\
        "int"       [list sv_mincmdrate "128" "dc"]\
        "int"       [list net_splitpacket_maxrate "30000" "dc"]\
        "string"    [list rcon_password "" "dc"]\
        "line"      [list netmaxfilesize "sm_cvar net_maxfilesize 64" "dc"]\
    ] \
]

if { $serverPresent } {
    EnsureConfigFile serverOrigConfig
    LoadConfigFile serverOrigConfig
}
proc SaveConfigFileOrigServer {} {
    global serverOrigConfig
    global serverConfig
    SetConfigItem $serverOrigConfig sv_maxrate 0
    SetConfigItem $serverOrigConfig sv_minrate 100000
    set tickRate [GetConfigItem $serverConfig tickrate]
    SetConfigItem $serverOrigConfig sv_minupdaterate $tickRate
    SetConfigItem $serverOrigConfig sv_maxupdaterate $tickRate
    SetConfigItem $serverOrigConfig sv_mincmdrate $tickRate
    SetConfigItem $serverOrigConfig sv_maxcmdrate $tickRate
    SetConfigItem $serverOrigConfig net_splitpacket_maxrate 30000
    set rconEnable [GetConfigItem $serverConfig rcon]
    if { $rconEnable == "1" } {
        set rconPassword [GetConfigItem $serverConfig rconpassword]
        SetConfigItem $serverOrigConfig rcon_password $rconPassword        
    } else {
        SetConfigItem $serverOrigConfig rcon_password "Do not care, disabled"        
    }
    set netmaxfilesize [GetConfigItem $serverConfig netmaxfilesize]
    set netmaxfilesizeName [GetGlobalConfigVariableName ServerOrig netmaxfilesize]
    global $netmaxfilesizeName
    set $netmaxfilesizeName "sm_cvar net_maxfilesize $netmaxfilesize"
    SaveConfigFile serverOrigConfig
}

## Steam config
source [file join $starkit::topdir page_steam.tcl]

EnsureConfigFile steamConfig
LoadConfigFile steamConfig 
proc SaveConfigFileSteam {} {
    SaveConfigFile steamConfig
    SaveSourceModAdmins steamConfig
}

## Maps config
SetTitle "$name $version - loading maps..."
variable allMaps
variable allMapsMeta
GetMaps "$serverFolder/csgo/maps/" allMaps allMapsMeta
CacheMaps $allMaps $allMapsMeta    
source [file join $starkit::topdir page_maps.tcl]

SetTitle "$name $version - loading configuration..."
## Map groups config
source [file join $starkit::topdir page_mapgroups.tcl]
EnsureConfigFile mapGroupsConfig
LoadConfigFile mapGroupsConfig
proc SaveConfigFileMapGroups {} {
    global configFolder
    global serverFolder
    SaveConfigFile mapGroupsConfig
    SaveMapGroupsMapper "$configFolder/mapGroupsMapper.cfg"
    SaveGameModesServer "$serverFolder/csgo/gamemodes_server.txt"
}
variable mapGroupsMapper [dict create]
EnsureEmptyFile "$configFolder/mapGroupsMapper.cfg"
LoadMapGroupsMapper "$configFolder/mapGroupsMapper.cfg"

## Run config
variable gameModeMapper [dict create \
                         "Classic Casual"      [dict create type 0 mode 0] \
                         "Classic Competitive" [dict create type 0 mode 1] \
                         "Armsrace"            [dict create type 1 mode 0] \
                         "Demolition"          [dict create type 1 mode 1] \
                         "Deathmatch"          [dict create type 1 mode 2] \
                         "Training"            [dict create type 2 mode 0] \
                         "Custom"              [dict create type 3 mode 0] \
                         "Cooperative"         [dict create type 4 mode 0]]

variable botSkillMapper [dict create \
                         "Easy" 0 \
                         "Normal" 1 \
                         "Hard" 2 \
                         "Expert" 3]

source [file join $starkit::topdir page_run.tcl]

EnsureConfigFile runConfig
LoadConfigFile runConfig 
proc SaveConfigFileRun {} {
    global botSkillMapper
    global runConfig
    global gameModeAllConfig
    SaveConfigFile runConfig
    
    set players [GetConfigItem $runConfig players]
    set fillWithBots [GetConfigItem $runConfig fillwithbots]
    if {$fillWithBots == "1"} {
        SetConfigItem $gameModeAllConfig bot_quota $players
        SetConfigItem $gameModeAllConfig bot_quota_mode fill
    } else {
        set bots [GetConfigItem $runConfig bots]
        SetConfigItem $gameModeAllConfig bot_quota_mode normal
        SetConfigItem $gameModeAllConfig bot_quota $bots
    }
    
    SetConfigItem $gameModeAllConfig bot_difficulty [dict get $botSkillMapper [GetConfigItem $runConfig botskill]]
    
    set immediateStart [GetConfigItem $runConfig immediatestart]
    if {$immediateStart == "1"} {
        SetConfigItem $gameModeAllConfig mp_freezetime 0
        SetConfigItem $gameModeAllConfig mp_warmuptime 0
    } else {
        SetConfigItemDefault $gameModeAllConfig mp_freezetime
        SetConfigItemDefault $gameModeAllConfig mp_warmuptime
    }
    
    set friendlyFire [GetConfigItem $runConfig friendlyfire]
    SetConfigItem $gameModeAllConfig mp_friendlyfire $friendlyFire

#    set vote [GetConfigItem $runConfig vote]
#    SetConfigItem $gameModeAllConfig sv_allow_votes $vote
#    SetConfigItem $gameModeAllConfig sv_vote_issue_kick_allowed $vote
#    SetConfigItem $gameModeAllConfig sv_vote_issue_restart_game_allowed $vote
#    SetConfigItem $gameModeAllConfig sv_vote_allow_spectators $vote
#    SetConfigItem $gameModeAllConfig sv_vote_allow_in_warmup $vote
#    SetConfigItem $gameModeAllConfig mp_endmatch_votenextmap_keepcurrent $vote
#    SetConfigItem $gameModeAllConfig mp_endmatch_votenextmap $vote
#    SetConfigItem $gameModeAllConfig mp_match_end_restart $vote
#    SetConfigItem $gameModeAllConfig mp_match_end_changelevel $vote
#    if {$vote == "1"} {
#        SetConfigItem $gameModeAllConfig sv_vote_to_changelevel_before_match_point 0      
#    } else {
#        SetConfigItem $gameModeAllConfig sv_vote_to_changelevel_before_match_point 1
#    }
    
    set roundTime [GetConfigItem $runConfig roundtime]
    SetConfigItem $gameModeAllConfig mp_roundtime $roundTime

    set killCam [GetConfigItem $runConfig killcam]
    if {$killCam == "1"} {
        SetConfigItem $gameModeAllConfig mp_forcecamera 0
    } else {
        SetConfigItem $gameModeAllConfig mp_forcecamera 1       
    }
}

## Console config

source [file join $starkit::topdir page_console.tcl]

## About config
source [file join $starkit::topdir page_about.tcl]

# gameModeArmsrace config
# gameModeClassicCasual config
# gameModeClassicCompetitive config
# gameModeDemolition config
# gameModeDeathmatch config
# gameModeTraining config
# gameModeCustom config
# gameModeCooperative config
# allModes config

source [file join $starkit::topdir page_advanced.tcl]

if {$serverPresent} {
    EnsureConfigFile gameModeArmsraceConfig
    LoadSplitConfigFile gameModeArmsraceConfig
    EnsureConfigFile gameModeClassicCasualConfig
    LoadSplitConfigFile gameModeClassicCasualConfig 
    EnsureConfigFile gameModeClassicCompetitiveConfig
    LoadSplitConfigFile gameModeClassicCompetitiveConfig 
    EnsureConfigFile gameModeDemolitionConfig
    LoadSplitConfigFile gameModeDemolitionConfig
    EnsureConfigFile gameModeDeathmatchConfig
    LoadSplitConfigFile gameModeDeathmatchConfig
    EnsureConfigFile gameModeTrainingConfig
    LoadSplitConfigFile gameModeTrainingConfig
    EnsureConfigFile gameModeCustomConfig
    LoadSplitConfigFile gameModeCustomConfig
    EnsureConfigFile gameModeCooperativeConfig
    LoadSplitConfigFile gameModeCooperativeConfig
}

variable gameModeArmsraceLayout             [CreateDefaultLayoutFromConfig $gameModeArmsraceConfig]
variable gameModeClassicCasualLayout        [CreateDefaultLayoutFromConfig $gameModeClassicCasualConfig]
variable gameModeClassicCompetitiveLayout   [CreateDefaultLayoutFromConfig $gameModeClassicCompetitiveConfig]
variable gameModeDemolitionLayout           [CreateDefaultLayoutFromConfig $gameModeDemolitionConfig]
variable gameModeDeathmatchLayout           [CreateDefaultLayoutFromConfig $gameModeDeathmatchConfig]
variable gameModeTrainingLayout             [CreateDefaultLayoutFromConfig $gameModeTrainingConfig]
variable gameModeCustomLayout               [CreateDefaultLayoutFromConfig $gameModeCustomConfig]
variable gameModeCooperativeLayout          [CreateDefaultLayoutFromConfig $gameModeCooperativeConfig]

proc SaveConfigFileGameModeArmsrace {} {
    SaveSplitConfigFile gameModeArmsraceConfig
}
proc SaveConfigFileGameModeClassicCasual {} {
    SaveSplitConfigFile gameModeClassicCasualConfig
}
proc SaveConfigFileGameModeClassicCompetitive {} {
    SaveSplitConfigFile gameModeClassicCompetitiveConfig
}
proc SaveConfigFileGameModeDemolition {} {
    SaveSplitConfigFile gameModeDemolitionConfig
}
proc SaveConfigFileGameModeDeathmatch {} {
    SaveSplitConfigFile gameModeDeathmatchConfig
}
proc SaveConfigFileGameModeCustom {} {
    SaveSplitConfigFile gameModeCustomConfig
}
proc SaveConfigFileGameModeCooperative {} {
    SaveSplitConfigFile gameModeCooperativeConfig
}
proc SaveConfigFileGameModeTraining {} {
    SaveSplitConfigFile gameModeTrainingConfig
}

source [file join $starkit::topdir page_advanced_all.tcl]

if {$serverPresent} {
    EnsureConfigFile gameModeAllConfig
    LoadConfigFile gameModeAllConfig
}

variable gameModeAllLayout [CreateDefaultLayoutFromConfig $gameModeAllConfig]

proc SaveConfigFileGameModeAll {} {
    SaveConfigFile gameModeAllConfig
    global gameModeConfigs
    global gameModeAllConfig
    foreach {key value} [dict get $gameModeAllConfig values] {
        if {$value != ""} {
            foreach {config} $gameModeConfigs {
                set prefix [dict get $config prefix]
                set valueName [GetGlobalConfigVariableName $prefix $key]
                global $valueName
                SetConfigItem $config $key "$value"
                set $valueName $value                
            }
        }
    }
}

SetTitle "$name $version - initializing GUI components..."

frame .title -borderwidth 10 
pack [CreateTitle .title $serverPresent] -side top
#pack [Separator .topSep] -side left -fill x -expand true
frame .config -borderwidth 10 
pack [set cp [CreateConfigPages .config $windowWidth $windowHeigth]] -side left -fill both -expand true
#pack [Separator .bottomSep] -side left -fill x -expand true
#pack [CreateStatus $top.status status currentDir hostName] -side left -fill x -expand true

set enableTab 1

CreateConfigPageTabFromLayout $cp.server $serverLayout $enableTab
set serverPage [CreateConfigPageFromLayout $cp.server $serverLayout]

CreateConfigPageTabFromLayout $cp.steam $steamLayout $enableTab
set steamPage [CreateConfigPageFromLayout $cp.steam $steamLayout]

CreateConfigPageTabFromLayout $cp.maps $mapsLayout $enableTab
set mapsPage [CreateConfigPageFromLayout $cp.maps $mapsLayout]

CreateConfigPageTabFromLayout $cp.mapGroups $mapGroupsLayout [expr $enableTab && $serverPresent]
set mapGroupsPage [CreateConfigPageFromLayout $cp.mapGroups $mapGroupsLayout]

CreateConfigPageTabFromLayout $cp.run $runLayout [expr $enableTab && $serverPresent]
set runPage [CreateConfigPageFromLayout $cp.run $runLayout]

if {$currentOs == "windows"} {
    CreateConfigPageTabFromLayout $cp.console $consoleLayout $enableTab
    set consolePage [CreateConfigPageFromLayout $cp.console $consoleLayout]
}

CreateConfigPageTabFromLayout $cp.application $applicationLayout [expr $enableTab && $serverPresent]
set applicationPage [CreateConfigPageFromLayout $cp.application $applicationLayout]
set fullConfig [expr [GetConfigValue $applicationConfig fullconfig] == "1"]

CreateConfigPageTabFromLayout $cp.about $aboutLayout [expr $enableTab]
set aboutPage [CreateConfigPageFromLayout $cp.about $aboutLayout]

CreateConfigPageTabFromLayout $cp.gameModeAll $gameModeAllLayout [expr $fullConfig && $serverPresent]
set gameModeAllPage [CreateConfigPageFromLayout $cp.gameModeAll $gameModeAllLayout]

CreateConfigPageTabFromLayout $cp.gameModeClassicCasual $gameModeClassicCasualLayout [expr $fullConfig && $serverPresent]
set gameModeClassicCasualPage [CreateConfigPageFromLayout $cp.gameModeClassicCasual $gameModeClassicCasualLayout]

CreateConfigPageTabFromLayout $cp.gameModeClassicCompetitive $gameModeClassicCompetitiveLayout [expr $fullConfig && $serverPresent]
set gameModeClassicCompetitivePage [CreateConfigPageFromLayout $cp.gameModeClassicCompetitive $gameModeClassicCompetitiveLayout]

CreateConfigPageTabFromLayout $cp.gameModeArmsrace $gameModeArmsraceLayout [expr $fullConfig && $serverPresent]
set gameModeArmsracePage [CreateConfigPageFromLayout $cp.gameModeArmsrace $gameModeArmsraceLayout]

CreateConfigPageTabFromLayout $cp.gameModeDemolition $gameModeDemolitionLayout [expr $fullConfig && $serverPresent]
set gameModeDemolitionPage [CreateConfigPageFromLayout $cp.gameModeDemolition $gameModeDemolitionLayout]

CreateConfigPageTabFromLayout $cp.gameModeDeathmatch $gameModeDeathmatchLayout [expr $fullConfig && $serverPresent]
set gameModeDeathmatchPage [CreateConfigPageFromLayout $cp.gameModeDeathmatch $gameModeDeathmatchLayout]

CreateConfigPageTabFromLayout $cp.gameModeTraining $gameModeTrainingLayout [expr $fullConfig && $serverPresent]
set gameModeTrainingPage [CreateConfigPageFromLayout $cp.gameModeTraining $gameModeTrainingLayout]

CreateConfigPageTabFromLayout $cp.gameModeCustom $gameModeCustomLayout [expr $fullConfig && $serverPresent]
set gameModeCustomPage [CreateConfigPageFromLayout $cp.gameModeCustom $gameModeCustomLayout]

CreateConfigPageTabFromLayout $cp.gameModeCooperative $gameModeCooperativeLayout [expr $fullConfig && $serverPresent]
set gameModeCooperativePage [CreateConfigPageFromLayout $cp.gameModeCooperative $gameModeCooperativeLayout]    

if {$serverPresent} {
    $cp select $runPage
} else {
    $cp select $serverPage
}
variable configPages $cp
pack .config -side top -fill both -expand true

if {$serverPresent} {
    set autoUpdateOnStart [GetConfigValue $steamConfig autoupdateonstart]
    if { $autoUpdateOnStart == "1" } {
        SetTitle "$name $version - auto updating..."
        if{$currentOs == "windows"} {
            $cp select $consolePage
        }
        UpdateServer
    }
}

if {$serverPresent} {
    SetTitle "$name $version"
} else {
    SetTitle "$name $version -- install server by clicking on \"Install Server\" button! Then restart csgosl!"    
}

if {$serverPresent} {
    Every 2000 SetStartStopServerButtonText
}

proc StoreChangedMainWinGeometry {} {
    global mainWinGeometry
    global oldMainWinGeometry
    if { $mainWinGeometry != $oldMainWinGeometry } {
#        puts "Changed geometry to $mainWinGeometry from $oldMainWinGeometry"
        set oldMainWinGeometry $mainWinGeometry
        global applicationConfig
        SetConfigItem $applicationConfig mainwingeometry $mainWinGeometry
    	SaveConfigFileApplication
    }
}
if {$serverPresent} {
    bind . <Configure> {
	global mainWinGeometry
# winfo and wm give slightly different results?!? None of them
# can be used to exactly restore the window position!?!
#	set mainWinGeometry [winfo geometry .]
	set mainWinGeometry [wm geometry .]
#	puts "Window %W has changed width to %w and height to %h"
    }
    Every 2000 StoreChangedMainWinGeometry
}

#bind . <KeyPress> {puts "You pressed the key named: %K "}
#bind . <ButtonPress> {puts "You pressed button: %b at %x %y"}

