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
        text    [list "Select map group to work on in the left view. Add/remove maps in middle view using normal selection, i.e."] \
        text    [list "SHIFT-click starts and ends selection, CTRL-click toggles selection, just clicking selects one map and deselects all other."] \
        text    [list "When done press the \"Update\" button to update map group, or the \"Restore\" button to discard your changes."] \
        text    [list "At any time right-click a map to watch a preview of that map in the right pane."] \
        line    [list] \
        space   [list] \
        space   [list] \
        func    [list LayoutFuncMapGroupsNew] \
    ] \
]
