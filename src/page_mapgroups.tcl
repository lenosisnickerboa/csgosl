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
        text    [list "Select map group to work on in the left view. Add/remove map groups using +/- buttons, or rename/copy map group."] \
        text    [list "Use middle map list view to add/remove maps from currently selected map group using normal selection, i.e."] \
        text    [list "SHIFT-click starts and ends selection, CTRL-click toggles selection, just clicking selects one map and deselects all other."] \
        text    [list "A changed map group is shown in red, press the \"<--\" button to save changes or the \"-->\" button to discard changes."] \
        text    [list "At any time right-click a map to watch a preview of that map in the right pane."] \
        line    [list] \
        space   [list] \
        space   [list] \
        func    [list LayoutFuncMapGroups] \
    ] \
]
