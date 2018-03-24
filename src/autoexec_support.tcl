#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir config_file.tcl]

namespace eval autoexec {
	variable dummy ""
}

proc autoexec::InitializeDirs {} {
	global serverCfgPath
	set autoexecDir "$serverCfgPath/csgosl"
	#Trace "Initializing autoexec dirs in $autoexecDir"
	if { ! [file isdirectory "$autoexecDir"]} {
		file mkdir "$autoexecDir"
	}
	if { ! [file isdirectory "$autoexecDir/onserverstart"]} {
		file mkdir "$autoexecDir/onserverstart"
	}
	if { ! [file isdirectory "$autoexecDir/onmapchange"]} {
		file mkdir "$autoexecDir/onmapchange"
	}
}

proc autoexec::BuildVars {} {
	global serverCfgPath
	set autoexecDir "$serverCfgPath/csgosl"
	
	# Read config files
	set onServerStartCfgs [glob -nocomplain -tails -type f -path "$autoexecDir/onserverstart/" *.cfg]
	set onServerStartCfgs [lsort [string map {. _} $onServerStartCfgs]]

	#Trace "Found onServerStartCfgs=$onServerStartCfgs"
	set onMapChangeCfgs [glob -nocomplain -tails -type f -path "$autoexecDir/onmapchange/" *.cfg]
	set onMapChangeCfgs [lsort [string map {. _} $onMapChangeCfgs]]
	#Trace "Found onMapChangeCfgs=$onMapChangeCfgs"
	
	# Build config
	global autoexecConfigList1
	global autoexecConfigList2
	foreach cfg $onServerStartCfgs {
		lappend autoexecConfigList2 "bool" [list onserverstart_$cfg "0" "Execute $cfg when server starts"]
	}
	foreach cfg $onMapChangeCfgs {
		lappend autoexecConfigList2 "bool" [list onmapchange_$cfg "0" "Execute $cfg when map is changed"]
	}
	
	global autoexecConfig
	set autoexecConfig [CreateConfig $autoexecConfigList1 $autoexecConfigList2]
	
	# Build layout
	global autoexecLayoutList1
	global autoexecLayoutList2
	lappend autoexecLayoutList2 \
		h1      [list "Autoexec settings"] \
        line    [list] \
		text    [list "Add .cfg files to the folders shown below to have them automatically executed when server"] \
		text    [list "starts or when map change occurs."] \
        space   [list] \
        h2      [list "On server start execute these..."] \
		text    [list "- folder $autoexecDir/onserverstart:"] \
        line    [list] \
        space   [list]
	foreach cfg $onServerStartCfgs {
		lappend autoexecLayoutList2  parm [list onserverstart_$cfg] 
	}
	lappend autoexecLayoutList2 \
		space   [list] \
        h2      [list "On map change execute these..."] \
		text    [list "- folder $autoexecDir/onmapchange:"] \
        line    [list] \
        space   [list]
	foreach cfg $onMapChangeCfgs {
		lappend autoexecLayoutList2  parm [list onmapchange_$cfg] 
	}
	
	global autoexecLayout
	set autoexecLayout [CreateLayout $autoexecLayoutList1 $autoexecLayoutList2]
}

 proc autoexec::Save {} {
	global serverCfgPath
	set autoexecDir "$serverCfgPath/csgosl"	
	set onServerStartCfgs [glob -nocomplain -tails -type f -path "$autoexecDir/onserverstart/" *.cfg]
	set onServerStartCfgsMangled [lsort [string map {. _} $onServerStartCfgs]]
	set onMapChangeCfgs [glob -nocomplain -tails -type f -path "$autoexecDir/onmapchange/" *.cfg]
	set onMapChangeCfgsMangled [lsort [string map {. _} $onMapChangeCfgs]]

	global autoexecConfig
    set values [dict get $autoexecConfig values]
	
	set fileName "$autoexecDir/execonserverstart.cfg"
    set fileId [open $fileName "w"]
    StoreHeader $fileId
	foreach {key} $onServerStartCfgs {
		set keyMangled [string map {. _} $key]
		set enabled [dict get $values onserverstart_$keyMangled]
		if { $enabled } {
			puts $fileId "exec csgosl/onserverstart/$key"
		}
	}
    close $fileId
	
	set fileName "$autoexecDir/execonmapchange.cfg"
    set fileId [open $fileName "w"]
    StoreHeader $fileId
	foreach {key} $onMapChangeCfgs {
		set keyMangled [string map {. _} $key]
		set enabled [dict get $values onmapchange_$keyMangled]
		if { $enabled } {
			puts $fileId "exec csgosl/onmapchange/$key"
		}
	}
    close $fileId
}

proc autoexec::Activate {} {
	global serverCfgPath
	AddCfgFileLine "$serverCfgPath/autoexec.cfg" "exec csgosl/execonserverstart.cfg"
	AddCfgFileLine "$serverCfgPath/server.cfg" "exec csgosl/execonmapchange.cfg"
}
