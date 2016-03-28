#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

proc Os {} {
	set osString $::tcl_platform(os)
	switch -glob -- [lindex $osString 0] {
		Win* {
			return windows
		}
		Linux* {
			return linux
		}
		default {
			error "Unsupported OS $tcl_platform(os)"
		}
	}
}
  