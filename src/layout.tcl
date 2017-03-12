#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

proc CreateLayout {pageOptions pageComponents} {
    set options [dict create]
    foreach {name args} $pageOptions {
        set options [dict set options $name $args]
    }
    set layout [dict create options $options components $pageComponents]
    return $layout
}

proc CreatePageOptions {config} {
    set configName [dict get $config name]
    set prefix [dict get $config prefix]
    #The prefix is hardcoded to Advanced-Tabs right now, these tabs are the only
    #one using the default layout scheme
    return [list \
            configName "$configName" \
            tabName    "$prefix" \
            help       "Advanced-Tabs" \
    ]
}

proc CreatePageComponents {config} {
    set prefix [dict get $config prefix]
    set values [dict get $config values]
    set meta [dict get $config meta]

    set header [list \
        h1      [list "Advanced settings for game mode $prefix"] \
        space   [list] \
        line    [list] \
        space   [list] \
    ]
    
    set parmsCustom [list]
    set parmsPredefined [list]
    set headerCustom [list]    
    set headerPredefined [list]
    
    set customExists 0
    foreach key [dict keys $values] {
        if { [dict exists $meta $key] } {
            set metaItem [dict get $meta $key]
            if { [dict exists $metaItem custom] } {
                set customExists 1
                break
            }
        }
    }
    
    if { $customExists } {
        set headerCustom [list \
            h2      [list "Custom cvars"] \
            space   [list] \
            line    [list] \
            space   [list] \
        ]
        set headerPredefined [list \
            space   [list] \
            h2      [list "Predefined cvars"] \
            space   [list] \
            line    [list] \
            space   [list] \
        ]        
        foreach key [dict keys $values] {
            if { [dict exists $meta $key] } {
                set metaItem [dict get $meta $key]
                if { [dict exists $metaItem custom] } {
                    lappend parmsCustom parm [list $key]                            
                }
            }
        }        
    }
    foreach key [dict keys $values] {
        if { [dict exists $meta $key] } {
            set metaItem [dict get $meta $key]
            if { ! [dict exists $metaItem custom] } {
                lappend parmsPredefined parm [list $key]
            }
        }
    }
    
    return [concat $header $headerCustom $parmsCustom $headerPredefined $parmsPredefined]
}

proc CreateDefaultLayoutFromConfig {config} {
    return [CreateLayout [CreatePageOptions $config] [CreatePageComponents $config]]
}
