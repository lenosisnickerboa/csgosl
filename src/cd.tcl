#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir os.tcl]

proc Cd {targetDir} {
    cd "$targetDir"
    if {[Os] == "windows"} {
        exec cmd /c cd /d "$targetDir"        
    }
}
