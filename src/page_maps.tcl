#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Maps config
### Show all available maps with pics
variable mapsConfig [CreateConfig \
    [list \
        name     "mapsConfig" \
        prefix   "Maps" \
        fileName "" \
        saveProc "SaveProcDummy" \
    ] \
    [list \
    ] \
]

variable mapsLayout [CreateLayout \
    [list \
        configName  "mapsConfig" \
        tabName     "Maps" \
        help        "Maps" \
    ] \
    [list \
        space   [list] \
        h1      [list "View your installed maps here and add preview pictures if missing"] \
        space   [list] \
        line    [list] \
        space   [list] \
        func    [list LayoutFuncMapsNew] \
    ] \
]
