#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

#source: sed taken from http://wiki.tcl.tk/9382, sedf is my wrapper around sed

proc ::sed {script input} {
  set sep [string index $script 1]
  foreach {cmd from to flag} [split $script $sep] break
  switch -- $cmd {
	  "s" {
		  set cmd regsub
		  if {[string first "g" $flag]>=0} {
			  lappend cmd -all
		  }
		  if {[string first "i" [string tolower $flag]]>=0} {
			  lappend cmd -nocase
		  }
		  set idx [regsub -all -- {[a-zA-Z]} $flag ""]
		  if { [string is integer -strict $idx] } {
			  set cmd [lreplace $cmd 0 0 regexp]
			  lappend cmd -inline -indices -all -- $from $input
			  set res [eval $cmd]
			  set which [lindex $res $idx]
			  return [string replace $input [lindex $which 0] [lindex $which 1] $to]
		  }
		  # Most generic case
		  lappend cmd -- $from $input $to
		  return [eval $cmd]
	  }
	  "e" {
		  set cmd regexp
		  if { $to eq "" } { set to 0 }
		  if {![string is integer -strict $to]} {
			  return -error code "No proper group identifier specified for extraction"
		  }
		  lappend cmd -inline -- $from $input
		  return [lindex [eval $cmd] $to]
	  }
	  "y" {
		  return [string map [list $from $to] $input]
	  }
  }
  return -code error "not yet implemented"
}

#My added wrapper for operating on a file
proc sedf {script fileName} {	
    set fp [open "$fileName" r]
    set fileData [read $fp]
    close $fp
    set data [split $fileData "\n"]
	
    set fp [open "$fileName" "w"]
		
    foreach line $data {
		set line [sed $script $line]
        puts $fp $line
	}	
    close $fp
}

