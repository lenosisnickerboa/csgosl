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
source [file join $starkit::topdir latest_release.tcl]
source [file join $starkit::topdir config.tcl]
source [file join $starkit::topdir config_file.tcl]
source [file join $starkit::topdir config_page.tcl]
source [file join $starkit::topdir maps_support.tcl]
source [file join $starkit::topdir layout.tcl]
source [file join $starkit::topdir widgets.tcl]
source [file join $starkit::topdir executor.tcl]
source [file join $starkit::topdir rcon_executor.tcl]
source [file join $starkit::topdir server_support.tcl]
source [file join $starkit::topdir wget.tcl]
source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir sframe.tcl]
source [file join $starkit::topdir browser.tcl]
source [file join $starkit::topdir autoexec_support.tcl]

proc RunAssync {command} {
    global executorCommand
    set executorCommand "$command"
    if { [IsDryRun] } {
        Trace "*** THIS IS A DRY RUN! ***"
        return 0
    }
    ExecutorRun
}

proc Every {ms body} {
    if 1 $body
    after $ms [list after idle [info level 0]]
}

proc IsDryRun {} {
    global applicationConfig
    GetConfigValue $applicationConfig dryrun
}

proc SaveProcDummy {} {
}

proc SaveAll { {skipStandalone ""} } {
    global serverPresent
    SaveConfigFileServer
    SaveConfigFileGoTv
    if { $serverPresent } {
        SaveConfigFileOrigServer
    }
    SaveConfigFileSteam
    if { $serverPresent } {
        SaveConfigFileRconCli
        SaveConfigFileMapGroups
        SaveConfigFileRun 
        SaveConfigFileAutoexec
        SaveConfigFileSourcemod
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
        if { $skipStandalone != "skipStandalone" } {
            CreateStandalone
            global serverConfig installFolder
            set updateServerOnStart [GetConfigValue $serverConfig updateserveronstart]
            set startServerOnStart [GetConfigValue $serverConfig startserveronstart]
            CreateAssyncUpdateAndStart "$installFolder/bin/onstart" $updateServerOnStart $startServerOnStart
            set restartServerAtRestart 0
            if {[GetConfigValue $serverConfig restartserverat] != ""} {
                set restartServerAtRestart 1
            }
            CreateAssyncUpdateAndStart "$installFolder/bin/onrestart" [GetConfigValue $serverConfig updateserveronrestart] $restartServerAtRestart
        }
    }
}

variable lastServerName ""
proc PeriodicWindowUpdate {} {
    set status [DetectServerRunning]
    if { $status == "running" } {
        .title.startstop configure -text "Stop server" -command StopServer
    } else {
        .title.startstop configure -text "Start server" -command StartServer        
    }
    global lastServerName
    global serverConfig
    global name
    global version
    set currentServerName [GetConfigValue $serverConfig name]
    if { $lastServerName != $currentServerName } {
        set lastServerName "$currentServerName"
        SetTitle "$name $version -- $lastServerName"
    }
}

#main

set ValueToSkip "--skip--"
set DisableParmPrefix "_enable_"

#Default value until config is read
set traceEnabled 0

variable currentOs [Os]

set installFolder [pwd]
set NeedsUpgradeFileName "$installFolder/bin/needsupgrade"
set needsUpgrade [file exists "$NeedsUpgradeFileName"]
set serverFolder "$installFolder/server"
set serverCfgPath "$serverFolder/csgo/cfg"
set steamcmdFolder "$installFolder/steamcmd"
set modsFolder "$serverFolder/csgo/addons"
set srcdsName "srcds_run"
if { $currentOs == "windows" } {
    set srcdsName "srcds.exe"
}
set serverExeFullName "$serverFolder/$srcdsName"
set serverPresent [DetectServerInstalled "$serverFolder"]

set serverControlScript "$installFolder/bin/server.sh"
if { $currentOs == "windows" } {
    set serverControlScript "$installFolder/bin/server"
}
if { !$serverPresent } {
    tk_dialog .w "No installed server detected..." \
    "No installed server was detected. csgosl will start in minimal mode to allow a server to be installed. When install is finished restart csgosl to get access to the full application." \
    "" 0 "I understand"
}

set configFolder "cfg"
file mkdir $configFolder
set binFolder "bin"
file mkdir $binFolder

set steamUpdateFilename "$installFolder/$binFolder/steamcmd.txt"

set steamCmdExe "steamcmd.sh"
if {$currentOs == "windows"} {
    set steamCmdExe "steamcmd.exe"        
}

set name "csgosl"
set currentDir [pwd]
set windowWidth 800
set windowHeigth 600
set defaultPadY 5
set defaultPadX 5
set hostName [info hostname]
set status "Idle"
set fullConfigEnabled "0"

## Application config
source [file join $starkit::topdir page_application.tcl]

EnsureConfigFile applicationConfig
LoadConfigFile applicationConfig 
SetConfigItem $applicationConfig mainwingeometry [GetConfigValue $applicationConfig mainwingeometry]

proc SaveConfigFileApplication {} {
    SaveConfigFile applicationConfig
}

set traceEnabled [GetConfigValue $applicationConfig trace]
set fullConfigEnabled [GetConfigValue $applicationConfig fullconfig]

if { $needsUpgrade } {
    Trace "This is the first run after upgrade, upgrading..."
}

set tclConsoleEnabled [GetConfigValue $applicationConfig tclconsole]

if { $tclConsoleEnabled } {
    catch {console show}
}

variable mainWinGeometry [GetConfigValue $applicationConfig mainwingeometry]
variable oldMainWinGeometry $mainWinGeometry

CreateWindow $mainWinGeometry $name $version

SetTitle "$name $version - loading configuration..."

CreateSetDefaultImage
CreateDeleteCustomImage

source [file join $starkit::topdir page_server.tcl]

EnsureConfigFile serverConfig
LoadConfigFile serverConfig
proc SaveConfigFileServer {} {
    SaveConfigFile serverConfig   
    
    global serverConfig
    global gameModeAllConfig
    global DisableParmPrefix    
    
    set pausableEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}pausable]
    if { $pausableEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_pausable [GetConfigItem $serverConfig pausable]
    }
    set clientconsistencyEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}clientconsistency]
    if { $clientconsistencyEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_consistency [GetConfigItem $serverConfig clientconsistency]
    }
    set voiceEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}voice]
    if { $voiceEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_voiceenable [GetConfigItem $serverConfig voice]
    }
    set spectatorsEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}spectators]
    if { $spectatorsEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_allowspectators [GetConfigItem $serverConfig spectators]
    }
    set rconbanpenaltyEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}rconbanpenalty]
    if { $rconbanpenaltyEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_rcon_banpenalty [GetConfigItem $serverConfig rconbanpenalty]
    }
    set rconmaxfailuresEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}rconmaxfailures]
    if { $rconmaxfailuresEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_rcon_maxfailures [GetConfigItem $serverConfig rconmaxfailures]
    }
    set logenableEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}logenable]
    if { $logenableEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig log [GetConfigItem $serverConfig logenable]
    }
    set logbansEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}logbans]
    if { $logbansEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_logbans [GetConfigItem $serverConfig logbans]
    }
    set logechoEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}logecho]
    if { $logechoEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_logecho [GetConfigItem $serverConfig logecho]
    }
    set logfileEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}logfile]
    if { $logfileEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_logfile [GetConfigItem $serverConfig logfile]
    }
    set logonefileEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}logonefile]
    if { $logonefileEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_log_onefile [GetConfigItem $serverConfig logonefile]
    }
    set alltalkEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}alltalk]
    if { $alltalkEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_alltalk [GetConfigItem $serverConfig alltalk]
    }
    set cheatsEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}cheats]
    if { $cheatsEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_cheats [GetConfigItem $serverConfig cheats]
    }
    set gravityEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}gravity]
    if { $gravityEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_gravity [GetConfigItem $serverConfig gravity]
    }   
    set autoteambalanceEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}autoteambalance]
    if { $autoteambalanceEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_autoteambalance [GetConfigItem $serverConfig autoteambalance]
    }   
    set tkpunishEnableSetting [GetConfigItem $serverConfig ${DisableParmPrefix}tkpunish]
    if { $tkpunishEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_tkpunish [GetConfigItem $serverConfig tkpunish]
    }
}

source [file join $starkit::topdir page_rcon_cli.tcl]
EnsureConfigFile rconCliConfig
LoadConfigFile rconCliConfig
proc SaveConfigFileRconCli {} {
    SaveConfigFile rconCliConfig    
}

source [file join $starkit::topdir page_gotv.tcl]

EnsureConfigFile gotvConfig
LoadConfigFile gotvConfig
proc SaveConfigFileGoTv {} {
    SaveConfigFile gotvConfig
}

if { $serverPresent && $needsUpgrade } {
    UpdateCfgs
}

variable serverOrigConfig [CreateConfig \
    [list \
        name     "serverOrigConfig" \
        prefix   "ServerOrig" \
        fileName "$serverFolder/csgo/cfg/server.cfg" \
        saveProc "SaveConfigFileOrigServer" \
    ] \
    [list \
        "int"       [list sv_maxrate "" ""]\
        "int"       [list sv_minrate "" ""]\
        "int"       [list sv_maxupdaterate "" ""]\
        "int"       [list sv_minupdaterate "" ""]\
        "int"       [list sv_maxcmdrate "" ""]\
        "int"       [list sv_mincmdrate "" ""]\
        "string"    [list sv_tags "" ""]\
        "int"       [list net_splitpacket_maxrate "" ""]\
        "string"    [list rcon_password "" ""]\
        "line"      [list netmaxfilesize "" ""]\
        "bool"      [list sm_mapvote_endvote "" ""]\
        "int"       [list sm_mapvote_voteduration "" ""]\
        "int"       [list sm_mapvote_include "" ""]\
        "int"       [list sm_mapvote_exclude "" ""]\
        "bool"      [list sm_weaponpaints_onlyadmin "" ""]\
        "bool"      [list sm_weaponpaints_c4 "" ""]\
        "int"       [list sm_weaponpaints_saytimer "" ""]\
        "int"       [list sm_weaponpaints_roundtimer "" ""]\
        "bool"      [list sm_weaponpaints_rmenu "" ""]\
        "bool"      [list sm_weaponpaints_zombiesv "" ""]\
        "bool"      [list tv_enable "" ""]\
        "int"       [list tv_port "" ""]\
        "string"    [list tv_title "" ""]\
        "string"    [list tv_password "" ""]\
        "int"       [list tv_delay "" ""]\
        "string"    [list tv_name "" ""]\
        "int"       [list tv_deltacache "" ""]\
        "int"       [list tv_snapshotrate "" ""]\
        "bool"      [list tv_allow_static_shots "" ""]\
        "int"       [list tv_delaymapchange "" ""]\
        "int"       [list tv_maxclients "" ""]\
        "int"       [list tv_advertise_watchable "" ""]\
        "bool"      [list mp_autokick "" ""]\
        "string"    [list sv_downloadurl "" ""]\
        "string"    [list sv_allowdownload "" ""]\
        "string"    [list sv_allowupload "" ""]\
    ] \
]

if { $serverPresent } {
    EnsureConfigFile serverOrigConfig
    LoadConfigFile serverOrigConfig
}
proc SaveConfigFileOrigServer {} {
    global ValueToSkip
    global serverOrigConfig
    global serverConfig
    global gotvConfig
    set minRate [GetConfigItem $serverConfig minrate]
    if { $minRate == "" } {
        set minRate "100000"
    }
    set maxRate [GetConfigItem $serverConfig maxrate]
    if { $maxRate == "" } {
        set maxRate "0"
    }
    SetConfigItem $serverOrigConfig sv_maxrate $maxRate
    SetConfigItem $serverOrigConfig sv_minrate $minRate
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

    set serverTags [GetConfigItem $serverConfig tags]
    SetConfigItem $serverOrigConfig sv_tags "$serverTags"
    
    set fastdlEnable [GetConfigItem $serverConfig fastdl]
    if { $fastdlEnable == "1" } {
        SetConfigItem $serverOrigConfig sv_downloadurl [GetConfigItem $serverConfig fastdlurl]
        SetConfigItem $serverOrigConfig sv_allowdownload "1"
        SetConfigItem $serverOrigConfig sv_allowupload "1"
    } else {
        SetConfigItem $serverOrigConfig sv_downloadurl $ValueToSkip
        SetConfigItem $serverOrigConfig sv_allowdownload $ValueToSkip
        SetConfigItem $serverOrigConfig sv_allowupload $ValueToSkip
    }
    
    global sourcemodConfig
    global runConfig
    set maps [GetActiveMaps [GetConfigValue $runConfig mapgroup]]
    if { [IsSourcemodPluginEnabled [GetConfigItem $sourcemodConfig sm_mapchooser_enable] [GetConfigItem $sourcemodConfig sm_mapchooser_lanonly]] } {
        SetConfigItem $serverOrigConfig sm_mapvote_endvote [GetConfigItem $sourcemodConfig sm_mapchooser_mapvote_endvote]
        SetConfigItem $serverOrigConfig sm_mapvote_voteduration [GetConfigItem $runConfig roundtime]
        SetConfigItem $serverOrigConfig sm_mapvote_include [llength $maps]
        SetConfigItem $serverOrigConfig sm_mapvote_exclude 0
    } else {
        SetConfigItem $serverOrigConfig sm_mapvote_endvote $ValueToSkip
        SetConfigItem $serverOrigConfig sm_mapvote_voteduration $ValueToSkip
        SetConfigItem $serverOrigConfig sm_mapvote_include $ValueToSkip
        SetConfigItem $serverOrigConfig sm_mapvote_exclude $ValueToSkip
    }

    if { [IsSourcemodPluginEnabled [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_enable] [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_lanonly]] } {
        SetConfigItem $serverOrigConfig sm_weaponpaints_c4 [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_c4]
        SetConfigItem $serverOrigConfig sm_weaponpaints_saytimer [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_saytimer]
        SetConfigItem $serverOrigConfig sm_weaponpaints_roundtimer [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_roundtimer]
        SetConfigItem $serverOrigConfig sm_weaponpaints_rmenu [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_rmenu]
        SetConfigItem $serverOrigConfig sm_weaponpaints_onlyadmin [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_onlyadmin]
        SetConfigItem $serverOrigConfig sm_weaponpaints_zombiesv [GetConfigItem $sourcemodConfig sm_franug_weaponpaints_zombiesv]        
    } else {
        SetConfigItem $serverOrigConfig sm_weaponpaints_c4 $ValueToSkip
        SetConfigItem $serverOrigConfig sm_weaponpaints_saytimer $ValueToSkip
        SetConfigItem $serverOrigConfig sm_weaponpaints_roundtimer $ValueToSkip
        SetConfigItem $serverOrigConfig sm_weaponpaints_rmenu $ValueToSkip
        SetConfigItem $serverOrigConfig sm_weaponpaints_onlyadmin $ValueToSkip
        SetConfigItem $serverOrigConfig sm_weaponpaints_zombiesv $ValueToSkip
    }
    
    set gotvEnable [GetConfigItem $gotvConfig gotvenable]
    SetConfigItem $serverOrigConfig tv_enable $gotvEnable
    if {$gotvEnable == 1} {
        SetConfigItem $serverOrigConfig tv_name [GetConfigItem $gotvConfig gotvname]
        SetConfigItem $serverOrigConfig tv_title [GetConfigItem $gotvConfig gotvtitle]
        SetConfigItem $serverOrigConfig tv_password [GetConfigItem $gotvConfig gotvpassword]
        SetConfigItem $serverOrigConfig tv_delay [GetConfigItem $gotvConfig gotvdelay]
        SetConfigItem $serverOrigConfig tv_port [GetConfigItem $gotvConfig gotvport]
        SetConfigItem $serverOrigConfig tv_deltacache [GetConfigItem $gotvConfig gotvdeltacache]
        SetConfigItem $serverOrigConfig tv_snapshotrate [GetConfigItem $gotvConfig gotvsnapshotrate]
        SetConfigItem $serverOrigConfig tv_allowcameraman [GetConfigItem $gotvConfig gotvallowcameraman]
        SetConfigItem $serverOrigConfig tv_allow_static_shots [GetConfigItem $gotvConfig gotvallowstaticshots]
        SetConfigItem $serverOrigConfig tv_autorecord [GetConfigItem $gotvConfig gotvautorecord]
        SetConfigItem $serverOrigConfig tv_chat [GetConfigItem $gotvConfig gotvchat]
        SetConfigItem $serverOrigConfig tv_delaymapchange [GetConfigItem $gotvConfig gotvdelaymapchange]
        SetConfigItem $serverOrigConfig tv_maxclients [GetConfigItem $gotvConfig gotvmaxclients]
        SetConfigItem $serverOrigConfig tv_advertise_watchable 1
    } else {
        SetConfigItem $serverOrigConfig tv_name $ValueToSkip
        SetConfigItem $serverOrigConfig tv_title $ValueToSkip
        SetConfigItem $serverOrigConfig tv_password $ValueToSkip
        SetConfigItem $serverOrigConfig tv_delay $ValueToSkip
        SetConfigItem $serverOrigConfig tv_port $ValueToSkip
        SetConfigItem $serverOrigConfig tv_deltacache $ValueToSkip
        SetConfigItem $serverOrigConfig tv_snapshotrate $ValueToSkip
        SetConfigItem $serverOrigConfig tv_allowcameraman $ValueToSkip
        SetConfigItem $serverOrigConfig tv_allow_static_shots $ValueToSkip
        SetConfigItem $serverOrigConfig tv_autorecord $ValueToSkip
        SetConfigItem $serverOrigConfig tv_chat $ValueToSkip
        SetConfigItem $serverOrigConfig tv_delaymapchange $ValueToSkip
        SetConfigItem $serverOrigConfig tv_maxclients $ValueToSkip
        SetConfigItem $serverOrigConfig tv_advertise_watchable $ValueToSkip
    }
    
    SetConfigItem $serverOrigConfig mp_autokick [GetConfigItem $serverConfig autokick]
    
    SaveConfigFile serverOrigConfig
#    set config [set $serverOrigConfig]
#    set fileName [dict get $config fileName]
    autoexec::Save
    autoexec::Activate
}

## Steam config
source [file join $starkit::topdir page_steam.tcl]

EnsureConfigFile steamConfig
LoadConfigFile steamConfig 
proc SaveConfigFileSteam {} {
    SaveConfigFile steamConfig
    SaveSourceModAdmins steamConfig
}

## Sourcemod config
source [file join $starkit::topdir page_sourcemod.tcl]

EnsureConfigFile sourcemodConfig
LoadConfigFile sourcemodConfig 
proc SaveConfigFileSourcemod {} {

    #Disable all risky plugins if banprotection is enabled
    global sourcemodConfig
    if {[GetConfigItem $sourcemodConfig banprotection]} {
        global sourcemodPlugins
        foreach {plugin pluginParms} $sourcemodPlugins {
            set pluginRisky [lindex $pluginParms 0]
            if { $pluginRisky } {
                set pluginEnabledName [lindex $pluginParms 1]
                SetConfigItem $sourcemodConfig $pluginEnabledName 0                
            }
        }
    }
    
    SaveConfigFile sourcemodConfig
    EnforceSourcemodConfig    
    SaveSimpleAdmins [GetConfigItem $sourcemodConfig admins]
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
    SaveMapListTxt "$serverFolder/csgo/maplist.txt"
    global runConfig
    SaveMapCycleTxt "$serverFolder/csgo/mapcycle.txt" [GetConfigValue $runConfig mapgroup]
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

    global DisableParmPrefix    
    set playersEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}players]
    set botsEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}bots]
    set fillWithBots [GetConfigItem $runConfig fillwithbots]
    set fillWithBotsEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}fillwithbots]
    if { $fillWithBotsEnableSetting == "1" } {
        if {$fillWithBots == "1"} {
            SetConfigItem $gameModeAllConfig bot_quota_mode fill
            if { $playersEnableSetting == "1" } {
                SetConfigItem $gameModeAllConfig bot_quota [GetConfigItem $runConfig players] 
            }
        } else {
            SetConfigItem $gameModeAllConfig bot_quota_mode normal
            if { $botsEnableSetting == "1" } {
                SetConfigItem $gameModeAllConfig bot_quota [GetConfigItem $runConfig bots]
            }
        }
    }
    
    set botSkillEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}botskill]
    if { $botSkillEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig bot_difficulty [dict get $botSkillMapper [GetConfigItem $runConfig botskill]]
    }
    
    set roundTimeEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}roundtime]
    if { $roundTimeEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_roundtime [GetConfigItem $runConfig roundtime]
    }
    
    set warmUpTimeEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}warmuptime]
    if { $warmUpTimeEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_warmuptime [GetConfigItem $runConfig warmuptime]
    }
    
    set buyTimeEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}buytime]
    if { $buyTimeEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_buytime [GetConfigItem $runConfig buytime]
    }
    
    set freezeTimeEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}freezetime]
    if { $freezeTimeEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_freezetime [GetConfigItem $runConfig freezetime]
    }
    
    set friendlyFireEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}friendlyfire]
    if { $friendlyFireEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_friendlyfire [GetConfigItem $runConfig friendlyfire]
    }
    
    set killCam [GetConfigItem $runConfig killcam]
    set killCamEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}killcam]
    if { $killCamEnableSetting == "1" } {
        if {$killCam == "1"} {
            SetConfigItem $gameModeAllConfig mp_forcecamera 0
        } else {
            SetConfigItem $gameModeAllConfig mp_forcecamera 1       
        }
    }

    set startmoneyEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}startmoney]
    if { $startmoneyEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_startmoney [GetConfigItem $runConfig startmoney]
    }

    set c4timerEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}c4timer]
    if { $c4timerEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_c4timer [GetConfigItem $runConfig c4timer]
    }
    set fraglimitEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}fraglimit]
    if { $fraglimitEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_fraglimit [GetConfigItem $runConfig fraglimit]
    }
    set maxroundsEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}maxrounds]
    if { $maxroundsEnableSetting == "1" } {
        set maxRounds [GetConfigItem $runConfig maxrounds]
        if { $maxRounds == "0" } {
            Trace "Detected maxrounds==0, resetting from old default value 0 to new default value 30 (or server will directly enter map vote)"
            set maxRounds 30
            SetConfigItem $runConfig maxrounds $maxRounds
        }
        SetConfigItem $gameModeAllConfig mp_maxrounds $maxRounds
    }
    set winlimitEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}winlimit]
    if { $winlimitEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig mp_winlimit [GetConfigItem $runConfig winlimit]
    }
    set enablebunnyhoppingEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}enablebunnyhopping]
    if { $enablebunnyhoppingEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_enablebunnyhopping [GetConfigItem $runConfig enablebunnyhopping]
    }   
    set autobunnyhoppingEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}autobunnyhopping]
    if { $autobunnyhoppingEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_autobunnyhopping [GetConfigItem $runConfig autobunnyhopping]
    }   
    set airaccelerateEnableSetting [GetConfigItem $runConfig ${DisableParmPrefix}airaccelerate]
    if { $airaccelerateEnableSetting == "1" } {
        SetConfigItem $gameModeAllConfig sv_airaccelerate [GetConfigItem $runConfig airaccelerate]
    }   
}


source [file join $starkit::topdir page_autoexec.tcl]

autoexec::InitializeDirs
autoexec::BuildVars
EnsureConfigFile autoexecConfig
LoadConfigFile autoexecConfig 
proc SaveConfigFileAutoexec {} {
    global autoexecConfig
    SaveConfigFile autoexecConfig
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
    LoadSplitConfigFile gameModeArmsraceConfig
    LoadSplitConfigFile gameModeClassicCasualConfig 
    LoadSplitConfigFile gameModeClassicCompetitiveConfig 
    LoadSplitConfigFile gameModeDemolitionConfig
    LoadSplitConfigFile gameModeDeathmatchConfig
    LoadSplitConfigFile gameModeTrainingConfig
    LoadSplitConfigFile gameModeCustomConfig
    LoadSplitConfigFile gameModeCooperativeConfig
}

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

variable gameModeArmsraceLayout             [CreateDefaultLayoutFromConfig $gameModeArmsraceConfig]
variable gameModeClassicCasualLayout        [CreateDefaultLayoutFromConfig $gameModeClassicCasualConfig]
variable gameModeClassicCompetitiveLayout   [CreateDefaultLayoutFromConfig $gameModeClassicCompetitiveConfig]
variable gameModeDemolitionLayout           [CreateDefaultLayoutFromConfig $gameModeDemolitionConfig]
variable gameModeDeathmatchLayout           [CreateDefaultLayoutFromConfig $gameModeDeathmatchConfig]
variable gameModeTrainingLayout             [CreateDefaultLayoutFromConfig $gameModeTrainingConfig]
variable gameModeCustomLayout               [CreateDefaultLayoutFromConfig $gameModeCustomConfig]
variable gameModeCooperativeLayout          [CreateDefaultLayoutFromConfig $gameModeCooperativeConfig]
variable gameModeAllLayout                  [CreateDefaultLayoutFromConfig $gameModeAllConfig]

proc AddNewCustomCvarGameModeAll {name default help} {
    global gameModeConfigs
    foreach {config} $gameModeConfigs {
        AddNewCustomCvar [dict get $config name] $name "$default" "$help"
    }
}

proc RemoveCustomCvarAll { name } {
    global gameModeConfigs
    foreach {config} $gameModeConfigs {
        RemoveCustomCvar [dict get $config name] $name
    }    
    RemoveCustomCvar gameModeAllConfig $name
}

proc SaveConfigFileGameModeAll {} {
    global gameModeAllConfig
    global gameModeConfigs
    SaveConfigFile gameModeAllConfig
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

proc GetCp {} {
    global cp
    return $cp
}
#pack [Separator .bottomSep] -side left -fill x -expand true
#pack [CreateStatus $top.status status currentDir hostName] -side left -fill x -expand true

set enableTab 1

CreateConfigPageTabFromLayout $cp.server $serverLayout $enableTab
set serverPage [CreateConfigPageFromLayout $cp.server $serverLayout]

CreateConfigPageTabFromLayout $cp.rconcli $rconCliLayout $enableTab
set rconCliPage [CreateConfigPageFromLayout $cp.rconcli $rconCliLayout]

CreateConfigPageTabFromLayout $cp.gotv $gotvLayout $enableTab
set gotvPage [CreateConfigPageFromLayout $cp.gotv $gotvLayout]

CreateConfigPageTabFromLayout $cp.steam $steamLayout $enableTab
set steamPage [CreateConfigPageFromLayout $cp.steam $steamLayout]

CreateConfigPageTabFromLayout $cp.sourcemod $sourcemodLayout $enableTab
set sourcemodPage [CreateConfigPageFromLayout $cp.sourcemod $sourcemodLayout]

CreateConfigPageTabFromLayout $cp.maps $mapsLayout $enableTab
set mapsPage [CreateConfigPageFromLayout $cp.maps $mapsLayout]

CreateConfigPageTabFromLayout $cp.mapGroups $mapGroupsLayout [expr $enableTab && $serverPresent]
set mapGroupsPage [CreateConfigPageFromLayout $cp.mapGroups $mapGroupsLayout]

CreateConfigPageTabFromLayout $cp.autoexec $autoexecLayout [expr $enableTab && $serverPresent]
set autoexecPage [CreateConfigPageFromLayout $cp.autoexec $autoexecLayout]

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

PerformOnChangeOnLayout $serverPage $serverLayout
PerformOnChangeOnLayout $gotvPage $gotvLayout
PerformOnChangeOnLayout $steamPage $steamLayout
PerformOnChangeOnLayout $sourcemodPage $sourcemodLayout
PerformOnChangeOnLayout $runPage $runLayout
PerformOnChangeOnLayout $applicationPage $applicationLayout

if {$serverPresent} {
    $cp select $runPage
} else {
    $cp select $serverPage
}
variable configPages $cp
pack .config -side top -fill both -expand true

proc RestartAt {time} {
    Trace "Server is being restarted at $time as requested..."
    set status [DetectServerRunning]
    if { $status == "running" } {
        Trace "Server is running, stopping it."
        StopServer
    }
    global serverConfig
    set updateServerOnRestart [GetConfigValue $serverConfig updateserveronrestart]
    if { $updateServerOnRestart == 1 } {
        Trace "Updating and starting server again, hold on, may take a while..."
    } else {
        Trace "Starting server again, hold on, may take a while..."        
    }

    global installFolder
    RunScriptAssync "$installFolder/bin/onrestart"
}

set lastTimeChecked [clock seconds]
proc CheckRestartAt { } {
    global serverConfig
    global lastTimeChecked
    set restartServerAt [GetConfigValue $serverConfig restartserverat]
    set now [clock seconds]
    foreach time $restartServerAt {
        set candidate [clock scan $time]
        if { ($now >= $candidate) && ($candidate > $lastTimeChecked) } {
            RestartAt $time
            break
        }
    }
    set lastTimeChecked $now
}

proc StartStuffOnStart {} {
    UpdateAndStartServerAssync
    global serverConfig installFolder
    set restartServerAtRestart 0
    if {[GetConfigValue $serverConfig restartserverat] != ""} {
        set restartServerAtRestart 1        
    }
    CreateAssyncUpdateAndStart "$installFolder/bin/onrestart" [GetConfigValue $serverConfig updateserveronrestart] $restartServerAtRestart
    if { $restartServerAtRestart != 0 } {
        Every 30000 CheckRestartAt
    }        
}

if {$serverPresent} {
    SetTitle "$name $version"
} else {
    SetTitle "$name $version -- install server by clicking on \"Install Server\" button! Then restart csgosl!"    
}

if {$serverPresent} {
    Every 2000 PeriodicWindowUpdate
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

proc UpgradeCheck {} {
    global applicationConfig
    global version
    global installDir
    if { [file exists updatefolder] } {
        file delete -force updatefolder
    }
    if { [GetConfigItem $applicationConfig updatecheck] } {
        set latestRelease [GetLatestRelease]
        if { $latestRelease != "" } {
            if { $latestRelease != $version } {
                set done 0
                while { ! $done } {
                    set done 1
                    set noBitMap ""
                    set reply [tk_dialog .w "csgosl update $latestRelease is available!" \
                    "A new csgosl version $latestRelease is available!\n\nDo you want to update your version $version to $latestRelease?\n\nYou can disable this check in the Application Page.\n\nPlease be patient during upgrade, it takes a while to download the update.\n\ncsgosl will restart once the download is finished." \
                    $noBitMap 0 "First let me see what's in $latestRelease" "Install $latestRelease now" "Take me to the download page, want to update myself" "Not now"]
                    if { $reply == 0 } {
                        Browser "https://github.com/lenosisnickerboa/csgosl/releases"
                        set done 0
                    } elseif { $reply == 1 } {
                        InstallRelease $latestRelease
                    } elseif { $reply == 2 } {
                        Browser "https://github.com/lenosisnickerboa/csgosl/releases"
                        Browser "https://github.com/lenosisnickerboa/csgosl/wiki/Upgrade%20a%20server"                    
                    }                    
                }
            } else {
                Trace "Running latest release."                    
            }
        } else {
            Trace "Failed to get latest release!"        
        }
    }
}

if {$serverPresent} {
    after 5000 { UpgradeCheck ; StartStuffOnStart }
}

if { $serverPresent && $needsUpgrade } {
    UpdateMods
    if { [file exists "$NeedsUpgradeFileName"] } {
        file delete -force "$NeedsUpgradeFileName"
    }
}

#bind . <KeyPress> {puts "You pressed the key named: %K "}
#bind . <ButtonPress> {puts "You pressed button: %b at %x %y"}

