#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir restart.tcl]

package require Tk

proc ParseConfigLine {line} {
    set items [regexp -all -inline {\/\/.*|\".*"|\S+} $line]
    if { [llength $items] < 2 } {
        set items [list]
    }
    return $items
}

proc CreateConfigFile {name meta} {
    set fileId [open $name "w"]
    dict for {key metaItem} $meta {
        set value [dict get $metaItem default]
        puts $fileId "$key \"$value\""
    }
    close $fileId
}

proc EnsureConfigFile {configName} {
    global $configName
    set config [set $configName]
    set name [dict get $config fileName]

    if { ! [file exists "$name"] } {
        CreateConfigFile "$name" [dict get $config meta]
    }
}

proc EnsureEmptyFile {filename} {
    if { ! [file exists "$filename"] } {
        close [open $filename "w"]
    }
}

proc LoadConfigFileSub {configName} {
    global $configName
    set config [set $configName]
    set name [dict get $config fileName]
    set values [dict get $config values]
    set meta [dict get $config meta]
    
    set fp [open "$name" r]
    set fileData [read $fp]
    close $fp
    set data [split $fileData "\n"]
    foreach line $data {
        set tokens [ParseConfigLine $line]
        set key [string trim [lindex $tokens 0] "\""]
        set value [string trim [lindex $tokens 1] "\""]
        if { [string length $key] > 0 } {
            if { [dict exists $meta $key] } {
                set metaItem [dict get $meta $key]
                set type [dict get $metaItem type]
                if {$type == "list"} {
                    set value [split "$value"]
                } 
                set values [dict set values "$key" $value]
            } 
        }
    }
    set $configName [dict set config values $values]
}

proc LoadConfigFile {configName} {
    return [LoadConfigFileSub $configName]
}

proc LoadSplitConfigFile {configName} {
    global $configName
    set config [set $configName]
    set nameDefaults [dict get $config fileNameDefaults]
    set values [dict get $config values]
    set meta [dict get $config meta]
    
    set fp [open "$nameDefaults" r]
    set fileData [read $fp]
    close $fp
    set data [split $fileData "\n"]
    foreach line $data {
        set tokens [ParseConfigLine $line]
        set key [string trim [lindex $tokens 0] "\""]
        set value [string trim [lindex $tokens 1] "\""]
        if { [string length $key] > 0 } {
            set values [dict set values $key "$value"]
            set help "?"
            if {[dict exists $meta $key]} {
                set thisMeta [dict get $meta $key]
                set help [dict get $thisMeta help]                
            }
            set meta [dict set meta "$key" [dict create type "string" default "$value" help $help]]
        }
    }
    set $configName [dict set config meta $meta]
    set $configName [dict set config values $values]
    LoadConfigFileSub $configName
}

proc LoadMapGroupsMapper {filename} {
    global mapGroupsMapper
    set fp [open "$filename" r]
    set fileData [read $fp]
    close $fp
    set data [split $fileData "\n"]
    foreach line $data {
        set tokens [ParseConfigLine $line]
        set mapGroup [string trim [lindex $tokens 0] "\""]
        set mapGroup [lindex [split $mapGroup "-"] 1]
        set maps [string trim [lindex $tokens 1] "\""]
        if { [string length $mapGroup] > 0 } {
            set mapGroupsMapper [dict set mapGroupsMapper $mapGroup [split "$maps"]]
        }
    }
}

proc SaveMapGroupsMapper {filename} {
    global mapGroupsMapper
    set fileId [open "$filename" "w"]
    dict for {mapGroup maps} $mapGroupsMapper {
        puts $fileId "mg-$mapGroup \"$maps\""
    }
    close $fileId        
}

proc SaveConfigFile {configName} {
    global $configName
    set config [set $configName]
    set fileName [dict get $config fileName]
    set prefix [dict get $config prefix]
    set values [dict get $config values]
    set meta [dict get $config meta]

    set fileId [open $fileName "w"]
    dict for {key value} $values {
        set valueName [GetGlobalConfigVariableName $prefix $key]
        global $valueName
        set value [set $valueName]
        set values [dict set values $key "$value"]
        set metaItem [dict get $meta $key]
        set type [dict get $metaItem type]
        if {$type == "line"} {
            puts $fileId $value            
        } else {
            puts $fileId "$key \"$value\""            
        }
    }
    set $configName [dict set config values $values]
    close $fileId
}

proc SaveSplitConfigFile {configName} {
    global $configName
    set config [set $configName]
    set fileName [dict get $config fileName]
    set nameDefaults [dict get $config fileNameDefaults]

    set prefix [dict get $config prefix]
    set values [dict get $config values]
    set meta [dict get $config meta]

    set fileId [open $fileName "w"]
    dict for {key value} $values {
        set valueName [GetGlobalConfigVariableName $prefix $key]
        global $valueName
        set value [set $valueName]
        set values [dict set values $key "$value"]
        set metaItem [dict get $meta $key]
        set default [dict get $metaItem default]
        if { $value != $default } {
            puts $fileId "$key \"$value\""
        }
    }
    set config [dict set config values $values]
    close $fileId
    if { [file size $fileName] == 0 } {
        file delete -force $fileName
    }
}

proc SetDefaults {configName} {
    global $configName
    set config [set $configName]
    set fileName [dict get $config fileName]
    file delete $fileName
    Restart
}

proc SetDefaultsAll {} {
    global configFolder
    file delete -force "$configFolder"
    Restart
}

proc SaveSourceModAdmins {configName} {
    global $configName
    set config [set $configName]
    set values [dict get $config values]
    set makeMeAdmin [dict get $values makemeadmin]
    set steamUserName [dict get $values steamusername]
    set steamId [dict get $values steamid]
    if {$makeMeAdmin != "1" || $steamUserName == "" || $steamId == ""} {
        return 0
    }
    global serverFolder
    set fileName $serverFolder/csgo/addons/sourcemod/configs/admins.cfg
    set fileid [open "$fileName" "w"]
    puts $fileid "//Autogenerated by csgosl at [clock format [clock seconds]]"
    puts $fileid "//DON'T EDIT, WILL BE OVERWRITTEN NEXT TIME YOU SAVE!!!"
    puts $fileid "//Disable generation by disabling makemeadmin in Steam tab"
    puts $fileid "Admins"
    puts $fileid "{"
    puts $fileid "\"$steamUserName\""
    puts $fileid "{"
    puts $fileid "\"auth\" \"steam\""
    puts $fileid "\"identity\" \"$steamId\""
    puts $fileid "\"flags\" \"z\""
    puts $fileid "\"immunity\" \"99\""
    puts $fileid "}"
    puts $fileid "}"
    close $fileid        
}

proc SaveGameModesServer {filename} {
    global mapGroupsMapper
    set fileid [open "$filename" "w"]
    puts $fileid "//Autogenerated by csgosl at [clock format [clock seconds]]"
    puts $fileid "//DON'T EDIT, WILL BE OVERWRITTEN NEXT TIME YOU SAVE!!!"
    puts $fileid "//For simplicity allows all map groups in all game modes/game types"
    puts $fileid "\"GameModes_Server.txt\""
    puts $fileid "{"
	puts $fileid "\t\"gameTypes\""
	puts $fileid "\t{"
    foreach gameType [list classic gungame training custom cooperative] {
	puts $fileid "\t\t\"$gameType\""
	puts $fileid "\t\t{"    
	puts $fileid "\t\t\t\"gameModes\""
	puts $fileid "\t\t\t{"    
    foreach gameMode [list casual competitive gungameprogressive gungametrbomb deathmatch training custom cooperative coopmission] {
	puts $fileid "\t\t\t\t\"$gameMode\""
	puts $fileid "\t\t\t\t{"    
    foreach mg [list mapgroupsSP mapgroupsMP] {
	puts $fileid "\t\t\t\t\t\"$mg\""
	puts $fileid "\t\t\t\t\t{"
    set nr 0
    dict for {mapGroup maps} $mapGroupsMapper {
		puts $fileid "\t\t\t\t\t\t\"$mapGroup\" \"$nr\""
        incr nr
    }
	puts $fileid "\t\t\t\t\t}"
    }
	puts $fileid "\t\t\t\t}"    
    }
	puts $fileid "\t\t\t}"    
	puts $fileid "\t\t}"
    }
	puts $fileid "\t}"
	puts $fileid "\t\"mapgroups\""
	puts $fileid "\t{"    
    
    dict for {mapGroup maps} $mapGroupsMapper {        
		puts $fileid "\t\t\"$mapGroup\""
        puts $fileid "\t\t{"
        puts $fileid "\t\t\t\"name\" \"$mapGroup\""
        puts $fileid "\t\t\t\"maps\""
        puts $fileid "\t\t\t{"
        foreach map $maps {
			puts $fileid "\t\t\t\t\"$map\" \"\""
        }
        puts $fileid "\t\t\t}"
        puts $fileid "\t\t}"
    }
	puts $fileid "\t}"    
    puts $fileid "}"
    close $fileid        
}

