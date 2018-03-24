#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

package require http

source [file join $starkit::topdir trace.tcl]

#Keep, but doesn't support https
#proc Wget {url filename} {
#	Trace "Wget: $url -> $filename"
#    set r  [http::geturl $url -binary 1]
#    set fo [open $filename w]
#    fconfigure $fo -translation binary
#    puts -nonewline $fo [http::data $r]
#    close $fo
#    ::http::cleanup $r	
#	Trace "Wget: $url -> $filename OK"
#}
  
proc Wget {url filename} {
	Trace "Wget: $url -> $filename"
	global currentOs
	if { $currentOs == "windows" } {
		global installFolder
		exec "$installFolder/bin/wget" "$url" --quiet -O "$filename"
	} else {
		exec "wget" "$url" --quiet -O "$filename"
	}
 	Trace "Wget: $url -> $filename OK"
}

proc WgetPost {url post filename} {
	Trace "WgetPost: $url $post -> $filename"
	global currentOs
	if { $currentOs == "windows" } {
		global installFolder
		exec "$installFolder/bin/wget" "$url" --post-data "$post" --quiet -O "$filename"
	} else {
		exec "wget" "$url" --post-data "$post" --quiet -O "$filename"
	}
 	Trace "WgetPost: $url $post -> $filename OK"
}
  