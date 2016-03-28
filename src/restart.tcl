#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

proc Restart {} {
	#Used in conjunction with wrapper script to be able to restart application
	exit 42
}
  