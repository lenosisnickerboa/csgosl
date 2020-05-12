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
        h1      [list "View your installed maps here and add a preview picture if it is missing."] \
        space   [list] \
        text    [list "Make sure the preview URL references a single JPG picture file. Use something like \"Open image in new tab\""] \
        text    [list "and then \"Copy image address\" to ensure you get a proper URL to paste in \"Preview URL\" below."] \
        text    [list "Hint: Use map previews from Steam Workshop, they are JPGs and work fine in csgosl."] \
        buttons [list [list text tgotv "Preview sources"] \
                      [list push SteamWorkshopMaps SteamWorkshopMaps {Browser "https://steamcommunity.com/workshop/browse?appid=730"} "Go to Steam Workshop, maps section."] \
                      ] \
        space   [list] \
        func    [list LayoutFuncMaps] \
    ] \
]
