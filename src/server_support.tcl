#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir sed.tcl]

proc StartServer { {returnCommandOnly 0} } {
    global configPages
    global runPage
    SaveAll skipStandalone
    global serverConfig
    global steamConfig
    global installFolder
    global serverFolder
    set serverName [GetConfigValue $serverConfig name]
    if { "$serverName" == "" } {
        FlashConfigItem $serverPage name
        return 
    }
    
    global sourcemodConfig
    set banProtection [GetConfigValue $sourcemodConfig banprotection]
    set steamAccountOption ""
    set apiAuthKeyOption ""
    set serverLanOption "+sv_lan 1"
    if { $banProtection == 0 } {
        Trace "====================================================================="
        Trace "Sourcemod banprotection is disabled, enforcing GSLT-less lanonly mode"
        Trace "====================================================================="
    } else {
        set serverLan [GetConfigValue $serverConfig lanonly]
        set serverLanOption "+sv_lan $serverLan"
        if { $serverLan == 0 } {
            set steamAccount [GetConfigValue $steamConfig gameserverlogintoken]
            if {$steamAccount != ""} {
                set steamAccountOption "+sv_setsteamaccount $steamAccount"
            }
        }
        set apiAuthKey [GetConfigValue $steamConfig apiauthkey]
        set apiAuthKeyOption ""
        if {$apiAuthKey != ""} {
            set apiAuthKeyOption "-authkey $apiAuthKey"
        }            
    }
    
    set serverPort [GetConfigValue $serverConfig port]
    set serverPortOption "-port 27015"
    if { "$serverPort" != "" } {
        set serverPortOption "-port $serverPort"
    }
        
    global runConfig
    set gameModeTypeString [GetConfigValue $runConfig gamemodetype]
    global gameModeMapper
    set gameModeType [dict get $gameModeMapper "$gameModeTypeString"]
    set gameType [dict get $gameModeType type]
    set gameMode [dict get $gameModeType mode]
    
    set players [GetConfigValue $runConfig players]

    set tickRate [GetConfigValue $serverConfig tickrate]

    set mapGroup [GetConfigValue $runConfig mapgroup]
    set startMap [GetConfigValue $runConfig startmap]

    set mapGroupOption "+mapgroup $mapGroup"
    set mapOption "+map $startMap"
    
    if { [string is wideinteger $mapGroup] } {
        set mapGroupOption "+host_workshop_collection $mapGroup"
        if { [string is wideinteger $startMap]} {
            set mapOption "+host_workshop_startmap $startMap"            
        } else {
            set mapOption ""            
        }
    } elseif { [string is wideinteger $startMap]} {
        set mapGroupOption ""
        set mapOption "+host_workshop_map $startMap"            
    }

    set passwordOption ""
    set password [GetConfigValue $serverConfig password]
    if { $password != "" } {
        set passwordOption "+sv_password $password"
    }

    global currentOs
    
    set bindIp [GetConfigValue $serverConfig bindip]
    set rconEnable [GetConfigValue $serverConfig rcon]
    set rconCommand ""
    if { $rconEnable == "1" } {
        set rconCommand "-usercon -condebug"
        if { $currentOs == "linux" && $bindIp == "" } {
            #setting -ip 0.0.0.0 is a workaround to get rcon working on linux servers
            set rconCommand "$rconCommand -ip 0.0.0.0"
        }
    }

    set consoleCommand ""
    if { $currentOs == "windows" } {
        set consoleCommand "-console"        
    }

    set options [GetConfigValue $runConfig options]

    set control "start"
    if { [GetConfigValue $serverConfig autorestart] == "1" } {
        set control "autorestart"
    }
    set ipOption ""
    if { $bindIp != "" } {
        set ipOption "-ip $bindIp"        
    }
    
    global serverControlScript
    global srcdsName
    if { $currentOs == "windows" } {
        if {$returnCommandOnly == 1} {
            return "\"[file nativename $serverFolder/$srcdsName]\" \
                -game csgo $consoleCommand $rconCommand \
                +game_type $gameType +game_mode $gameMode \
                $mapGroupOption \
                $mapOption \
                $steamAccountOption $apiAuthKeyOption \
                -maxplayers_override $players \
                -tickrate $tickRate \
                $passwordOption \
                $ipOption \
                +hostname \"$serverName\" $serverPortOption $serverLanOption \
                $options"
        }
        RunAssync "$serverControlScript-start.bat \"$serverFolder/$srcdsName\" \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccountOption $apiAuthKeyOption \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             $ipOption \
             +hostname \"$serverName\" $serverPortOption $serverLanOption \
             $options"
    } else {
        if {$returnCommandOnly == 1} {
            return "\"$serverFolder/$srcdsName\" \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccountOption $apiAuthKeyOption \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             $ipOption \
             +hostname \\\"$serverName\\\" $serverPortOption $serverLanOption \
             $options"
        }
        chan configure stdout -buffering none
        chan configure stderr -buffering none
        Trace "Executing $serverControlScript $control \
            $serverFolder/$srcdsName \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccountOption $apiAuthKeyOption \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             $ipOption \
             +hostname \"$serverName\" $serverPortOption $serverLanOption \
             $options"
        
        if { [IsDryRun] } {
            Trace "*** THIS IS A DRY RUN! ***"
            return 0
        }
        
        exec >@stdout 2>@stderr "$serverControlScript" $control \
            "$serverFolder/$srcdsName" \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccountOption $apiAuthKeyOption \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             $ipOption \
             +hostname \"$serverName\" $serverPortOption $serverLanOption \
             $options
    }
}

#Workaround for hopeless windows bat files...
proc StopWindowsServer {} {
    global serverControlScript
    set line [exec "$serverControlScript-get-pid.bat"]
    if { [llength $line] == 0 } {
        return
    }
    set pid [lindex $line end]
    exec "$serverControlScript-stop.bat" $pid
}

proc StopServer { {returnCommandOnly 0} } {
    global currentOs
    if {$returnCommandOnly == 1} {
        if { $currentOs == "windows" } {
            return "@echo Not supported on windows, use Task Manager to terminate your server\n@pause"
        } else {
            global serverControlScript
            return "$serverControlScript stop"
        }
    }
    if { $currentOs == "windows" } {
        StopWindowsServer
    } else {
        global serverControlScript
        chan configure stdout -buffering none
        chan configure stderr -buffering none
        exec >@stdout 2>@stderr "$serverControlScript" stop
    }
}

proc UpdateServer { {returnCommandOnly 0} } {
    global steamcmdFolder
    set steamCmdExe "steamcmd.sh"
    global currentOs
    global binFolder
    global installFolder
    set filename "$installFolder/$binFolder/steamcmd.txt"
    
    if {$currentOs == "windows"} {
        set steamCmdExe "steamcmd.exe"        
    }
    if {$returnCommandOnly == 1} {
        if {$currentOs == "windows"} {
            return "\"[file nativename $steamcmdFolder/$steamCmdExe]\" +runscript \"[file nativename $filename]\""
        } else {
            return "\"$steamcmdFolder/$steamCmdExe\" +runscript \"$filename\""
        }
    }
    
    set status [DetectServerRunning]
    if { $status == "running" } {
        Trace "Server is running! Stop server first and retry update!"
        return 1
    }    
    
    global consolePage
    global currentOs
    if {$currentOs == "windows"} {
        SetConfigPage $consolePage        
    }
    global serverFolder
    SaveAll skipStandalone
    if { ! [file isdirectory $serverFolder] } {
        Trace "Creating a new server directory $serverFolder \[Server->directory is left empty\]"
        file mkdir "$serverFolder"
    }
    if { ! [file isdirectory $serverFolder/csgo] } {
        Trace "Creating a new server directory $serverFolder/csgo"
        file mkdir "$serverFolder/csgo"
    }
    global steamPage
    global steamConfig
    if { ! [file isdirectory $steamcmdFolder] } {
        Trace "Creating a new steamcmd directory $steamcmdFolder \[Steamcmd directory is empty\]"
        file mkdir "$steamcmdFolder"
    }
    if { ([file exists "$steamcmdFolder/$steamCmdExe"] != 1 ) } {
        Trace "Installing $steamCmdExe in $steamcmdFolder..."
        set steamCmdArchive "steamcmd_linux.tar.gz"
        if {$currentOs == "windows"} {
            set steamCmdArchive "steamcmd.zip"
        }
        if { [file exists "$steamcmdFolder/$steamCmdArchive"] != 1 } {
            set steamcmdUrl [GetConfigValue $steamConfig steamcmdurl]
            if {"$steamcmdUrl" == ""} {
                Trace "steamcmdUrl is empty, can't download $steamCmdArchive"
                FlashConfigItem $steamPage steamcmdurl
                return             
            }
            Trace "Downloading $steamCmdArchive..."
            Wget "$steamcmdUrl" "$steamcmdFolder/$steamCmdArchive"
        }
    }
    if { [file exists "$steamcmdFolder/$steamCmdExe"] != 1 } {
        Trace "Unpacking $steamcmdFolder/$steamCmdArchive"
        if {$currentOs == "windows"} {
            Unzip "$steamcmdFolder/$steamCmdArchive" "$steamcmdFolder"
        } else {
            Untar "$steamcmdFolder/$steamCmdArchive" "$steamcmdFolder"
        }
    }
    if { [file exists "$steamcmdFolder/$steamCmdExe"] != 1 } {
       Trace "No $steamCmdExe found in $steamcmdFolder, giving up, can't install or update."
       #TODO: Fix error dialog
       Help "Failed to get a working steamcmd!" "Failed to get a working steamcmd!"
       return 
    }
    
    set validateInstall [GetConfigValue $steamConfig validateinstall]
    set fileId [open "$filename" "w"]
    puts $fileId "login anonymous"
    puts $fileId "force_install_dir \"$serverFolder\""
    if { $validateInstall == "1"} {
        puts $fileId "app_update 740 validate"        
    } else {
        puts $fileId "app_update 740"
    }
    puts $fileId "exit"
    close $fileId

    Trace "--------------------------------------------------------------------------------"
    Trace "Updating your server at $serverFolder \[$steamcmdFolder/steamcmd +runscript $filename\]"
    Trace "This can potentially take several minutes depending on update size and your connection."
    Trace "Please be patient and wait for the console window to close until moving on."
    Trace "If you don't see the following message at the end please restart the update and"
    Trace "the update will resume from where it failed."
    Trace "Message to look out for: Success! App '740' fully installed."
    Trace "--------------------------------------------------------------------------------"
    if {$currentOs == "windows"} {
        RunAssync "\"$steamcmdFolder/$steamCmdExe\" +runscript \"$filename\""
    } else {
        Trace "$steamcmdFolder/$steamCmdExe +runscript $filename"
        exec >@stdout 2>@stderr "$steamcmdFolder/$steamCmdExe" +runscript "$filename"
    }

    UpdateMods
    
    Trace "----------------"
    Trace "UPDATE FINISHED!"
    Trace "----------------"
}

proc DetectServerInstalled {sd} {
    global srcdsName
    if { [file exists "$sd"] && [file isdirectory "$sd"] && [file executable "$sd/$srcdsName"] && [file isdirectory "$sd/csgo"]} {
        return true
    }
    return false
}

proc DetectServerRunning {} {
    global serverControlScript
    global currentOs
    global serverExeFullName
    if { $currentOs == "windows" } {
        exec "$serverControlScript-status.bat"
    } else {
        exec "$serverControlScript" status
    }
}

proc MakeScriptFileName {filename} {
    global currentOs
    set f "$filename.sh"
    if {$currentOs == "windows"} {
        set f "$filename.bat"
    }
    return [file nativename $f]
}

proc RunScriptAssync {filename} {
    exec [MakeScriptFileName $filename] &
}

proc DoCreateStandalone {filename} {
    global serverConfig
    set standaloneScript [GetConfigValue $serverConfig standalonescript]
    set standaloneUpdate [GetConfigValue $serverConfig standaloneupdate]
    set standaloneStart [GetConfigValue $serverConfig standalonestart]
    set fileName [MakeScriptFileName "$filename-start"]
    if { $standaloneScript == 0 } {
        file delete -force "$fileName"
        file delete -force [MakeScriptFileName "$filename-stop"]
        return 0
    }
    Trace "Creating standalone script $fileName..."
    global currentOs
    set fileId [open $fileName "w"]
    StoreHeaderInScript $fileId
    if {$standaloneUpdate == 1} {
        if {$currentOs == "windows"} {
            puts $fileId "start /wait \"Updater Launcher window\" [UpdateServer 1]"
        } else {
            puts $fileId "[UpdateServer 1]"
        }
    }
    if {$standaloneStart == 1} {
        if {$currentOs == "windows"} {
            puts $fileId "start \"Server Launcher window\" [StartServer 1]"
        } else {
            puts $fileId "[StartServer 1]"
        }
    }
    close $fileId
    
    if { $currentOs == "windows" } {
        set x 1 
    } else {
        file attributes $fileName -permissions "+x"
    }

#No support for closing down server on windows yet, just skip it
    if { $currentOs == "windows" } {
        return 0
    }
    
    set fileName [MakeScriptFileName "$filename-stop"]
    Trace "Creating standalone script $fileName..."
    set fileId [open $fileName "w"]
    StoreHeaderInScript $fileId
    if {$standaloneStart == 1} {
        puts $fileId "[StopServer 1]"
    }
    close $fileId
    
    if { $currentOs == "windows" } {
        set x 1
    } else {
        file attributes $fileName -permissions "+x"
    }
}

proc DoCreateAssyncUpdateAndStart {fileName includeUpdate includeStart} {
    if { ($includeUpdate == 0) && ($includeStart == 0) } {
        file delete -force $fileName
        return 0
    }
    global currentOs
    set fileId [open $fileName "w"]
    StoreHeaderInScript $fileId
    if {$includeUpdate == 1} {
        if {$currentOs == "windows"} {
            puts $fileId "start /wait \"Updater Launcher window\" [UpdateServer 1]"
        } else {
            puts $fileId "[UpdateServer 1]"
        }
    }
    if {$includeStart == 1} {
        if {$currentOs == "windows"} {
            puts $fileId "start \"Server Launcher window\" [StartServer 1]"
        } else {
            puts $fileId "[StartServer 1]"
        }
    }
    close $fileId
    
    if { $currentOs == "windows" } {
        set x 1
    } else {
        file attributes $fileName -permissions "+x"
    }
}

proc CreateStandalone {} {
    global installFolder
    set filename "$installFolder/standalone-server"
    if {[catch {DoCreateStandalone $filename} errMsg]} {
        Trace "Failed creating standalone scripts $filename ($errMsg)"
    }    
}

proc CreateAssyncUpdateAndStart {filename includeUpdate includeStart} {
    set fileName [MakeScriptFileName $filename]
    Trace "Creating assync update and start script $fileName"
    if {[catch {DoCreateAssyncUpdateAndStart $fileName $includeUpdate $includeStart} errMsg]} {
        Trace "Failed creating assync script $fileName ($errMsg)"
    }        
}

proc UpdateAndStartServerAssync {} {
    global serverConfig
    global currentOs
    global installFolder

    set updateServerOnStart [GetConfigValue $serverConfig updateserveronstart]
    set startServerOnStart [GetConfigValue $serverConfig startserveronstart]

    CreateAssyncUpdateAndStart "$installFolder/bin/onstart" $updateServerOnStart $startServerOnStart    

    if { ($updateServerOnStart == 0) && ($startServerOnStart == 0) } {
        return 0
    }
        
    if { $updateServerOnStart == 1 } {
        set status [DetectServerRunning]
        if { $status == "running" } {
            Trace "Server is running, stopping it to be able to update."
            StopServer
            while {[DetectServerRunning] == "running"} {
                Trace "Waiting for server to close down"
                after 1000
            }
        }
        Trace "Updating server..."
    }
    if { $startServerOnStart == "1" } {
        set status [DetectServerRunning]
        if { $status == "running" } {
            Trace "Server is already running, leaving it running."
            return 0
        } else {
            Trace "Starting server..."
        }
    }
    
    RunScriptAssync "$installFolder/bin/onstart"
}

proc IsSourcemodEnabled {} {
    global serverConfig
    set lanOnly [GetConfigValue $serverConfig lanonly]
    global sourcemodConfig
    set sourcemodEnabled [GetConfigValue $sourcemodConfig enable]
    set sourcemodEnabledLanOnly [GetConfigValue $sourcemodConfig lanonly]
    if { $sourcemodEnabled && $lanOnly == 0 && $sourcemodEnabledLanOnly == 1 } {
#        Trace "Sourcemod is configured for lanonly mode, not running lanonly now, disabling sourcemod."
        set sourcemodEnabled 0
    }
    return $sourcemodEnabled
}

proc SetSourcemodInstallStatus {sourcemodEnabled} {
    global modsFolder
    if { ! $sourcemodEnabled } {
        Trace "Sourcemod functionality is disabled."
        if { [file exists "$modsFolder/sourcemod"] } {
            file rename -force "$modsFolder/sourcemod" "$modsFolder/sourcemod.DISABLED"
        }
        if { [file exists "$modsFolder/metamod"] } {
            file rename -force "$modsFolder/metamod" "$modsFolder/metamod.DISABLED"
        }
    } else {
        Trace "Sourcemod functionality is enabled."
        if { [file exists "$modsFolder/sourcemod.DISABLED"] } {
            file rename -force "$modsFolder/sourcemod.DISABLED" "$modsFolder/sourcemod"
        }
        if { [file exists "$modsFolder/metamod.DISABLED"] } {
            file rename -force "$modsFolder/metamod.DISABLED" "$modsFolder/metamod"
        }        
    }
}

#Fix for pre 1.1 version installing Linux Metamod binaries on Windows
proc UpdateModsFixForMetamodSourcemodInstallBug {} {
    global currentOs
    if { $currentOs != "windows" } {
        return 0
    }
    global serverFolder
    set addonsFolder "$serverFolder/csgo/addons"
    if { [file exists "$addonsFolder/metamod/bin/server.so"] } {
        Trace "Applying metamod install bug fix #1"
        file delete -force "$addonsFolder/metamod/bin"
    }
    if { [file exists "$addonsFolder/sourcemod/bin/sourcemod.logic.so"] } {
        Trace "Applying sourcemod install bug fix #1"
        file delete -force "$addonsFolder/sourcemod/bin"
    }
    if { [file exists "$addonsFolder/sourcemod/extensions/bintools.ext.so"] } {
        Trace "Applying sourcemod install bug fix #2"
        file delete -force "$addonsFolder/sourcemod/extensions"
    }
}

proc GetFirstLineOfFile { name } {
    set fp [open "$name" r]
    gets $fp line
    close $fp
    return $line
}

variable PreserveMarker "CSGOSLDONOTTOUCH"

proc PreserveConfig { name } {
    global PreserveMarker
    set line [GetFirstLineOfFile $name]
    string match "*$PreserveMarker*" "$line"
}

proc StoreUsersConfigs { dir } {
    global PreserveMarker
    set configs [glob -nocomplain -tails -type f -path "$dir/" *.cfg]
    foreach config $configs {
        if { [PreserveConfig "$dir/$config"] } {
            file copy -force "$dir/$config" "$dir/$config.$PreserveMarker"
        }
    }
}

proc RestoreUsersConfigs { dir } {    
    global PreserveMarker
    set configs [glob -nocomplain -tails -type f -path "$dir/" *.cfg]
    foreach config $configs {
        if { [file exists "$dir/$config.$PreserveMarker" ] } {
            file rename -force "$dir/$config.$PreserveMarker" "$dir/$config"
        }
    }
}

proc UpdateMods {} {
    global installFolder
    global serverFolder
    #Make sure sourcemod is enabled to be able to update it
    SetSourcemodInstallStatus true

    UpdateModsFixForMetamodSourcemodInstallBug   
    
    StoreUsersConfigs "$serverFolder/csgo/addons/sourcemod/configs"
    StoreUsersConfigs "$serverFolder/csgo/addons/sourcemod/configs/multi1v1"
    StoreUsersConfigs "$serverFolder/csgo/cfg/sourcemod"
    StoreUsersConfigs "$serverFolder/csgo/cfg/sourcemod/multi1v1"

    set modsArchive "$installFolder/mods/mods.zip"
    Trace "Looking for mods $modsArchive..."
    if { [file exists "$modsArchive"] == 1 } {
        Trace "Installing mods..."
        Unzip "$modsArchive" "$serverFolder/csgo/"
    }
    
    global sourcemodConfig
    if { [GetConfigValue $sourcemodConfig banprotection] == 0 } {
        set modsArchive "$installFolder/mods/mods-risky.zip"
        Trace "Looking for risky mods $modsArchive..."
        if { [file exists "$modsArchive"] == 1 } {
            Trace "Installing risky mods..."
            Unzip "$modsArchive" "$serverFolder/csgo/"
        }
    }

    RestoreUsersConfigs "$serverFolder/csgo/addons/sourcemod/configs"
    RestoreUsersConfigs "$serverFolder/csgo/addons/sourcemod/configs/multi1v1"
    RestoreUsersConfigs "$serverFolder/csgo/cfg/sourcemod"
    RestoreUsersConfigs "$serverFolder/csgo/cfg/sourcemod/multi1v1"
    
    SaveAll skipStandalone
    #Restore sourcemod conf after update 
    EnforceSourcemodConfig    
}

proc SaveSimpleAdmins {admins} {
    global modsFolder
    set configFolder "$modsFolder/sourcemod/configs"
    if { ! [file exists $configFolder] } {
        set configFolder "$modsFolder/sourcemod.DISABLED/configs"
    }
    if { [file exists $configFolder] } {
        SaveSimpleAdminsFile "$configFolder/admins_simple.ini" $admins
    }
}

proc IsSourcemodPluginEnabled {pluginEnabled pluginLanOnly} {
    global serverConfig
    set lanOnly [GetConfigValue $serverConfig lanonly]
    if { $pluginEnabled && $lanOnly == 0 && $pluginLanOnly == 1 } {
        return 0
    } else {
        return $pluginEnabled
    }
}

proc SetSourcemodPluginsInstallStatus {} {
    global sourcemodConfig
    global sourcemodPlugins
    foreach {plugin pluginParms} $sourcemodPlugins {
        set pluginRisky [lindex $pluginParms 0]
        set pluginEnabledName [lindex $pluginParms 1]
        set pluginEnabled [GetConfigValue $sourcemodConfig $pluginEnabledName]
        set pluginLanOnlyName [lindex $pluginParms 2]
        set pluginLanOnly [GetConfigValue $sourcemodConfig $pluginLanOnlyName]
        set pluginSmxName [lindex $pluginParms 3]
        set pluginEnabled [IsSourcemodPluginEnabled $pluginEnabled $pluginLanOnlyName]
        EnforceSourcemodPluginConfig $pluginSmxName $pluginEnabled
    }
}

proc SetFollowCSGOServerGuidelines {} {
    global modsFolder
    global sourcemodConfig
    set FollowCSGOServerGuidelines "yes"
    set sourcemodBanProtectionEnabled [GetConfigValue $sourcemodConfig banprotection]
    if { $sourcemodBanProtectionEnabled == 0 } {
        set FollowCSGOServerGuidelines "no"        
    }
    set configFolder "$modsFolder/sourcemod/configs"
    if { ! [file exists $configFolder] } {
        set configFolder "$modsFolder/sourcemod.DISABLED/configs"
    }
    if { [file exists $configFolder] } {
        sedf "s/.*FollowCSGOServerGuidelines.*/\"FollowCSGOServerGuidelines\" \"$FollowCSGOServerGuidelines\"/g" "$configFolder/core.cfg"
    }
}

proc EnforceSourcemodConfig {} {
    set status [DetectServerRunning]
    if { $status == "running" } {
        Trace "Server is running! Stop server first and retry!"
        return 1
    }
    
    set sourcemodEnabled [IsSourcemodEnabled]
    SetSourcemodInstallStatus $sourcemodEnabled
    
    if { ! $sourcemodEnabled } {
        return 0
    }
    
    SetSourcemodPluginsInstallStatus
    
    SetFollowCSGOServerGuidelines
}

proc EnforceSourcemodPluginConfig {pluginFileName pluginEnabled} {
    global modsFolder
    set sourcemodPluginFolder "$modsFolder/sourcemod/plugins"
    if { $pluginEnabled } {
        Trace "Plugin $pluginFileName is enabled"
        if { [file exists "$sourcemodPluginFolder/disabled/$pluginFileName"] } {
            #Could be an updated plugin which is always installed into the disabled folder by default
            if { [file exists "$sourcemodPluginFolder/$pluginFileName"] } {
                file delete -force "$sourcemodPluginFolder/$pluginFileName"
            }
            file rename -force "$sourcemodPluginFolder/disabled/$pluginFileName" "$sourcemodPluginFolder/$pluginFileName"
        }
    } else {
        Trace "Plugin $pluginFileName is disabled"
        if { [file exists "$sourcemodPluginFolder/$pluginFileName"] } {
            #If target file exists in disabled folder keep it, and just remove the plugin from the active folder
            #Might be an updated plugin...
            if { [file exists "$sourcemodPluginFolder/disabled/$pluginFileName"] } {
                file delete -force "$sourcemodPluginFolder/$pluginFileName"
            } else {
                file rename -force "$sourcemodPluginFolder/$pluginFileName" "$sourcemodPluginFolder/disabled/$pluginFileName"                
            }
        }
    }
}
