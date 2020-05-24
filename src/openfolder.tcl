#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir trace.tcl]

#source: https://wiki.tcl-lang.org/page/Invoking+browsers, Lorrys contribution from 2015-11-22
proc OpenFolder {url} {
	Trace "OpenFolder: $url"
	# open is the OS X equivalent to xdg-open on Linux, start is used on Windows
	set commands {xdg-open open start}
	foreach browser $commands {
	  if {$browser eq "start"} {
		set command [list {*}[auto_execok start] {}]
	  } else {
		set command [auto_execok $browser]
	  }
	  if {[string length $command]} {
		break
	  }
	}
	
	if {[string length $command] == 0} {
	  return -code error "couldn't find browser"
	}
	if {[catch {exec {*}$command $url &} error]} {
	  return -code error "couldn't execute '$command': $error"
	}
}