#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir browser.tcl]
source [file join $starkit::topdir tooltip.tcl]
source [file join $starkit::topdir restart.tcl]

package require Tk

proc Help {subject} {
    Browser "https://github.com/lenosisnickerboa/csgosl/wiki/Help-on-$subject"
}

proc GetDir {initialDir prompt} {
    set dir [tk_chooseDirectory -initialdir $initialDir -title $prompt -mustexist true]
    return $dir
}

proc UpdateEntryChangedStatus {w value default onChangeCmd} {
    #Weird fix needed to handle when entry is empty and value {} is returned?!?
    if {$value == "{}"} {
        set value ""
    }
    if { $onChangeCmd != "" } {
        set value [eval $onChangeCmd $value]
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
variable deleteCustomImage
proc CreateDeleteCustomImage {} {
    image create photo deleteCustomImageOrig -width 32 -height 32 -file [file join $starkit::topdir "delete.png"]
    image create photo deleteCustomImage
    deleteCustomImage copy deleteCustomImageOrig -subsample 2            
}

#args=$globalParmNameDisable $disableParmValue $disableParmValueDefault $disableParmValueHelp
proc CreateDisableButton {at controlledWidget1 controlledWidget2 disableParmsArgs} {
    if { [llength $disableParmsArgs] >= 4 } {
        set name [lindex $disableParmsArgs 0]
        set value [lindex $disableParmsArgs 1]
        set default [lindex $disableParmsArgs 2]
        set help [lindex $disableParmsArgs 3]
        global $name
        checkbutton $at.disable -anchor e -variable $name -command "UpdateCheckboxStatusAndControlledWidget $at.disable $controlledWidget1 $controlledWidget2 $name \"$default\""
        SetTooltip $at.disable "$help" 
        pack $at.disable -side right 
    } 
}

proc CreateEntry {at lead variableName default help custom disableParmsArgs onChangeCmd} {
    frame $at 
    label $at.l -width 40 -anchor w -text "$lead" -padx 0
    global $variableName
    set value [set $variableName]
    if { "$value" != "$default" } {
        entry $at.e -width 40 -relief sunken -textvariable $variableName -background lightgrey -validate key -validatecommand "UpdateEntryChangedStatus %W \"%P\" \"$default\" \"$onChangeCmd\""
    } else {
        entry $at.e -width 40 -relief sunken -textvariable $variableName -background white -validate key -validatecommand "UpdateEntryChangedStatus %W \"%P\" \"$default\" \"$onChangeCmd\""
    }
    button $at.d -image setDefaultImage -command "set $variableName \"$default\""
    SetTooltip $at.d "Set parameter to default value $default"
    pack $at.l -side left -anchor w
    SetTooltip $at.l "$help" 
    pack $at.e -side left -anchor w -fill x -expand true
    SetTooltip $at.e "$help" 
    pack $at.d -side right
    if {$custom} {
        #Removing all occurrences of this cvar in all configs, fix for now, config is not available in CreateEntry
        button $at.del -image deleteCustomImage -command "RemoveCustomCvarAll $lead"
        SetTooltip $at.del "Delete custom cvar $lead.\nYou must restart csgosl for changes to take effect."
        pack $at.del -side left -anchor w
    }
    CreateDisableButton $at $at.e $at.d $disableParmsArgs
    return $at
}

proc UpdateDirEntry {lead variableName initialDir} {
    global $variableName
    set $variableName [GetDir \"$initialDir\" \"$lead\"]
}

proc CreateDirEntry {at lead variableName default help disableParmsArgs onChangeCmd} {
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
    SetTooltip $at.d "Set parameter to default value $default"
    pack $at.l -side left
    SetTooltip $at.l "$help" 
    pack $at.e -side left -fill x -expand true
    SetTooltip $at.e "$help" 
    pack $at.gd -side left
    CreateDisableButton $at $at.e $at.d $disableParmsArgs
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

proc UpdateCheckboxStatusAndControlledWidget {w cw1 cw2 variableName default} {
    global $variableName
    set value [set $variableName]
    if { $value == "1" } {
        $cw1 configure -state normal
        $cw2 configure -state normal
    } else {
        $cw1 configure -state disabled        
        $cw2 configure -state disabled        
    }
}

proc SetCheckboxStatus {w variableName default} {
    global $variableName
    set $variableName $default
    UpdateCheckboxStatus $w $variableName $default
}

proc CreateCheckbox {at lead variableName default help disableParmsArgs onChangeCmd} {
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
    SetTooltip $at.d "Set parameter to default value $default"
    pack $at.l -side left -anchor w
    SetTooltip $at.l "$help" 
    pack $at.b -side left -anchor w -fill x -expand true
    SetTooltip $at.b "$help" 
    pack $at.d -side right
    CreateDisableButton $at $at.b $at.d $disableParmsArgs
    return $at
}

proc UpdateSelectorChangedStatus {w value default onChangeCmd} {
#    puts "UpdateSelectorChangedStatus w=$w, value=$value, default=$default"
    if { $onChangeCmd != "" } {
        set value [eval $onChangeCmd $value]
    }
    if { "$value" != "$default" } {
        ttk::style configure $w -background lightgrey
    } else {
        ttk::style configure $w -background white
    }
    return true
}

proc SetDefaultSelector {variableName default onChangeCmd} {
    global $variableName
    set $variableName $default
    if { $onChangeCmd != "" } {
        eval "$onChangeCmd \"$default\""
    }
}

proc CreateSelector {at lead variableName default help selections disableParmsArgs onChangeCmd} {
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
    bind $combo <<ComboboxSelected>> "[subst -nocommands { UpdateSelectorChangedStatus %W \"[%W get]\" \"$default\" \"$onChangeCmd\" }]"
    $at.sel configure -values $selections
    button $at.d -image setDefaultImage -command "SetDefaultSelector $variableName \"$default\" \"$onChangeCmd\""
    SetTooltip $at.d "Set parameter to default value $default"
    pack $at.l -side left
    SetTooltip $at.l "$help" 
    pack $at.sel -side left -fill x -expand true
    SetTooltip $at.sel "$help" 
    pack $at.d -side right
    CreateDisableButton $at $at.sel $at.d $disableParmsArgs
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
    button $at.update -compound top -image updateImg -text "$buttonText" -command UpdateServer
    pack $at.update -side left
	image create photo SaveImg -width $width -height $height -file [file join $starkit::topdir "save-240-120.jpg"]
    button $at.saveall -compound top -image SaveImg -text "Save all settings" -command SaveAll
    pack $at.saveall -side left
    
    image create photo restartImg -width $width -height $height -file [file join $starkit::topdir "restart-240-120.png"]
    button $at.restart -compound top -image restartImg -text "Restart csgosl" -command Restart
    pack $at.restart -side left
    
#    button $at.t -text "Run" -command StartServer
#	label $at.t -image titleImg
#	label $at.t -text "Some title"
	return $at
}

proc SetTitle {title} {
    wm title . $title
}
