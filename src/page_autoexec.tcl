#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Autoexec config -- mostly built dynamically by autoexec_support.tcl
variable autoexecConfig
variable autoexecConfigList1  [list \
        name     "autoexecConfig" \
        prefix   "Autoexec" \
        fileName "$configFolder/autoexec.cfg" \
        saveProc "SaveConfigFileAutoexec" \
    ]
variable autoexecConfigList2 [list \
    ] 

variable autoexecLayout
variable autoexecLayoutList1 [list \
        configName  "autoexecConfig" \
        tabName     "Autoexec" \
        help        "Autoexec" \
    ]
variable autoexecLayoutList2 
