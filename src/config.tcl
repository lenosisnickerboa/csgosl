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

proc CreateConfig {configOptions metaDefs} {
    set values [dict create]
    set meta [dict create]
    foreach {type metaItems} $metaDefs {
        if {($type == "string") || ($type == "url") || ($type == "int") || ($type == "bool") ||($type == "directory") ||($type == "list")||($type == "line")} {
            foreach {key default help} $metaItems {
                set values [dict set values $key $default]
                set meta [dict set meta "$key" [dict create type $type default $default help $help]]
            }
        } elseif {$type == "enum"} {
            foreach {key default help selections} $metaItems {
                set values [dict set values $key $default]
                set meta [dict set meta "$key" [dict create type $type default $default help $help selections $selections]]
            }
        }
    }
    set config [dict create values $values meta $meta]
    foreach {key value} $configOptions {
        set config [dict set config $key $value]
    }
    return $config
}

proc CreateSplitConfig {configOptions} {
    set values [dict create]
    set meta [dict create]
    set config [dict create values $values meta $meta]
    foreach {key value} $configOptions {
        set config [dict set config $key $value]
    }
    return $config
}
