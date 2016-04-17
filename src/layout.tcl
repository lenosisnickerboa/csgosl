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

    set header [list \
        h1      [list "Advanced settings for game mode $prefix"] \
        space   [list] \
        line    [list] \
        space   [list] \
    ]
    
    set parms [list]
    foreach key [dict keys $values] {
        lappend parms parm [list $key]
    }
    
    return [concat $header $parms]
}

proc CreateDefaultLayoutFromConfig {config} {
    return [CreateLayout [CreatePageOptions $config] [CreatePageComponents $config]]
}
