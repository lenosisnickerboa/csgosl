#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

proc Trace {text} {
    global traceEnabled
    if {! $traceEnabled} {
        return
    }
    set systemTime [clock seconds]
    set time [clock format $systemTime -format %H:%M:%S]
    global currentOs
    if {$currentOs == "windows"} {
        global executorLog
        if {[info exists executorLog]} {
            $executorLog insert end "$time $text\n"
            $executorLog see end
        }
    } else {
        puts "$time: $text"
    }
}

  