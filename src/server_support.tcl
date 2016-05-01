#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

proc StartServer {} {
    global configPages
    global runPage
    $configPages select $runPage
    SaveAll
    global serverConfig
    global steamConfig
    global installFolder
    global serverFolder
    set serverName [GetConfigValue $serverConfig name]
    if { "$serverName" == "" } {
        FlashConfigItem $serverPage name
        return 
    }
    set serverLanOption [GetConfigValue $serverConfig lanonly]
    set serverLan "+sv_lan 0"
    if { "$serverLanOption" == "1" } {
        set serverLan "+sv_lan 1"
    }
    set serverPortOption [GetConfigValue $serverConfig port]
    set serverPort "-port 27015"
    if { "$serverPortOption" != "" } {
        set serverPort "-port $serverPortOption"
    }
    set serverPort [GetConfigValue $serverConfig port]
    global executorCommand
    set steamAccount [GetConfigValue $steamConfig gameserverlogintoken]
    if {$steamAccount != ""} {
        set steamAccount "+sv_setsteamaccount $steamAccount"
    }
    set apiAuthKey [GetConfigValue $steamConfig apiauthkey]
    if {$apiAuthKey != ""} {
        set apiAuthKey "-authkey $apiAuthKey"
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
    
    set rconEnable [GetConfigValue $serverConfig rcon]
    set rconCommand ""
    if { $rconEnable == "1" } {
        #setting -ip 0.0.0.0 is a workaround on linux
        set rconCommand "-usercon -condebug -ip 0.0.0.0"
    }

    global currentOs
    set consoleCommand ""
    if { $currentOs == "windows" } {
        set consoleCommand "-console"        
    }

    set options [GetConfigValue $runConfig options]

    set control "start"
    if { [GetConfigValue $serverConfig autorestart] == "1" } {
        set control "autorestart"
    }
    set srcdsName "srcds_run"
    if { $currentOs == "windows" } {
        set srcdsName "srcds"
    }

    global serverControlScript    
    if { $currentOs == "windows" } {
        RunAssync "$serverControlScript-start.bat \"$serverFolder/$srcdsName\" \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccount $apiAuthKey \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             +hostname \"$serverName\" $serverPort $serverLan \
             $options"
    } else {
        chan configure stdout -buffering none
        chan configure stderr -buffering none
        Trace "Executing $serverControlScript $control \
            $serverFolder/$srcdsName \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccount $apiAuthKey \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             +hostname \"$serverName\" $serverPort $serverLan \
             $options"
        exec >@stdout 2>@stderr "$serverControlScript" $control \
            $serverFolder/$srcdsName \
             -game csgo $consoleCommand $rconCommand \
             +game_type $gameType +game_mode $gameMode \
             $mapGroupOption \
             $mapOption \
             $steamAccount $apiAuthKey \
             -maxplayers_override $players \
             -tickrate $tickRate \
             $passwordOption \
             +hostname \"$serverName\" $serverPort $serverLan \
             $options
    }
}

proc StopServer {} {
    global serverControlScript
    global currentOs
    if { $currentOs == "windows" } {
#        RunAssync "$serverControlScript-stop.bat"
        exec "$serverControlScript-stop.bat"
    } else {
        chan configure stdout -buffering none
        chan configure stderr -buffering none
        exec >@stdout 2>@stderr "$serverControlScript" stop
    }
}

proc UpdateServer {} {
    global consolePage
    global currentOs
    if {$currentOs == "windows"} {
        SetConfigPage $consolePage        
    }
    global serverFolder
    SaveAll
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
    global steamcmdFolder
    if { ! [file isdirectory $steamcmdFolder] } {
        Trace "Creating a new steamcmd directory $steamcmdFolder \[Steamcmd directory is empty\]"
        file mkdir "$steamcmdFolder"
    }
    set steamCmdExe "steamcmd.sh"
    global currentOs
    if {$currentOs == "windows"} {
        set steamCmdExe "steamcmd.exe"        
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
    global binFolder
    global installFolder
    set filename "$installFolder/$binFolder/steamcmd.txt"
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

    set modsArchive "$installFolder/mods/mods.zip"
    Trace "Looking for mods $modsArchive..."
    if { [file exists "$modsArchive"] == 1 } {
        Trace "Installing mods..."
        Unzip "$modsArchive" "$serverFolder/csgo/"
    }
    Trace "----------------"
    Trace "UPDATE FINISHED!"
    Trace "----------------"
}

proc DetectServerInstalled {sd} {
    set srcdsName "srcds_run"
    global currentOs
    if { $currentOs == "windows" } {
        set srcdsName "srcds.exe"
    }
    if { [file exists "$sd"] && [file isdirectory "$sd"] && [file executable "$sd/$srcdsName"] && [file isdirectory "$sd/csgo"]} {
        return true
    }
    return false
}

proc DetectServerRunning {} {
    global serverControlScript
    global currentOs
    if { $currentOs == "windows" } {
        exec "$serverControlScript-status.bat"
    } else {
        exec "$serverControlScript" status
    }
}
