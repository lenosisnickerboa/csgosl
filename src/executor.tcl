#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

# Adapted from http://www.beedub.com/book/2nd/TKEXAMPL.doc.html

# execlog - run a program with exec and log the output

proc ExecutorCreate {at} {
	# Create a frame for buttons and entry.
	
	frame $at.top -borderwidth 10
	pack $at.top -side top -fill x
	
	# Create the command buttons.
	
	#button $at.top.quit -text Quit -command exit
#	global executorRunButton
#	set executorRunButton [button $at.top.run -text "Run it" -command ExecutorRun]
	#pack $at.top.quit $at.top.run -side right
	
	# Create a labeled entry for the command
	
	label $at.top.l -text Command: -padx 0
	entry $at.top.cmd -width 80 -relief sunken \
		-textvariable executorCommand
	pack $at.top.l -side left
	pack $at.top.cmd -side left -fill x -expand true
	
	# Set up key binding equivalents to the buttons
	
	bind $at.top.cmd <Return> ExecutorRun
	#bind $at.top.cmd <Control-c> ExecutorStop
	focus $at.top.cmd
	
	# Create a text widget to log the output
	
	frame $at.t
	variable executorTLog $at.t.log
	#when -setgrid true is used the main window is huge in windows, disabled for now
	#variable executorLog [text $at.t.log -width 80 -height 15 \
	#	-borderwidth 2 -relief raised -setgrid true \
	#	-yscrollcommand [subst {$at.t.scroll set}]]
	variable executorLog [text $at.t.log -width 80 -height 15 \
		-borderwidth 2 -relief raised \
		-yscrollcommand [subst {$at.t.scroll set}]]
	scrollbar $at.t.scroll -command {$executorTLog yview}
	pack $at.t.scroll -side right -fill y
	pack $at.t.log -side left -fill both -expand true
	pack $at.t -side top -fill both -expand true    
}

# Run the program and arrange to read its input

#	if [catch {open "|$command |& cat"} input] {
proc ExecutorRunSync {} {
	global executorCommand executorInput executorLog executorRunButton
	if [catch {open "|$executorCommand "} executorInput] {
		$executorLog insert end $executorInput\n
	} else {
#		fileevent $executorInput readable ExecutorLog
		$executorLog insert end $executorCommand\n
#		$executorRunButton config -text Stop -command ExecutorStop
	}
}

proc ExecutorRun {} {
	global executorCommand executorInput executorLog executorRunButton
	if [catch {open "|$executorCommand "} executorInput] {
		$executorLog insert end $executorInput\n
	} else {
		fileevent $executorInput readable ExecutorLog
		$executorLog insert end $executorCommand\n
#		$executorRunButton config -text Stop -command ExecutorStop
	}
}
# Read and log output from the program

proc ExecutorLog {} {
	global executorInput executorLog
	if [eof $executorInput] {
		ExecutorStop
	} else {
		gets $executorInput line
		$executorLog insert end $line\n
		$executorLog see end
	}
}

# Stop the program and fix up the button

proc ExecutorStop {} {
	global executorInput executorRunButton
	catch {close $executorInput}
	$executorRunButton config -text "Run it" -command ExecutorRun
}

