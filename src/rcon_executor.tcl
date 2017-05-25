#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

# Inspired by from http://www.beedub.com/book/2nd/TKEXAMPL.doc.html
# Used to execute rcon commands

#https://developer.valvesoftware.com/wiki/Source_RCON_Protocol

source [file join $starkit::topdir trace.tcl]

namespace eval rcon {
	variable executorCommand
	variable executorLog
	variable currentRconIp ""
	variable currentRconPort ""
	#Size:4, ID:4, TYPE:4
	variable HEADER_SIZE 12
	variable TYPE_SERVERDATA_AUTH 3
	variable TYPE_SERVERDATA_AUTH_RESPONSE 2
	variable TYPE_SERVERDATA_EXECCOMMAND 2
	variable TYPE_SERVERDATA_RESPONSE_VALUE 0
	variable ID_AUTH 42
	variable ID_CMD 24
	variable lastError ""
}

proc rcon::PacketSize {cmd} {
	# The initial header size field is not included in packet size -> 8 bytes
	# And always add the two final zero bytes -> 8 + 2 -> 10
	return [expr [string length $cmd] + 10]
}

#TODO: implement command buffer, arrow up/down

proc rcon::GetCurrentRconAddress {} {
	global ::rcon::currentRconIp ::rcon::currentRconPort
	return "$::rcon::currentRconIp\:$::rcon::currentRconPort"
}

proc rcon::TraceConsole {line} {
	global ::rcon::executorLog
	$::rcon::executorLog insert end $line
	$::rcon::executorLog see end    
}

proc rcon::MyIp {} {
	set me [socket -server temporaryipserver -myaddr [info hostname] 0] 
	set ip [lindex [fconfigure $me -sockname] 0] 
	close $me 
	return $ip
}

proc rcon::Connect {} {
	global serverConfig ::rcon::currentRconIp ::rcon::currentRconPort
	set rconEnabled [GetConfigValue $serverConfig rcon]
	if {$rconEnabled == 0} {
		error "RCON is not enabled, first enable it in the server tab."
	}
	if {[DetectServerRunning] != "running"} {
		error "CSGO server is not started, start it before trying to send rcon commands to it."
	}	
    global rconCliConfig
    set overrideIp [GetConfigValue $rconCliConfig overrideip]
	if {$overrideIp == ""} {
		set ::rcon::currentRconIp [MyIp]
	} else {
		set ::rcon::currentRconIp $overrideIp
	}
    set overridePort [GetConfigValue $rconCliConfig overrideport]
	if {$overridePort == ""} {
	    global serverConfig
	    set ::rcon::currentRconPort [GetConfigValue $serverConfig port]
	} else {
		set ::rcon::currentRconPort $overridePort
	}
	Trace "Connecting to RCON at [::rcon::GetCurrentRconAddress]..."
	set chan [socket $currentRconIp $currentRconPort]
	chan configure $chan -buffering none -translation binary -encoding binary
	return $chan
}

#Null terminated string
proc rcon::Recv_BODY {chan size} {
#	Trace "Recv BODY(size=$size)..."
	set body [read $chan $size]
	#Read last two terminating zero bytes
	read $chan 2
	return $body
}

#Size:4, ID:4, TYPE:4
proc rcon::Recv_HEADER {chan requiredId requiredType} {
#	Trace "Recv HEADER(id=$requiredId)..."
	set reply [read $chan $::rcon::HEADER_SIZE]
	set nrConvs [binary scan $reply iii size id type]
#	Trace "HEADER= SIZE=$size ID=$id TYPE=$type"
	if {$id != $requiredId} {
		error "Expected ID $requiredId but got ID $id"
	}
	if {$type != $requiredType} {
		error "Expected type $requiredType but got type $type"		
	}
	#Return body size
	return [expr $size - 10]
}

proc rcon::Recv_SERVERDATA_RESPONSE_VALUE {chan requiredId} {
#	Trace "Recv SERVERDATA_RESPONSE_VALUE(id=$requiredId)..."
	set size [Recv_HEADER $chan $requiredId $::rcon::TYPE_SERVERDATA_RESPONSE_VALUE]
	return [Recv_BODY $chan $size]
}

proc rcon::Recv_SERVERDATA_AUTH_RESPONSE {chan requiredId} {
#	Trace "Recv SERVERDATA_AUTH_RESPONSE(id=$requiredId)..."
	set size [Recv_HEADER $chan $requiredId $::rcon::TYPE_SERVERDATA_AUTH_RESPONSE]
	return [Recv_BODY $chan $size]
}

proc rcon::DoAuthenticate {chan} {
	global rconCliConfig
	set overridePassword [GetConfigItem $rconCliConfig overridepassword]
	if {$overridePassword != ""} {
		set rconPassword $overridePassword		
	} else {
		global serverConfig
		set rconPassword [GetConfigItem $serverConfig rconpassword]		
	}
	if {$rconPassword == ""} {
		error "No RCON password set, set it first in the server tab, restart server and try again."
	}
	set pSize [::rcon::PacketSize $rconPassword]
	set pId $::rcon::ID_AUTH
	#SERVERDATA_AUTH
	set pType $::rcon::TYPE_SERVERDATA_AUTH
#	Trace "Sending authorization request, package of size $pSize..."
	set packet [binary format iiia*xx $pSize $pId $pType $rconPassword]
	puts -nonewline $chan $packet
#	Trace "Waiting for authentication response..."
	set body [Recv_SERVERDATA_RESPONSE_VALUE $chan $pId]
	set body [Recv_SERVERDATA_AUTH_RESPONSE $chan $pId]
	return 0
}

proc rcon::Authenticate {chan} {
    if {[catch {DoAuthenticate $chan} errMsg]} {
		set ::rcon::lastError "Failed authenticating with server [::rcon::GetCurrentRconAddress] ($errMsg)"
		return -1
    }
	return 0
}

proc rcon::BuildCommand {id cmd} {
	set type $::rcon::TYPE_SERVERDATA_EXECCOMMAND
	set cmdPacket [binary format iiia*xx [::rcon::PacketSize $cmd] $id $type $cmd]
	return $cmdPacket
}

proc rcon::DoSendCommand {chan cmd} {
	set id $::rcon::ID_CMD
#	Trace "Send SERVERDATA_EXECCOMMAND(id=$id)"
	set packet [::rcon::BuildCommand $id $cmd]
	puts -nonewline $chan $packet
	set body [Recv_SERVERDATA_RESPONSE_VALUE $chan $id]
	::rcon::TraceConsole "$body\n"
}

proc rcon::SendCommand {chan cmd} {
    if {[catch {DoSendCommand $chan $cmd} errMsg]} {
        set ::rcon::lastError "Failed sending command $cmd to server [::rcon::GetCurrentRconAddress] ($errMsg)"
		return -1
    }
	return 0
}

proc rcon::DoConnectToServer {} {
	return [::rcon::Connect]
}

proc rcon::ConnectToServer {} {
    if {[catch {set chan [DoConnectToServer]} errMsg]} {
        set ::rcon::lastError "Failed connecting to server [::rcon::GetCurrentRconAddress] ($errMsg)"
		return -1
    }
	return $chan
}

proc rcon::ExecutorCreate {at} {
	# Create a frame for buttons and entry.
	
	frame $at.top -borderwidth 10
	pack $at.top -side top -fill x
	
	# Create a labeled entry for the command
	
	label $at.top.l -text Command: -padx 0
	entry $at.top.cmd -width 80 -relief sunken -textvariable ::rcon::executorCommand
	pack $at.top.l -side left
	pack $at.top.cmd -side left -fill x -expand true
	
	# Set up key binding equivalents to the buttons
	
	bind $at.top.cmd <Return> ExecutorRun
	#bind $at.top.cmd <Control-c> ExecutorStop
	focus $at.top.cmd
	
	# Create a text widget to log the output
	
	frame $at.t
	variable ::rcon::executorTLog $at.t.log
	#when -setgrid true is used the main window is huge in windows, disabled for now
	#variable ::rcon::executorLog [text $at.t.log -width 80 -height 15 \
	#	-borderwidth 2 -relief raised -setgrid true \
	#	-yscrollcommand [subst {$at.t.scroll set}]]
	variable ::rcon::executorLog [text $at.t.log -width 80 -height 15 \
		-borderwidth 2 -relief raised \
		-yscrollcommand [subst {$at.t.scroll set}]]
	scrollbar $at.t.scroll -command {$::rcon::executorTLog yview}
	pack $at.t.scroll -side right -fill y
	pack $at.t.log -side left -fill both -expand true
	pack $at.t -side top -fill both -expand true    
}

proc ExecutorRun {} {
	global ::rcon::executorCommand
	set chan [::rcon::ConnectToServer]
	Trace "rcon@[::rcon::GetCurrentRconAddress]> $::rcon::executorCommand"
	::rcon::TraceConsole "rcon@[::rcon::GetCurrentRconAddress]> $::rcon::executorCommand\n"
	if {$chan == -1} {
		::rcon::TraceConsole "$::rcon::lastError\n"
		return -1
	}
	if { [::rcon::Authenticate $chan] != 0 } {
		::rcon::TraceConsole "$::rcon::lastError\n"
        catch {close $chan}
		return -1
	}
	if { [::rcon::SendCommand $chan $::rcon::executorCommand] != 0 } {
		::rcon::TraceConsole "$::rcon::lastError\n"
        catch {close $chan}
		return -1
	}
	set ::rcon::executorCommand ""
	catch {close $chan}
}

