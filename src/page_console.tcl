#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## console config
variable consoleConfig [CreateConfig \
    [list \
        name     "consoleConfig" \
        prefix   "Console" \
        fileName "$configFolder/console.cfg" \
        saveProc "SaveConfigFileConsole" \
    ] \
    [list \
    ] \
]

variable consoleLayout [CreateLayout \
    [list \
        configName  "consoleConfig" \
        tabName     "Console" \
        help        "Console" \
    ] \
    [list \
        h1      [list "Console"] \
        space   [list] \
        text    [list "This console windows shows commands executed by csgosl, mainly useful for debugging."] \
        space   [list] \
        line    [list] \
        space   [list] \
        func    [list LayoutFuncConsole] \
    ] \
]
