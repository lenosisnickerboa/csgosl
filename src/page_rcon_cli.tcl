#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## rcon client config
variable rconCliConfig [CreateConfig \
    [list \
        name     "rconCliConfig" \
        prefix   "RconCli" \
        fileName "$configFolder/rconcli.cfg" \
        saveProc "SaveConfigFileRconCli" \
    ] \
    [list \
        "string"  [list overrideip "" "Use this ip address instead of the automatically detected ip address.\nCan be used if auto detection fails or if you want to connect to some other server.\nKeep blank if you don't understand what this is."]\
        "int"     [list overrideport "" "Use this port instead of the port configured for your csgo server.\nCan be used if you want to connect to some other server.\nKeep blank if you don't understand what this is."]\
        "string"  [list overridepassword "" "Use this password instead of the password configured for rcon to your csgo server.\nCan be used if you want to connect to some other server.\nKeep blank if you don't understand what this is."]\
    ] \
]

variable rconCliLayout [CreateLayout \
    [list \
        configName  "rconCliConfig" \
        tabName     "RconCli" \
        help        "RconCli" \
    ] \
    [list \
        h1      [list "RconCli settings"] \
        space   [list] \
        h2      [list "General"] \
        line    [list] \
        space   [list] \
        func    [list LayoutFuncRconCli] \
        warning [list "You may get a firewall warning when running rcon commands, simply allow and remember the access."] \
        line    [list] \
        space   [list] \
        text    [list "These settings are only used to override the automatic rcon functionality. Leave blank or read the help text carefully."] \
        space   [list] \
        parm    [list overrideip] \
        parm    [list overrideport] \
        parm    [list overridepassword] \
    ] \
]
