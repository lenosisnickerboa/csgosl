#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir cd.tcl]

proc Untar {archive targetDir} {
    Trace "Untar $archive -> $targetDir"
    set returnTo "[pwd]"
    Cd "$targetDir"
    #-o, overwrite without prompt
    exec "tar" "xvzf" "$archive"
	Cd "$returnTo"
    Trace "Untar $archive -> $targetDir OK"
}
