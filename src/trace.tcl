#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

set TraceBeforeExecutorLogPresent ""
proc Trace {text} {
    global traceEnabled
    if {! $traceEnabled} {
        return
    }
    set systemTime [clock seconds]
    set time [clock format $systemTime -format %H:%M:%S]
    global currentOs
    if {$currentOs == "windows"} {
        global TraceBeforeExecutorLogPresent
        global executorLog
        if {[info exists executorLog]} {
            if { $TraceBeforeExecutorLogPresent != "" } {
                $executorLog insert end "$TraceBeforeExecutorLogPresent"
                set TraceBeforeExecutorLogPresent ""
            }
            $executorLog insert end "$time $text\n"
            $executorLog see end
        } else {
            set TraceBeforeExecutorLogPresent "$TraceBeforeExecutorLogPresent$time: $text\n"            
        }
    } else {
        puts "$time: $text"
    }
}

  