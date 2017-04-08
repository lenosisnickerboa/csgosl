#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

package require Tk

proc GetConfigItem {config key} {
    set prefix [dict get $config prefix]
    set valueName [GetGlobalConfigVariableName $prefix $key]
    global $valueName
    set $valueName
}

proc GetConfigValue {config key} {
    global $config
    set values [dict get $config values]
    return [dict get $values $key]
}

proc SetConfigItem {config key value} {
    set prefix [dict get $config prefix]
    set valueName [GetGlobalConfigVariableName $prefix $key]
    global $valueName
    set $valueName $value                
}

proc SetConfigItemDefault {config key} {
    set meta [dict get $config meta]
    set metaInfo [dict get $meta $key]
    set default [dict get $metaInfo default]
    SetConfigItem $config $key "$default"
}

proc GetConfigParmOptValue {key opt1key opt1value opt2key opt2value } {
    if {$key == $opt1key} {
        return $opt1value
    }
    if {$key == $opt2key} {
        return $opt2value
    }
    return ""
}

proc CreateConfig {configOptions metaDefs} {
    set values [dict create]
    set meta [dict create]
    set parmDisableDefault "1"
    global DisableParmPrefix
    foreach {type metaItems} $metaDefs {
        set mappedToKey ""
        set mappedTo ""
        set onChangeKey ""
        set onChange ""
        if {($type == "string") || ($type == "url") || ($type == "int") || ($type == "bool") ||($type == "directory") ||($type == "list")||($type == "line")} {
            foreach {key default help opt1 opt1value opt2 opt2value} $metaItems { #only ONE iteration
                set values [dict set values $key $default]
                set mappedTo [GetConfigParmOptValue "mappedto" $opt1 $opt1value $opt2 $opt2value]
                if { $mappedTo != "" } {
                    set mappedToKey "mappedto"                    
                    set parmDisableName "$DisableParmPrefix$key"
                    set values [dict set values $parmDisableName "$parmDisableDefault"]
                    set meta [dict set meta $parmDisableName [dict create type "list" default "$parmDisableDefault" help "$key controls the following advanced options:\n $opt1value\nUncheck this toggle to control the advanced options yourself."]]
                }
                set onChange [GetConfigParmOptValue "onchange" $opt1 $opt1value $opt2 $opt2value]
                if { $onChange != "" } {
                    set onChangeKey "onchange"
                }
                set meta [dict set meta "$key" [dict create type $type default $default help $help $mappedToKey $mappedTo $onChangeKey $onChange ]]
            }
        } elseif {$type == "enum"} {
            foreach {key default help selections opt1 opt1value opt2 opt2value} $metaItems { #only ONE iteration
                set values [dict set values $key $default]
                set mappedTo [GetConfigParmOptValue "mappedto" $opt1 $opt1value $opt2 $opt2value]
                if { $mappedTo != "" } {
                    set mappedToKey "mappedto"                    
                    set parmDisableName "$DisableParmPrefix$key"
                    set values [dict set values $parmDisableName "$parmDisableDefault"]
                    set meta [dict set meta $parmDisableName [dict create type "list" default "$parmDisableDefault" help "$key controls the following advanced options:\n $opt1value\nUncheck this toggle to control the advanced options yourself."]]
                }
                set onChange [GetConfigParmOptValue "onchange" $opt1 $opt1value $opt2 $opt2value]
                if { $onChange != "" } {
                    set onChangeKey "onchange"
                }
                set meta [dict set meta "$key" [dict create type $type default $default help $help selections $selections $mappedToKey $mappedTo $onChangeKey $onChange]]
            }
        }
    }
    set config [dict create values $values meta $meta]
    foreach {key value} $configOptions {
        set config [dict set config $key $value]
    }
    return $config
}

proc CreateSplitConfig {configOptions defaultConfig} {
    set values [dict get $defaultConfig values]
    set meta [dict get $defaultConfig meta]
    set config [dict create values $values meta $meta]
    foreach {key value} $configOptions {
        set config [dict set config $key $value]
    }
    return $config
}
