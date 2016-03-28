#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

#source: http://wiki.tcl.tk/12871

#: minimal wget - wiki.tcl.tk/12871 / Radio-edition - 2012-12-28
package require http

source [file join $starkit::topdir trace.tcl]

proc Wget {url filename} {
	Trace "Wget: $url -> $filename"
    set r  [http::geturl $url -binary 1]
    set fo [open $filename w]
    fconfigure $fo -translation binary
    puts -nonewline $fo [http::data $r]
    close $fo
    ::http::cleanup $r	
	Trace "Wget: $url -> $filename OK"
}
  