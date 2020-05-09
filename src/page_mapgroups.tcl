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
        text    [list "Enter a name for your new group in the text entry box below the map group list and click Add."] \
        text    [list "Select the group to edit it or click Delete to delete the map group."] \
        line    [list] \
        space   [list] \
        space   [list] \
        func    [list LayoutFuncMapGroupsNew] \
    ] \
]
