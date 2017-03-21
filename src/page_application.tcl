#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Application config
variable applicationConfig [CreateConfig \
    [list \
        name     "applicationConfig" \
        prefix   "Application" \
        fileName "$configFolder/application.cfg" \
        saveProc "SaveConfigFileApplication" \
    ] \
    [list \
        "bool"      [list fullconfig "0" "Enable this option to be able to fine tune all csgo server parameters.\nA number of new configuration pages, one per game mode, will be displayed.\nYou need to restart csgosl after this change."]\
        "bool"      [list tclconsole "0" "Open tcl console when starting csgosl.\nWindows only"]\
        "bool"      [list trace "1" "Control tracing. Traces are printed to the terminal (linux) and in the console tab (Windows)."]\
        "bool"      [list dryrun "0" "Performs everything except actually starting the server.\nSometimes convenient when troubleshooting or testing.\nCommand line is traced."]\
        "bool"      [list updatecheck "1" "Checks for csgosl updates after program has started."]\
        "bool"      [list showdonation "1" "Disable to stop showing donation button. Please consider donating first though :)"]\
        "string"    [list mainwingeometry "800x600+100+100" "last saved windows size and location."]\
    ] \
]

variable applicationLayout [CreateLayout \
    [list \
        configName  "applicationConfig" \
        tabName     "Application" \
        help        "Application" \
    ] \
    [list \
        h1      [list "csgosl application settings"] \
        space   [list] \
        h2      [list "GUI"] \
        line    [list] \
        space   [list] \
        parm    [list fullconfig] \
        space   [list] \
        h2      [list "Troubleshooting"] \
        line    [list] \
        space   [list] \
        parm    [list dryrun] \
        parm    [list updatecheck] \
        parm    [list tclconsole] \
        parm    [list trace] \
        parm    [list showdonation] \
        space   [list] \
        func    [list LayoutFuncSetDefaultsAll] \
        space   [list] \
    ] \
]
