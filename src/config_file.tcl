#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir restart.tcl]
source [file join $starkit::topdir version.tcl]

package require Tk

variable currentConfigVersion "1"
#Set defaults here, set when header is read
variable csgoslVersion 0
variable configVersion 0

proc StoreHeader {fp} {
    global version currentConfigVersion 
    puts $fp "// csgosl $version config $currentConfigVersion at [clock format [clock seconds]] (DO NOT TOUCH THIS HEADER LINE!!!)"
}

proc ReadHeader {fp} {
    global csgoslVersion configVersion 
    gets $fp line
    set tokens [ParseLine $line]
    set comment [string trim [lindex $tokens 0] "\""]
    set csgosl [string trim [lindex $tokens 1] "\""]
    set version [string trim [lindex $tokens 2] "\""]
    set config [string trim [lindex $tokens 3] "\""]
    set configV [string trim [lindex $tokens 4] "\""]
    if { $comment == "//" && $csgosl == "csgosl" && $config == "config" } {
        set csgoslVersion $version
        set configVersion $configV
    } else {
        set csgoslVersion 0
        set configVersion 0
    }
}

proc ParseConfigLine {line} {
    set items [regexp -all -inline {\/\/.*|\".*"|\S+} $line]
    if { [llength $items] < 2 } {
        set items [list]
    }
    return $items
}

proc ParseLine {line} {
    return [split $line]
}

proc CreateConfigFile {name meta} {
    set fileId [open $name "w"]
    StoreHeader $fileId
    dict for {key metaItem} $meta {
        set value [dict get $metaItem default]
 #       puts "CreateConfigFile($name) $key=$value"
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

proc LoadConfigFileSub {configName {allowUnknowns false} } {
    global $configName
    set config [set $configName]
    set name [dict get $config fileName]
    set values [dict get $config values]
    set meta [dict get $config meta]
    
    set fp [open "$name" r]
    set fileData [read $fp]
    close $fp
    #skip first header line
    set data [lreplace [split $fileData "\n"] 0 0] 
    foreach line $data {
        set tokens [ParseConfigLine $line]
        set key [string trim [lindex $tokens 0] "\""]
        set value [string trim [lindex $tokens 1] "\""]
        if { [string length $key] > 0 } {
#            puts "LoadConfigFileSub($name): $key=$value"
            if { [dict exists $meta $key] } {
                set metaItem [dict get $meta $key]
                set type [dict get $metaItem type]
                if {$type == "list"} {
                    set value [split "$value"]
                } 
                set values [dict set values "$key" $value]
            } else {
                if {$allowUnknowns} {
                    #This key does not exist in meta, i.e. this is a key that could be a new option which
                    #csgosl is not aware of (yet). Allow it and set some sane defaults for it.
                    set meta [dict set meta "$key" [dict create type "string" default "$value" help "Unknown option, user added?"]]                    
                    set values [dict set values "$key" $value]
                }
            }
        }
    }
    
    set $configName [dict set config meta $meta]
    set $configName [dict set config values $values]
}

proc LoadConfigFile {configName} {
    return [LoadConfigFileSub $configName]
}

proc DetectAndFixSplitConfigFileBug {configName} {
    global $configName
    set config [set $configName]
    set name [dict get $config fileName]
    
    if { ! [file exists "$name"] } {
        return
    }
    
    set fp [open "$name" r]
    ReadHeader $fp
    close $fp

    global configVersion
    if { $configVersion == 0 } {        
        #This is the bug! Remove the file to allow it to be properly reproduced.
        puts "Bug fix applied! Removing buggy config file $name..."
        file delete -force $name               
    }    
}

proc LoadSplitConfigFile {configName} {
    global $configName
    set config [set $configName]
    set nameDefaults [dict get $config fileNameDefaults]
    set origValues [dict get $config values]
    #TODO: could skip setting values from cvars file, not used here anyway.
    set values [dict create]
    set origMeta [dict get $config meta]
    set meta [dict create]
    
    set fp [open "$nameDefaults" r]
    set fileData [read $fp]
    close $fp
    #skip first header line
    set data [lreplace [split $fileData "\n"] 0 0]
    foreach line $data {
        set tokens [ParseConfigLine $line]
        set key [string trim [lindex $tokens 0] "\""]
        set value [string trim [lindex $tokens 1] "\""]
        if { [string length $key] > 0 } {
#            puts "LoadSplitConfigFile($nameDefaults): $key=$value"
            set values [dict set values $key "$value"]
            set help "?"
            if {[dict exists $origMeta $key]} {
                set thisMeta [dict get $origMeta $key]
                set help [dict get $thisMeta help]
            }
            set meta [dict set meta "$key" [dict create type "string" default "$value" help $help]]
        }            
    }
    
    set $configName [dict set config meta $meta]
    set $configName [dict set config values $values]
    DetectAndFixSplitConfigFileBug $configName
    EnsureConfigFile $configName
    set allowUnknows true
    LoadConfigFileSub $configName $allowUnknows
}

proc LoadMapGroupsMapper {filename} {
    global mapGroupsMapper
    set fp [open "$filename" r]
    set fileData [read $fp]
    close $fp
    #skip first header line
    set data [lreplace [split $fileData "\n"] 0 0] 
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
    StoreHeader $fileId
    dict for {mapGroup maps} $mapGroupsMapper {
        puts $fileId "mg-$mapGroup \"$maps\""
    }
    close $fileId        
}

proc IsValidIp {ip} {
    if {[scan $ip %d.%d.%d.%d a b c d] == 4
     && 0 <= $a && $a <= 255 && 0 <= $b && $b <= 255
     && 0 <= $c && $c <= 255 && 0 <= $d && $d <= 255} {
        return true
    } else {
        return false
    }    
}

proc SaveSimpleAdminsFile {filename admins} {
    set fp [open "$filename" "w"]
    StoreHeader $fp
    puts $fp "//DON'T EDIT, WILL BE OVERWRITTEN NEXT TIME YOU SAVE!!!"
    foreach admin $admins {
        if { [IsValidIp $admin] } {
            puts $fp "\"!$admin\" \"98:z\""            
        } else {
            puts $fp "\"$admin\" \"98:z\""            
        }
    }
    close $fp    
}

proc SaveMaps {filename maps} {
    set fp [open "$filename" "w"]
    StoreHeader $fp
    puts $fp "//DON'T EDIT, WILL BE OVERWRITTEN NEXT TIME YOU SAVE!!!"
    foreach map $maps {
        puts $fp $map
    }
    close $fp    
}

proc SaveMapListTxt {filename} {
    global allMaps
    SaveMaps $filename $allMaps 
}

proc SaveMapCycleTxt {filename selectedMapGroup} {
    global mapGroupsMapper
    if { [dict exists $mapGroupsMapper $selectedMapGroup] } {
        SaveMaps $filename [dict get $mapGroupsMapper $selectedMapGroup]
    } else {
        global allMaps
        SaveMaps $filename $allMaps
    }
}

proc SaveConfigFile {configName} {
    global $configName
    set config [set $configName]
    set fileName [dict get $config fileName]
    set prefix [dict get $config prefix]
    set values [dict get $config values]
    set meta [dict get $config meta]

    global ValueToSkip
    set fileId [open $fileName "w"]
    StoreHeader $fileId
    dict for {key value} $values {
        set valueName [GetGlobalConfigVariableName $prefix $key]
        global $valueName
        set value [set $valueName]
        if { $value != $ValueToSkip } {
            set values [dict set values $key "$value"]
            set metaItem [dict get $meta $key]
            set type [dict get $metaItem type]
            if {$type == "line"} {
                puts $fileId $value            
            } else {
                puts $fileId "$key \"$value\""            
            }
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
    StoreHeader $fileId
    dict for {key value} $values {
#        puts "SaveSplitConfigFile($fileName) $key=$value"
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
    global modsFolder
    if { ! [file exists "$modsFolder/sourcemod"] } {
        return 0
    }
    set fileName "$modsFolder/sourcemod/configs/admins.cfg"
    set fileid [open "$fileName" "w"]
    StoreHeader $fileid
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
    StoreHeader $fileid
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

