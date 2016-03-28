#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir os.tcl]
source [file join $starkit::topdir cd.tcl]

proc Unzip {inArchive targetDir} {
    set archive [file nativename "$inArchive"]
    Trace "Unzip $archive -> $targetDir"
    set returnTo "[pwd]"
    Cd "$targetDir"
    #-o, overwrite without prompt
	if {[Os] == "windows"} {
	    global installFolder
	    exec "$installFolder/bin/unzip" -o "$archive"
	} else {
	    exec "unzip" -o "$archive"				
	}
	Cd "$returnTo"
    Trace "Unzip $archive -> $targetDir OK"
}
