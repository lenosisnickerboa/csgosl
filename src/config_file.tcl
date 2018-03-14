#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir restart.tcl]
source [file join $starkit::topdir version.tcl]
source [file join $starkit::topdir maps_support.tcl]

package require Tk

variable currentConfigVersion "1"
#Set defaults here, set when header is read
variable csgoslVersion 0
variable configVersion 0

proc StoreHeader {fp {prefix "//"}} {
    global version currentConfigVersion 
    puts $fp "$prefix csgosl $version config $currentConfigVersion at [clock format [clock seconds]] (DO NOT TOUCH THIS HEADER LINE!!!)"
}
proc StoreHeaderInScript {fp} {
    global currentOs
    if {$currentOs == "windows"} {
        StoreHeader $fp "@REM"
    } else {
        StoreHeader $fp "#"
    }
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

proc ParseCustomCvarsLine {line} {
    set items [regexp -all -inline {(?:[^ "]|\"[^"]*\")+} $line]
#editor goes haywire without this ending quote "
    if { [llength $items] < 4 } {
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

proc LoadConfigFileCustomCvars {configName} {
    global $configName
    set config [set $configName]
    set fileName "[file rootname [dict get $config fileName]].custom.cfg"
#    Trace "Trying to load cvars from $fileName"
    if { ! [file exists "$fileName"] } {
        return 1
    }
    set meta [dict get $config meta]
    set values [dict get $config values]

    set fp [open "$fileName" r]
    set fileData [read $fp]
    close $fp
    #skip first header line
    set data [lreplace [split $fileData "\n"] 0 0] 
    foreach line $data {
        set tokens [ParseCustomCvarsLine $line]
        set key [string trim [lindex $tokens 0] "\""]
        set type [string trim [lindex $tokens 1] "\""]
        set default [string trim [lindex $tokens 2] "\""]
        set help [string trim [lindex $tokens 3] "\""]
        if { [string length $key] > 0 } {
            if { $type == "string" } {
#                puts "LoadConfigFileCvars from $fileName: key=$key, type=$type, default=$default, help=$help"
                set meta [dict set meta "$key" [dict create type "$type" default "$default" help "$help" custom "1" ]]
                set values [dict set values "$key" $default]
            } else {
                Trace "Ignored $key of type \"$type\", currently only type \"string\" is supported."
            }
        }
    }
    set $configName [dict set config meta $meta]
    set $configName [dict set config values $values]
}

proc LoadConfigFileSub {configName {allowUnknowns false} } {
    global $configName
    LoadConfigFileCustomCvars $configName    
    
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
    dict set mapGroupsMapper "<allmaps>" ""
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
        if { $mapGroup != "<allmaps>" } {
            puts $fileId "mg-$mapGroup \"$maps\""            
        }
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

proc SaveCustomCvars {configName} {
    global $configName
    set config [set $configName]
    set meta [dict get $config meta]

    set customExists 0    
    dict for {key metaItem} $meta {
        if { [dict exists $metaItem custom] } {
            set customExists 1
            break
        }
    }
    
    set fileName "[file rootname [dict get $config fileName]].custom.cfg"

    if { $customExists == 0 } {
        if { [file exists $fileName] } {
            file delete -force $fileName
        }
        return 1
    }

    set fileId [open $fileName "w"]
    StoreHeader $fileId
    
    set values [dict get $config values]
    set prefix [dict get $config prefix]
    
    dict for {key metaItem} $meta {
        if { [dict exists $metaItem custom] } {
            set default [dict get $metaItem default]
            set help [dict get $metaItem help]
            set type [dict get $metaItem type]
#            Trace "Storing custom key $key in $fileName"
            puts $fileId "$key $type \"$default\" \"$help\""
        }
    }
    close $fileId
}

proc AddNewCustomCvarSub {configName name default help} {
#    Trace "AddNewCustomCvarSub configName=$configName, name=$name, default=$default, help=$help"
    global $configName
    set config [set $configName]
    set values [dict get $config values]
    set meta [dict get $config meta]
    set meta [dict set meta "$name" [dict create type "string" default "$default" help "$help" custom "1"]]
    set $configName [dict set config meta $meta]
    SaveCustomCvars $configName    
}

proc AddNewCustomCvar {configName name default help} {
    AddNewCustomCvarSub $configName $name "$default" "$help"
    if { $configName == "gameModeAllConfig" } {
        AddNewCustomCvarGameModeAll $name "$default" "$help"
    }
}

proc RemoveCustomCvar {configName name} {
#    Trace "RemoveCustomCvarSub configName=$configName, name=$name"
    global $configName
    set config [set $configName]
    set values [dict get $config values]
    set meta [dict get $config meta]    
    set values [dict remove $values $name]
    set meta [dict remove $meta $name]
    set $configName [dict set config meta $meta]
    set $configName [dict set config values $values]
    SaveCustomCvars $configName
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
        if { [info exists $valueName] } {
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
        } else {
            Trace "Failed to read option $key when saving file $fileName"
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
        if { [info exists $valueName] } {
            set value [set $valueName]
            set values [dict set values $key "$value"]
            set metaItem [dict get $meta $key]
            set default [dict get $metaItem default]
            if { $value != $default } {
                puts $fileId "$key \"$value\""
            }
        } else {
            Trace "Failed to read option $key when saving file $fileName"
        }
    }
    SaveCustomCvars $configName
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
    global applicationConfig
    set generategamemodeservers [GetConfigValue $applicationConfig generategamemodeservers]
    if {$generategamemodeservers != 1} {
        Trace "Skipping generation of gameModes_server.txt"
        return
    }
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

    global applicationConfig
    set includeworkshopmappath [GetConfigValue $applicationConfig includeworkshopmappath]
    
    dict for {mapGroup maps} $mapGroupsMapper {        
		puts $fileid "\t\t\"$mapGroup\""
        puts $fileid "\t\t{"
        puts $fileid "\t\t\t\"name\" \"$mapGroup\""
        puts $fileid "\t\t\t\"maps\""
        puts $fileid "\t\t\t{"
        if { $mapGroup == "<allmaps>" } {
            global allMaps
            set maps $allMaps
        }
        foreach map $maps {
            if { $includeworkshopmappath == "1" } {
                set path [GetWorkshopMapPath $map]
                if { $path != "" } {
                    set map "$path/$map"
                }
       			puts $fileid "\t\t\t\t\"$map\" \"\""                                
            } else {
       			puts $fileid "\t\t\t\t\"$map\" \"\""                                
            }
        }
        puts $fileid "\t\t\t}"
        puts $fileid "\t\t}"
    }
	puts $fileid "\t}"    
    puts $fileid "}"
    close $fileid        
}

