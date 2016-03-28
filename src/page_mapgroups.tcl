#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Map groups config
### Create and edit map groups
variable mapGroupsConfig [CreateConfig \
    [list \
        name     "mapGroupsConfig" \
        prefix   "MapGroups" \
        fileName "$configFolder/mapGroups.cfg" \
        saveProc "SaveConfigFileMapGroups" \
    ] \
    [list \
	 "list" [list "mapGroups" "" ""]\
    ] \
]

variable mapGroupsLayout [CreateLayout \
    [list \
        configName  "mapGroupsConfig" \
        tabName     "Map groups" \
        help        "MapGroups" \
    ] \
    [list \
        space   [list] \
        h1      [list "Create custom map groups using your installed maps."] \
        space   [list] \
        text    [list "Enter a name for your new group, click Add and then Edit to define which maps to include"] \
        text    [list "in this groups. Simply close the maps windows when you have finished maps selection."] \
        line    [list] \
        space   [list] \
        space   [list] \
        func    [list LayoutFuncMapGroups] \
    ] \
]
