#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir browser.tcl]

package require Tk

proc Help {subject} {
    Browser "http://www.google.se/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#safe=off&q=$subject"
}

proc GetDir {initialDir prompt} {
    set dir [tk_chooseDirectory -initialdir $initialDir -title $prompt -mustexist true]
    return $dir
}

proc UpdateEntryChangedStatus {w value default} {
    #Weird fix needed to handle when entry is empty and value {} is returned?!?
    if {$value == "{}"} {
        set value ""
    }
#    puts "UpdateEntryChangedStatus w=$w, value=$value, default=$default"
    if { "$value" != "$default" } {
        $w configure -background lightgrey 
    } else {
        $w configure -background white
    }
    return true
}

variable setDefaultImage
proc CreateSetDefaultImage {} {
    image create photo setDefaultImageOrig -width 32 -height 32 -file [file join $starkit::topdir "eraser.png"]
    image create photo setDefaultImage
    setDefaultImage copy setDefaultImageOrig -subsample 2            
}

proc CreateEntry {at lead variableName default} {
    frame $at 
    label $at.l -width 40 -anchor w -text "$lead" -padx 0
    global $variableName
    set value [set $variableName]
    if { "$value" != "$default" } {
        entry $at.e -width 40 -relief sunken -textvariable $variableName -background lightgrey -validate key -validatecommand "UpdateEntryChangedStatus %W \"%P\" \"$default\""
    } else {
        entry $at.e -width 40 -relief sunken -textvariable $variableName -background white -validate key -validatecommand "UpdateEntryChangedStatus %W \"%P\" \"$default\""
    }
    button $at.d -image setDefaultImage -command "set $variableName \"$default\""
    pack $at.l -side left -anchor w
    pack $at.e -side left -anchor w -fill x -expand true
    pack $at.d -side right 
    return $at
}

proc UpdateDirEntry {lead variableName initialDir} {
    global $variableName
    set $variableName [GetDir \"$initialDir\" \"$lead\"]
}

proc CreateDirEntry {at lead variableName default} {
    frame $at 
    label $at.l -width 40 -anchor w -text "$lead" -padx 0
    global $variableName
    set value [set $variableName]
    if { "$value" != "$default" } {
        entry $at.e -relief sunken -textvariable $variableName -background lightgrey -validate key -validatecommand "UpdateEntryChangedStatus %W \"%P\" \"$default\""
    } else {
        entry $at.e -relief sunken -textvariable $variableName -background white -validate key -validatecommand "UpdateEntryChangedStatus %W \"%P\" \"$default\""
    }
    set initialDirName [set $variableName]
    set initialDir $initialDirName
    button $at.gd -text "G" -command "UpdateDirEntry \"$lead\" $variableName \"$initialDir\""
    button $at.d -image setDefaultImage -command "set $variableName \"$default\""
    pack $at.l -side left
    pack $at.e -side left -fill x -expand true
    pack $at.gd -side left
    pack $at.d -side left
    return $at
}

proc UpdateCheckboxStatus {w variableName default} {
    global $variableName
    set value [set $variableName]
    if { "$value" != "$default" } {
        $w configure -background lightgrey 
    } else {
        $w configure -background white
    }
}

proc SetCheckboxStatus {w variableName default} {
    global $variableName
    set $variableName $default
    UpdateCheckboxStatus $w $variableName $default
}

proc CreateCheckbox {at lead variableName default} {
    frame $at 
    label $at.l -width 40 -anchor w -text "$lead" -padx 0
    global $variableName
    set value [set $variableName]
    if { "$value" != "$default" } {
        checkbutton $at.b -anchor w -variable $variableName -width 40 -background lightgrey -command "UpdateCheckboxStatus $at.b $variableName \"$default\""
    } else {
        checkbutton $at.b -anchor w -variable $variableName -width 40 -background white -command "UpdateCheckboxStatus $at.b $variableName \"$default\""
    }
    button $at.d -image setDefaultImage -command "SetCheckboxStatus $at.b $variableName \"$default\""
    pack $at.l -side left -anchor w
    pack $at.b -side left -anchor w -fill x -expand true
    pack $at.d -side right 
    return $at
}

proc UpdateSelectorChangedStatus {w value default} {
#    puts "UpdateSelectorChangedStatus w=$w, value=$value, default=$default"
    if { "$value" != "$default" } {
        ttk::style configure $w -background lightgrey
    } else {
        ttk::style configure $w -background white
    }
    return true
}

proc CreateSelector {at lead variableName default selections} {
    frame $at 
    label $at.l -width 40 -anchor w -text "$lead" -padx 0
    global $variableName
    set value [set $variableName]
    set combo 0
    if { "$value" != "$default" } {
        set combo [ttk::combobox $at.sel -textvariable $variableName -background lightgrey ]
    } else {
        set combo [ttk::combobox $at.sel -textvariable $variableName -background white]
    }
    bind $combo <<ComboboxSelected>> "[subst -nocommands { UpdateSelectorChangedStatus %W \"[%W get]\" \"$default\" }]"
    $at.sel configure -values $selections
    button $at.d -image setDefaultImage  -command "set $variableName \"$default\""
    pack $at.l -side left
    pack $at.sel -side left -fill x -expand true
    pack $at.d -side left
    return $at
}

proc Separator {at} {
    return [ttk::separator $at]
 }

proc CreateWindow { geometry name version } {
#    wm minsize . 800 600
    wm geometry . $geometry
    wm title . "$name $version"
}

proc CreateStatus { at statusName currentDirName ipAddressName } {
    frame $at
    label $at.status -textvariable $statusName -relief sunken -padx 5 
    grid $at.status -row 0 -column 1 
    label $at.dir -textvariable $currentDirName -relief sunken -padx 5
    grid $at.dir -row 0 -column 2
    label $at.ip -textvariable $ipAddressName -relief sunken -padx 5 
    grid $at.ip -row 0 -column 3    
    return $at
}

proc CreateTitle {at startButtonEnabled} {
    global serverPresent
    set width 240
    set height 120
    image create photo titleImg -width $width -height $height -file [file join $starkit::topdir "run-240-120.jpg"]
    button $at.startstop -compound top -image titleImg -text "Start server" -command StartServer
    if  {! $startButtonEnabled} {
        $at.startstop configure -state disabled
    }
    pack $at.startstop -side left
	image create photo updateImg -width $width -height $height -file [file join $starkit::topdir "install-update-240-120.jpg"]
    set buttonText "Update server"
    if { !$serverPresent } {
        set buttonText "Install server"
    }
    button $at.u -compound top -image updateImg -text "$buttonText" -command UpdateServer
    pack $at.u -side left
	image create photo SaveImg -width $width -height $height -file [file join $starkit::topdir "save-240-120.jpg"]
    button $at.s -compound top -image SaveImg -text "Save all settings" -command SaveAll
    pack $at.s -side left
#    button $at.t -text "Run" -command StartServer
#	label $at.t -image titleImg
#	label $at.t -text "Some title"
	return $at
}

proc SetTitle {title} {
    wm title . $title
}
