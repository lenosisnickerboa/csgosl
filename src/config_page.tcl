#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir widgets.tcl]
source [file join $starkit::topdir hyperlink.tcl]
source [file join $starkit::topdir config_file.tcl]
source [file join $starkit::topdir browser.tcl]
source [file join $starkit::topdir tooltip.tcl]
source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir openfolder.tcl]

proc Shift {parms} {
    return [lreplace $parms 0  0]
}

proc GetGlobalConfigVariableName {name item} {
    return GlobalConfig$name$item
}

proc GetConfigPageSelectorWidget {page key} {
    set items [sframe content $page.scrollableitems]
    return $items.w$key.sel
}

proc CreateConfigPageTabFromLayout {at layout enabled} {
    set pageOptions [dict get $layout options]
    set tabName [dict get $pageOptions tabName]
    frame $at -borderwidth 10
    [winfo parent $at] add $at -text "$tabName"
    if {$enabled == 0} {
        [winfo parent $at] hide $at
    }
    return $at
}

proc CreateConfigPageFunc {at help layout parms} {
    set func [lindex $parms 0]
    #custom funcs do their own packing
    $func $at $help $layout [Shift $parms]
}

proc CreateConfigPageH1 {at parms} {
    set text [lindex $parms 0]
    pack [label $at -text "$text" -anchor w -font {-size -18 -weight bold}] -side top -fill x -expand true
}

proc CreateConfigPageActions {at parms} {
    frame $at
    foreach button $parms {
        set btype [lindex $button 0]
        set bname [lindex $button 1]
        set btext [lindex $button 2]
        if {$btype == "text"} {
            pack [label $at.l$bname -anchor w -text "$btext" -padx 0 -pady 2] -side left -anchor w
        } else {
            set bfunc [lindex $button 3]
            set bhelp [lindex $button 4]
            if {$btype == "push"} {
                pack [button $at.b$bname -text "$btext" -command $bfunc -padx 2 -pady 2] -side left -anchor w
                SetTooltip $at.b$bname "$bhelp"
            } elseif {$btype == "entry"} {
                set bvariablename [lindex $button 5]
                pack [label $at.l$bname -anchor w -text "$btext" -padx 0 -pady 2] -side left -anchor w
                pack [entry $at.e$bname -relief sunken -textvariable $bvariablename -background white] -side left -anchor w
                SetTooltip $at.e$bname "$bhelp"
                global $bvariablename
                bind $at.e$bname <Return> [subst "$bfunc \\$$bvariablename"]
            }
        }
    }
    pack $at -side top -fill x -expand true
}

proc CreateConfigPageH2 {at parms} {
    set text [lindex $parms 0]
    pack [label $at -text "$text" -anchor w -font {-size -14 -weight bold}] -side top -fill x -expand true
}

proc CreateConfigPageText {at parms} {
    set text [lindex $parms 0]
    pack [label $at -text "$text" -anchor w] -side top -fill x -expand true
}

proc CreateConfigPageWarning {at parms} {
    set text [lindex $parms 0]
    pack [label $at -text "$text" -anchor w  -foreground red] -side top -fill x -expand true
}

proc CreateConfigPageLine {at parms} {
    pack [frame $at -relief groove -borderwidth 2 -width 2 -height 2] -fill x
}

proc CreateConfigPageSpace {at parms} {
    pack [label $at -text " " -anchor w] -side top -fill x -expand true
}

proc CreateConfigPageUrl {at parms} {
    set text [join [lindex $parms 0]]
    set url [join [lindex $parms 1]]
    pack [Hyperlink $at -command [list Browser "$url"] -text "$text"] -side top -fill x -expand true
}

proc CreateConfigPageItem {at lead name value type default help selections custom disableParmsArgs onChangeCmd} {
    if {$type == "directory"} {
        pack [CreateDirEntry $at $lead $name $default $help $disableParmsArgs $onChangeCmd] -side top -fill x -expand true
    } elseif {$type == "url"} {
        pack [CreateEntry $at $lead $name $default $help $custom $disableParmsArgs $onChangeCmd] -side top -fill x -expand true
    } elseif {$type == "int"} {
        pack [CreateEntry $at $lead $name $default $help $custom $disableParmsArgs $onChangeCmd] -side top -fill x -expand true
    } elseif {$type == "bool"} {
        pack [CreateCheckbox $at $lead $name $default $help $disableParmsArgs $onChangeCmd] -side top -fill x -expand true
    } elseif {$type == "enum"} {
        pack [CreateSelector $at $lead $name $default $help $selections $disableParmsArgs $onChangeCmd] -side top -fill x -expand true
    } elseif {$type != "line"} {
        pack [CreateEntry $at $lead $name $default $help $custom $disableParmsArgs $onChangeCmd] -side top -fill x -expand true
    }
}

proc NewCvar {configName} {
    global NewCvarName NewCvarDefault NewCvarHelp
    set NewCvarName ""
    set NewCvarDefault ""
    set NewCvarHelp ""
    set w [toplevel .$configName]
    wm resizable $w 0 0
    wm title $w "Add new cvar"
#    label  $w.l -text $string
    label $w.lname -text "Name:"
    entry $w.name -textvar NewCvarName -bg white
    label $w.ldefault -text "Default value:"
    entry $w.default -textvar NewCvarDefault -bg white
    label $w.lhelp -text "Help text:"
    entry $w.help -textvar NewCvarHelp -bg white
    bind $w.name <Return> {set done 1}
    bind $w.name <Escape> {set NewCvarName {}; set done 1}
    bind $w.default <Return> {set done 1}
    bind $w.default <Escape> {set NewCvarName {}; set done 1}
    bind $w.help <Return> {set done 1}
    bind $w.help <Escape> {set NewCvarName {}; set done 1}
    button $w.ok     -text OK     -command {set done 1}
    button $w.cancel -text Cancel -command "set NewCvarName {}; set done 1"
    grid $w.lname    $w.name    - -sticky news
    grid $w.ldefault $w.default - -sticky news
    grid $w.lhelp $w.help       - -sticky news
    label $w.ldummy
    grid $w.ldummy $w.ok $w.cancel -sticky news
    set x [expr {([winfo width  .] - [winfo reqwidth  $w]) / 2 + [winfo rootx .]}]
    set y [expr {([winfo height .] - [winfo reqheight $w]) / 2 + [winfo rooty .]}]
    wm geometry $w +$x+$y
    raise $w
    focus $w.name
    grab $w
    vwait done
    grab release $w
    destroy $w
    if { $NewCvarName != "" } {
        AddNewCustomCvar $configName $NewCvarName "$NewCvarDefault" "$NewCvarHelp"
    }
}

proc CreateConfigPageItemFromLayout {layout page type args widgetIx} {
    set pageOptions [dict get $layout options]
    set help [dict get $pageOptions help]
    set configName [dict get $pageOptions configName]
    global $configName
    set config [set $configName]
    global DisableParmPrefix
    global fullConfigEnabled
    set parmValues [dict get $config values]
    set meta [dict get $config meta]

    if {$type == "parm"} {
        set parmName [join [lindex $args 0]]
        set metaItem [dict get $meta $parmName]
        set custom [dict exists $metaItem custom]
        set prefix [dict get $config prefix]
        set parmValue [dict get $parmValues $parmName]
        set globalParmName [GetGlobalConfigVariableName $prefix $parmName]
        global $globalParmName
        set $globalParmName $parmValue
        set parmType [dict get $metaItem type]
        set help [dict get $metaItem help]
        set parmDefault [dict get $metaItem default]
        set selections [list]
        if {$parmType == "enum"} {
            set selections [dict get $metaItem selections]
        }
        set disableParmName "$DisableParmPrefix$parmName"
        set disableParmValue ""
        set disableParmValueDefault ""
        set disableParmValueHelp ""
        set globalParmNameDisable ""
        set disableParmArgs [list]
        if { [dict exists $metaItem mappedto] } {
            set globalParmNameDisable [GetGlobalConfigVariableName $prefix $disableParmName]
            global $globalParmNameDisable
            set disableParmValue [dict get $parmValues $disableParmName]
            if { $fullConfigEnabled == "0" } {
                set disableParmValue 1
            }
            set $globalParmNameDisable $disableParmValue
            set disableParmMetaItem [dict get $meta $disableParmName]
            set disableParmValueDefault [dict get $disableParmMetaItem default]
            set disableParmValueHelp [dict get $disableParmMetaItem help]
            set disableParmArgs [list "$globalParmNameDisable" "$disableParmValue" "$disableParmValueDefault" "$disableParmValueHelp" ]
            if { $fullConfigEnabled == "0" } {
                set disableParmArgs [list]
            }
        }
        set onchangeCmd ""
        if { [dict exists $metaItem onchange] } {
            set onchangeCmd [dict get $metaItem onchange]
        }
        CreateConfigPageItem $page.w$parmName $parmName $globalParmName $parmValue $parmType $parmDefault $help $selections $custom $disableParmArgs $onchangeCmd
    } elseif {$type == "func"} {
        CreateConfigPageFunc $page.func$widgetIx $help $layout $args
    } elseif {$type == "buttons"} {
        CreateConfigPageActions $page.func$widgetIx $args
    } elseif {$type == "h1"} {
        CreateConfigPageH1 $page.h1$widgetIx $args
    } elseif {$type == "h2"} {
        CreateConfigPageH2 $page.h2$widgetIx $args
    } elseif {$type == "url"} {
        CreateConfigPageUrl $page.url$widgetIx $args
    } elseif {$type == "text"} {
        CreateConfigPageText $page.h2$widgetIx $args
    } elseif {$type == "warning"} {
        CreateConfigPageWarning $page.h2$widgetIx $args
    } elseif {$type == "line"} {
        CreateConfigPageLine $page.line$widgetIx $args
    } elseif {$type == "space"} {
        CreateConfigPageSpace $page.space$widgetIx $args
    }
}

proc PerformOnChangeOnConfigPageParm {layout page type args widgetIx} {
    set pageOptions [dict get $layout options]
    set configName [dict get $pageOptions configName]
    global $configName
    set config [set $configName]
    set meta [dict get $config meta]
    set parmName [join [lindex $args 0]]
    set metaItem [dict get $meta $parmName]
    if { [dict exists $metaItem onchange] } {
        set onchangeCmd [dict get $metaItem onchange]
        if {$onchangeCmd != ""} {
            set parmValues [dict get $config values]
            set parmValue [dict get $parmValues $parmName]
            eval "$onchangeCmd" "$parmValue"
        }
    }
}

proc Donate {} {
    global currentOs
    if {$currentOs == "windows"} {
        Browser {https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=NESCKT8B4C638}
    } else {
        Browser "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=NESCKT8B4C638"
    }
}

proc CreateConfigPageFromLayout {at layout} {
    set pageOptions [dict get $layout options]
    set components [dict get $layout components]
    set configName [dict get $pageOptions configName]
    global $configName
    set config [set $configName]

    sframe new $at.scrollableitems -anchor n -scrolly yes -scrollx no
    set page [sframe content $at.scrollableitems]

    set help [dict get $pageOptions help]
    bind $page <F1> [subst "Help $help" ]

    frame $page.buttons
    if { [dict exists $config addCVar] } {
        pack [button $page.buttons.newoption -text "New cvar..." -anchor e -font {-size -10} -command [subst "NewCvar $configName"]] -side left
        SetTooltip $page.buttons.newoption "Create a custom cvar entry on this page.\nA csgosl restart is required for changes to take effect."
    }
    pack [button $page.buttons.setdefault -text "Set defaults" -anchor e -font {-size -10} -command [subst "SetDefaults $configName"]] -side left
    SetTooltip $page.buttons.setdefault "Sets all options on this tab to default values.\ncsgosl will be automatically restarted."
    pack [button $page.buttons.helphint -text "Help on $help (F1)" -anchor e -font {-size -10} -command [subst "Help $help"]] -side left
    SetTooltip $page.buttons.helphint "Opens up the wiki help page for this tab"

    global applicationConfig
    set showDonation [GetConfigValue $applicationConfig showdonation]
    if {$showDonation} {
        image create photo donateImg -file [file join $starkit::topdir "donate.png"]
        pack [button $page.buttons.donate -image donateImg -anchor e -command Donate] -side left
        SetTooltip $page.buttons.donate "If you feel this software served you well and saved you a lot of time you could spend enjoying yourself instead of reading\nendless forum threads on how to setup your own server just right, why not show your appreciation and donate whatever\namount you feel appropriate. Your appreciation is much appreciated :)\nWill open Paypal in your default web browser.\This donation button can be disabled in application settings."
    }

    pack $page.buttons -side top -anchor e

    set widgetIx 0
    foreach {type args} $components {
        CreateConfigPageItemFromLayout $layout $page $type $args $widgetIx
        incr widgetIx
    }
    pack $at.scrollableitems -side top -anchor nw -fill both -expand true
    return $at
}

proc PerformOnChangeOnLayout {at layout} {
    set components [dict get $layout components]
    set page [sframe content $at.scrollableitems]
    set widgetIx 0
    foreach {type args} $components {
        if {$type == "parm"} {
            PerformOnChangeOnConfigPageParm $layout $page $type $args $widgetIx
        }
        incr widgetIx
    }
}

proc SetConfigItemState {at layout item state} {
    set page [sframe content $at.scrollableitems]
    set components [dict get $layout components]
    set widgetIx 0
    foreach {type args} $components {
        if {$type == "parm"} {
            set parmName [join [lindex $args 0]]
            if {$parmName ==  $item} {
                SetWidgetState $page.w$parmName $state
                return 0
            }
        }
        incr widgetIx
    }
}

variable SelectedMapName 
variable SelectedMapType
variable SelectedMapId
variable SelectedMapPreviewUrl

proc RefreshMaps {} {
    global allMaps
    global MapCountVariable
    Trace "Refreshing all maps..."
    LoadMaps
    set MapCountVariable "Number of maps: [llength $allMaps]"
    UpdateRunPage
    global mapsListBox
    global mapGroupListBox
    global mapsListBoxMultiSelect
    SetSelectedMap $mapsListBox 
    SetSelectedMapGroup $mapGroupListBox $mapsListBoxMultiSelect
}

proc LoadPreview {} {
    global SelectedMapPreviewUrl
    global SelectedMapName
    global SelectedMapType
    global SelectedMapId
    
    if { "$SelectedMapPreviewUrl" != "" } {
        LoadMapPreview "$SelectedMapPreviewUrl" "$SelectedMapName" "$SelectedMapType" "$SelectedMapId"
        UpdateSelectedMapPreview
    }
}

proc CreateSelectedMapName {at} {
    frame $at 
    global SelectedMapName
    label $at.e -width 40 -relief sunken -background lightgrey -textvariable SelectedMapName
    pack $at.e -side left -anchor w -fill x -expand true
    return $at
}

proc CreateSelectedMapType {at} {
    frame $at
    global SelectedMapType
    label $at.e -width 40 -relief sunken -background lightgrey -textvariable SelectedMapType
    pack $at.e -side left -anchor w -fill x -expand true
    return $at
}

proc OpenWorkshopFolder {} {
    global serverFolder
    global SelectedMapId
    if { $SelectedMapId != "" } {
        OpenFolder "$serverFolder/csgo/maps/workshop/$SelectedMapId"
    } else {
        tk_dialog .myDialog "Will not open folder" "This is not a workshop map" "" 0 "OK"
    }
}

proc CreateSelectedMapId {at} {
    frame $at
    global SelectedMapId
    label $at.e -width 40 -relief sunken -background lightgrey -textvariable SelectedMapId
    pack $at.e -side left -anchor w -fill x -expand true
    button $at.d -image folderImage -command "OpenWorkshopFolder"
    SetTooltip $at.d "Will open file explorer where this map is stored to allow you to inspect and potentially delete it."
    pack $at.d -side right
    return $at
}

proc CreateSelectedMapPreviewUrl {at} {
    frame $at 
    global SelectedMapPreviewUrl
    entry $at.e -width 40 -relief sunken -textvariable SelectedMapPreviewUrl -background white
    set help "Enter a URL to a JPG picture you want to use as preview for this map and click load button"
    SetTooltip $at.e "$help"
    button $at.d -image reloadImage -command "LoadPreview"
    SetTooltip $at.d "Will attempt to load a preview picture using this URL"
    pack $at.e -side left -anchor w -fill x -expand true -padx 0
    pack $at.d -side right
    return $at
}

variable mapButtonImgSelectedMap

proc UpdateSelectedMapPreview {} {
    global installFolder
    global SelectedMapName
    global mapButtonImgSelectedMap
    set cachedFile "$installFolder/maps/cached/$SelectedMapName.jpg"
    if { ! [file exists "$cachedFile" ] } {
        set cachedFile [file join $starkit::topdir "no_map_picture.jpg"]
    }
    image create photo mapButtonImgSelectedMap -file "$cachedFile"
}

proc CreateSelectedMapPreview {at} {
    global mapButtonImgSelectedMap
    frame $at
    UpdateSelectedMapPreview
    set width 320
    set height 256
    label $at.preview -text "" -image mapButtonImgSelectedMap -compound bottom -width $width -height $height
    pack $at.preview -side top -anchor e
    return $at
}

proc SetSelectedMap {lb} {
    global allMaps
    global allMapsMeta
    global SelectedMapName
    global SelectedMapType
    global SelectedMapId
    global SelectedMapPreviewUrl
    
    set SelectedMapName [lindex $allMaps [$lb curselection]]
    set SelectedMapType "?"
    if { [dict exists $allMapsMeta $SelectedMapName] } {
        set mapMeta [dict get $allMapsMeta $SelectedMapName]
        set SelectedMapType [dict get $mapMeta type]
        set SelectedMapId ""
        if {[dict exists $mapMeta id]} {
            set SelectedMapId [dict get $mapMeta id]
        }
    }
    UpdateSelectedMapPreview
    set SelectedMapPreviewUrl ""
}

variable MapCountVariable "?"
variable mapsListBox
proc LayoutFuncMaps {at help layout parms} {
    global allMaps
    global MapCountVariable

    frame $at
    
    frame $at.maps
    pack $at.maps -side left -fill both -expand true

    frame $at.maps.lbframe
    #-exportselection 0 -> listbox does not lose selection when something is selected in the entry widget (weird)
    global mapsListBox
    set mapsListBox [tk::listbox $at.maps.lbframe.listbox -listvariable allMaps -height 15 -width 40 -activestyle none -exportselection 0]
    pack $mapsListBox -side left
    pack [ttk::scrollbar $at.maps.lbframe.sb -command "$at.maps.lbframe.listbox yview" -orient vertical] -side left -fill y -expand true
    $at.maps.lbframe.listbox configure -yscrollcommand "$at.maps.lbframe.sb set"
    $mapsListBox select set 0
    bind $mapsListBox <<ListboxSelect>> "SetSelectedMap %W"
    pack $at.maps.lbframe -side top

    set MapCountVariable "Number of maps: [llength $allMaps]"
    label $at.maps.mapcount -textvariable MapCountVariable
    pack $at.maps.mapcount -side top -anchor w
    
    button $at.maps.refresh -text "Refresh maps" -command "RefreshMaps"
    pack $at.maps.refresh -side top -anchor w
    
    frame $at.map
    pack $at.map -side right -fill both -expand true -padx 20
            
    pack [CreateSelectedMapName $at.map.name] -side top -fill x
    pack [CreateSelectedMapType $at.map.id] -side top -fill x
    pack [CreateSelectedMapId $at.map.type] -side top -fill x
    pack [CreateSelectedMapPreviewUrl $at.map.previewurl] -side top -fill x
    pack [CreateSelectedMapPreview $at.map.preview] -side top -fill x
        
    SetSelectedMap $mapsListBox
    
    pack $at -side top -fill both -expand true
    
    return $at
}

proc LayoutFuncSetDefaultsAll {at help layout parms} {
    pack [button $at -text "Set all defaults -- WARNING resets all settings to defaults" -anchor e -font {-size -8} -command [subst "SetDefaultsAll"]] -side left
}

proc UpdateRunPage {} {
    global runPage
    global mapGroupsMapper
    set mapGroupsSel [GetConfigPageSelectorWidget $runPage mapgroup]
    set values [lsort [dict keys $mapGroupsMapper]]
    $mapGroupsSel configure -values $values
    set mapGroupName [GetGlobalConfigVariableName Run mapgroup]
    global $mapGroupName
    # This is the selected map group
    set mapGroup [set $mapGroupName]
    # See if we should autoselect a map group from gamemodetype
    set autoMapGroupName [GetGlobalConfigVariableName Run automapgroup]
    global $autoMapGroupName
    set autoMapGroup [set $autoMapGroupName]
    if { "$autoMapGroup" == "1" } {
        set gameModeTypeName [GetGlobalConfigVariableName Run gamemodetype]
        global $gameModeTypeName
        set gameModeType [set $gameModeTypeName]
        set autoSelectedMapGroup [string map {" " ""} "auto_$gameModeType"]
        if { "$autoSelectedMapGroup" != "$mapGroup" } {
            if { [lsearch -exact $values $autoSelectedMapGroup] != -1 } {
                # Now this is the selected map group
                set mapGroup $autoSelectedMapGroup
                set $mapGroupName $mapGroup
            }
        }
    }
    if { [lsearch -exact $values $mapGroup] == -1 } {
        set mapGroup [lindex $values 0]
        set $mapGroupName $mapGroup
    }
    set startMapName [GetGlobalConfigVariableName Run startmap]
    global $startMapName
    set startMap [set $startMapName]
    if { $mapGroup == "<allmaps>" } {
        global allMaps
        set maps $allMaps
    } else {
        set maps [lsort [dict get $mapGroupsMapper $mapGroup]]
    }
    set mapStartMapSel [GetConfigPageSelectorWidget $runPage startmap]
    $mapStartMapSel configure -values $maps
    if { [lsearch -exact $maps $startMap] == -1 } {
        set $startMapName [lindex $maps 0]
    }
}

proc FixMapGroupName { name } {
    set name [regsub -all {\-+} $name "_"]
    set name [regsub -all {\s+} $name "_"]
    return $name
}

proc ValidateMapGroupsMapper {} {
    global mapGroupsMapper
    global allMaps
    if { ! [info exists mapGroupsMapper] } {
        return
    }
    dict for {mapGroup maps} $mapGroupsMapper {
        foreach map $maps {
            if { [lsearch -exact -sorted $allMaps $map] == -1 } {
                Trace "Map $map no longer exists, will be removed from mapgroup $mapGroup"
                set oldMaps [dict get $mapGroupsMapper $mapGroup]
            	set mapGroupsMapper [dict remove $mapGroupsMapper $mapGroup]
                set idx [lsearch -exact -sorted $oldMaps $map]
                set newMaps [lreplace $oldMaps $idx $idx]                
                set mapGroupsMapper [dict set mapGroupsMapper $mapGroup $newMaps]
            }
        }
    }
}

proc GetSelectedMapGroup {lbMapGroups} {
    global mapGroupsMapper
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set mapGroups [set $mapGroupsName]
    return [lindex $mapGroups [$lbMapGroups curselection]]
}

proc GetSelectedMaps {lbMaps} {
    global allMaps
    set selectedMaps {}
    foreach mapIx [$lbMaps curselection] {
        lappend selectedMaps [lindex $allMaps $mapIx]
    }
    return $selectedMaps
}

proc GetMapsFromSelectedMapGroup {mapGroup} {
    if { "$mapGroup" == "" } {
        return ""
    }
    global mapGroupsMapper
    return [dict get $mapGroupsMapper $mapGroup]
}

proc SetSelectedInListbox {lb ix} {
    $lb selection clear 0 end
    if { $ix + 1 >= [$lb size] }  {
        set ix end
    }
    $lb select set $ix
    $lb see $ix
}

#Source:https://wiki.tcl-lang.org/page/Another+little+value+dialog
 proc tk_getStringAlternate {w var title text} {
    variable ::tk::Priv
    upvar $var result
    catch {destroy $w}
    set focus [focus]
    set grab [grab current .]

    toplevel $w -bd 1 -relief raised -class TkSDialog
    wm title $w $title
    wm iconname  $w $title
    wm protocol  $w WM_DELETE_WINDOW {set ::tk::Priv(button) 0}
    wm transient $w [winfo toplevel [winfo parent $w]]

    entry  $w.entry -width 20
    button $w.ok -bd 1 -width 5 -text Ok -default active -command {set ::tk::Priv(button) 1}
    button $w.cancel -bd 1 -text Cancel -command {set ::tk::Priv(button) 0}
    label  $w.label -text $text

    grid $w.label -columnspan 2 -sticky ew -padx 3 -pady 3
    grid $w.entry -columnspan 2 -sticky ew -padx 3 -pady 3
    grid $w.ok $w.cancel -padx 3 -pady 3
    grid rowconfigure $w 2 -weight 1
    grid columnconfigure $w {0 1} -uniform 1 -weight 1

    bind $w <Return>  {set ::tk::Priv(button) 1}
    bind $w <Destroy> {set ::tk::Priv(button) 0}
    bind $w <Escape>  {set ::tk::Priv(button) 0}

    wm withdraw $w
    update idletasks
    focus $w.entry
    # My mod, make dialog appear centered on mainwindow, on multi-monitor setups as well
#original    set x [expr {[winfo screenwidth  $w]/2 - [winfo reqwidth  $w]/2 - [winfo vrootx $w]}]
#original    set y [expr {[winfo screenheight $w]/2 - [winfo reqheight $w]/2 - [winfo vrooty $w]}]
    set parentx [winfo rootx .]
    set parentw [winfo width .]
    set parenty [winfo rooty .]
    set parenth [winfo height .]
    set childw [winfo reqwidth $w]
    set childh [winfo reqheight $w]
    set x [expr $parentx + $parentw / 2 - $childw / 2]
    set y [expr $parenty + $parenth / 2 - $childh / 2]
    # End of my mod
    wm geom $w +$x+$y
    wm deiconify $w
    grab $w

    tkwait variable ::tk::Priv(button)
    set result [$w.entry get]
    bind $w <Destroy> {}
    grab release $w
    destroy $w
    focus -force $focus
    if {$grab != ""} {grab $grab}
    update idletasks
    return $::tk::Priv(button)
 }

proc AddMapGroup {lb lbMaps} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    global mapGroupsMapper
    set addMapGroupName ""
    if {[tk_getStringAlternate .valueDlg addMapGroupName "Add new mapgroup XXX" "Please enter a new mapgroup name" ]} {
        if { $addMapGroupName != "" && $addMapGroupName != "<allmaps>" } {
            set addMapGroupName [FixMapGroupName $addMapGroupName]
            if { ! [dict exists $mapGroupsMapper $addMapGroupName] } {
                $lb insert end "$addMapGroupName"
                set mapGroupsMapper [dict set mapGroupsMapper $addMapGroupName [list]]
                set $mapGroupsName [lsearch -all -inline -not -exact [lsort [dict keys $mapGroupsMapper]] "<allmaps>"]
                set mapGroups [set $mapGroupsName]
                set newIx [lsearch -exact -sorted $mapGroups $addMapGroupName]
                SetSelectedInListbox $lb $newIx
                SetSelectedMapGroup $lb $lbMaps
                global MapGroupCountVariable
                set MapGroupCountVariable "Number of maps groups: [llength $mapGroupsName]"
                UpdateRunPage
            } else {
                tk_messageBox -message "Mapgroup name $addMapGroupName already exists!" -icon info -type ok -parent .
            }
        }
    }
}

proc DeleteMapGroup {lb lbMaps} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    global mapGroupsMapper
    set mapGroups [set $mapGroupsName]
    set idx [$lb curselection]
    if { $idx >= 0 } {
    	set sel [lindex $mapGroups $idx]
    	$lb delete $idx
    	set mapGroupsMapper [dict remove $mapGroupsMapper $sel]
        SetSelectedInListbox $lb $idx
        SetSelectedMapGroup $lb $lbMaps
        global MapGroupCountVariable
        set MapGroupCountVariable "Number of maps groups: [llength $mapGroupsName]"
    	UpdateRunPage
    }
}

variable RenameMapGroupNewName 

proc RenameMapGroup {lb lbMaps} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    global mapGroupsMapper
    set mapGroups [set $mapGroupsName]
    set idx [$lb curselection]
    if { $idx >= 0 } {
        #copy from selected
    	set sel [lindex $mapGroups $idx]
        global RenameMapGroupNewName
        set RenameMapGroupNewName $sel
        if {[tk_getString .valueDlg RenameMapGroupNewName "Rename map group" "Please enter a new mapgroup name"]} {
            set RenameMapGroupNewName [FixMapGroupName $RenameMapGroupNewName]
            if { "$RenameMapGroupNewName" != "$sel" } {
                set source [dict get $mapGroupsMapper $sel]
                #replace
                set addMapGroupName [FixMapGroupName $RenameMapGroupNewName]
                $lb delete $idx
            	set mapGroupsMapper [dict remove $mapGroupsMapper $sel]
                $lb insert end "$addMapGroupName"
                set mapGroupsMapper [dict set mapGroupsMapper $addMapGroupName $source]
                set $mapGroupsName [lsearch -all -inline -not -exact [lsort [dict keys $mapGroupsMapper]] "<allmaps>"]
                set mapGroups [set $mapGroupsName]
                set newIx [lsearch -exact -sorted $mapGroups $RenameMapGroupNewName]
                SetSelectedInListbox $lb $newIx
                SetSelectedMapGroup $lb $lbMaps
                #update
            	UpdateRunPage
            }
        }
    }
}

proc CopyMapGroup {lb lbMaps} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    global mapGroupsMapper
    set mapGroups [set $mapGroupsName]
    set idx [$lb curselection]
    if { $idx >= 0 } {
        #copy from selected
    	set sel [lindex $mapGroups $idx]
        set copied "${sel}_copy"
        set source [dict get $mapGroupsMapper $sel]
        #add copy
        set addMapGroupName [FixMapGroupName $copied]
        $lb insert end "$addMapGroupName"
        set mapGroupsMapper [dict set mapGroupsMapper $addMapGroupName $source]
        set $mapGroupsName [lsearch -all -inline -not -exact [lsort [dict keys $mapGroupsMapper]] "<allmaps>"]
        set mapGroups [set $mapGroupsName]
        set newIx [lsearch -exact -sorted $mapGroups $addMapGroupName]
        SetSelectedInListbox $lb $newIx
        SetSelectedMapGroup $lb $lbMaps
        #update
        global MapGroupCountVariable
        set MapGroupCountVariable "Number of maps groups: [llength $mapGroupsName]"
    	UpdateRunPage
    }
}

proc SetSelectedMapGroup {lbMapGroups lbMaps} {
    global mapGroupsMapper
    global allMaps
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set mapGroups [set $mapGroupsName]
    set sel [lindex $mapGroups [$lbMapGroups curselection]]
    if { "$sel" == "" } {
        return
    }
    set includedMaps [dict get $mapGroupsMapper $sel]
    set seeIx 0
    set ix 0
    $lbMaps selection clear 0 end
    foreach map $includedMaps {
        set ix [lsearch -exact -sorted $allMaps $map]
        if {$seeIx == 0} {
            set seeIx $ix
        }
        $lbMaps selection set $ix $ix
    }
    $lbMaps see $seeIx
    global SelectedMapCountVariable
    set SelectedMapCountVariable "Number of selected maps: [llength $includedMaps]/[llength $allMaps]"

    set selectedMapGroupIx [$lbMapGroups curselection]
    $lbMapGroups itemconfigure $selectedMapGroupIx -selectbackground lightgrey
}

proc UpdateMapGroup {lbMapGroups lbMaps} {
    global mapGroupsMapper
    global allMaps
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set mapGroups [set $mapGroupsName]
    set sel [lindex $mapGroups [$lbMapGroups curselection]]
    set includedMapIxs [$lbMaps curselection]
    set includedMaps {}
    foreach mapIx $includedMapIxs {
        lappend includedMaps [lindex $allMaps $mapIx]
    }
    set mapGroupsMapper [dict set mapGroupsMapper $sel $includedMaps]

    set selectedMapGroupIx [$lbMapGroups curselection]
    $lbMapGroups itemconfigure $selectedMapGroupIx -selectbackground lightgrey
}

proc RestoreMapGroup {lbMapGroups lbMaps} {
    SetSelectedMapGroup $lbMapGroups $lbMaps
    UpdateMapGroup $lbMapGroups $lbMaps
}

variable CurrentMouseYInMaps 0
proc UpdateCurrentMouseYInMaps {lbMaps} {
    global CurrentMouseYInMaps
    set CurrentMouseYInMaps [winfo pointery $lbMaps]
}

proc ShowMapPreview {lbMaps} {
    global SelectedPreviewMapName
    global CurrentMouseYInMaps
    set wBaseY [winfo rooty $lbMaps]
    set scrollBoxYView [$lbMaps yview]
    set scrollBoxY [lindex $scrollBoxYView 0]
    set scrollBoxElems [$lbMaps size]
    set scrollLines [expr round($scrollBoxY * $scrollBoxElems)]
    set bbox [$lbMaps bbox $scrollLines]
    set listItemHeight [lindex $bbox 3]
    incr listItemHeight
    set hooverIdx [expr round($scrollLines + ($CurrentMouseYInMaps - $wBaseY) / $listItemHeight)]
    set SelectedPreviewMapName [$lbMaps get $hooverIdx]
    UpdateMapPreview
}

proc ClickedMapsListBox {lbMapGroups lbMaps} {
    set selectedMapGroup [GetSelectedMapGroup $lbMapGroups]
    if { "$selectedMapGroup" == "" } {
        return 
    }
    set selectedMapGroupIx [$lbMapGroups curselection]
    set mapsFromSelectedMapGroup [GetMapsFromSelectedMapGroup $selectedMapGroup]
    if { "$mapsFromSelectedMapGroup" == "" } {
        return
    }
    set selectedMaps [GetSelectedMaps $lbMaps]
    if { $mapsFromSelectedMapGroup != $selectedMaps } {
        $lbMapGroups itemconfigure $selectedMapGroupIx -selectbackground red
    } else {
        $lbMapGroups itemconfigure $selectedMapGroupIx -selectbackground lightgrey
    }
}

variable mapGroupListBox
variable mapsListBoxMultiSelect
variable MapGroupCountVariable
variable SelectedMapCountVariable
variable imgSelectedPreviewMap
variable SelectedPreviewMapName "nisse"

proc UpdateMapPreview {} {
    global installFolder
    global SelectedPreviewMapName
    global imgSelectedPreviewMap
    set cachedFile "$installFolder/maps/cached/$SelectedPreviewMapName.jpg"
    if { ! [file exists "$cachedFile" ] } {
        set cachedFile [file join $starkit::topdir "no_map_picture.jpg"]
    }
    image create photo imgSelectedPreviewMap -file "$cachedFile"
}

proc CreateMapPreview {at} {
    global imgSelectedPreviewMap
    frame $at
    UpdateMapPreview
    set width 320
    set height 256
    label $at.preview -text "" -image imgSelectedPreviewMap -compound bottom -width $width -height $height
    pack $at.preview -side top -anchor e
    return $at
}

proc LayoutFuncMapGroups {at help layout parms} {
#see: http://www.tkdocs.com/tutorial/morewidgets.html
    global MapGroupCountVariable
    global SelectedMapCountVariable
    global allMaps
    set pageOptions [dict get $layout options]
    set configName [dict get $pageOptions configName]
    global $configName
    set config [set $configName]
    set values [dict get $config values]
    global mapGroupListBox
    set mapGroups [lsort [dict get $values mapGroups]]
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set $mapGroupsName $mapGroups
    frame $at
    
    # groups
    set groupsFrame [frame $at.groups]
    set MapGroupCountVariable "Number of maps groups: [llength $mapGroupsName]"
    label $groupsFrame.mapgroupcount -textvariable MapGroupCountVariable
    pack $groupsFrame.mapgroupcount -side top -anchor w
    set groupsLbFrame [frame $groupsFrame.lbframe]
    set mapGroupListBox [tk::listbox $groupsLbFrame.lb -listvariable $mapGroupsName -height 15 -width 40 -activestyle none -exportselection 0]
    pack $mapGroupListBox -side left
    pack [ttk::scrollbar $groupsLbFrame.sb -command "$groupsLbFrame.lb yview" -orient vertical] -side right -fill y -expand true
    $groupsLbFrame.lb configure -yscrollcommand "$groupsLbFrame.sb set"
    pack $groupsLbFrame -side top -anchor w
    pack $groupsFrame -side left -anchor nw
    frame $groupsFrame.buttons
    pack $groupsFrame.buttons -side top -anchor w -fill x

    # update/restore -- frame only
    set synchFrame [frame $at.synch]
    pack $synchFrame -side left -anchor center
    
    # maps    
    set mapsFrame [frame $at.maps]
    set SelectedMapCountVariable "Number of selected maps: ?/[llength $allMaps]"
    label $mapsFrame.mapcount -textvariable SelectedMapCountVariable
    pack $mapsFrame.mapcount -side top -anchor w
    set mapsLbFrame [frame $mapsFrame.lbframe]
    global mapsListBoxMultiSelect
    set mapsListBoxMultiSelect [tk::listbox $mapsLbFrame.lb -listvariable allMaps -height 15 -width 40 -activestyle none -exportselection 0 -selectmode extended]
    pack $mapsListBoxMultiSelect -side left
    pack [ttk::scrollbar $mapsLbFrame.sb -command "$mapsLbFrame.lb yview" -orient vertical] -side right -fill y -expand true
    $mapsLbFrame.lb configure -yscrollcommand "$mapsLbFrame.sb set"
    pack $mapsLbFrame -side top -anchor w
    pack $mapsFrame -side left -anchor n

    # update buttons
    frame $synchFrame.buttons
    button $synchFrame.buttons.update -text "<--" -command "UpdateMapGroup $mapGroupListBox $mapsListBoxMultiSelect"
    SetTooltip $synchFrame.buttons.update "Updates map group with selected maps"
    button $synchFrame.buttons.restore -text "-->" -command "RestoreMapGroup $mapGroupListBox $mapsListBoxMultiSelect"
    SetTooltip $synchFrame.buttons.restore "Restores map group with old settings, i.e. overwrites your currently selected maps"
    pack $synchFrame.buttons.update -side top -fill x
    pack $synchFrame.buttons.restore -side top -fill x
    pack $synchFrame.buttons -side top -anchor center

    # map group buttons
    button $groupsFrame.buttons.add -text "+" -command "AddMapGroup $mapGroupListBox  $mapsListBoxMultiSelect"
    SetTooltip $groupsFrame.buttons.add "Adds a new empty map group \"empty_mapgroup\", rename it to set a better name"
    button $groupsFrame.buttons.delete -text "-" -command "DeleteMapGroup $mapGroupListBox $mapsListBoxMultiSelect"
    SetTooltip $groupsFrame.buttons.delete "Deletes currently selected map group"
    button $groupsFrame.buttons.copy -text "Copy" -command "CopyMapGroup $mapGroupListBox $mapsListBoxMultiSelect"
    SetTooltip $groupsFrame.buttons.copy "Copies currently selected map group to a new group named <old name>_copy"
    button $groupsFrame.buttons.rename -text "Rename" -command "RenameMapGroup $mapGroupListBox $mapsListBoxMultiSelect"
    SetTooltip $groupsFrame.buttons.rename "Renames currently selected map group. Spaces and - are not allowed in a map group name."
    pack $groupsFrame.buttons.add -side left -anchor w
    pack $groupsFrame.buttons.delete -side left
    pack $groupsFrame.buttons.copy -side left
    pack $groupsFrame.buttons.rename -side left
    
    # map preview
    set mapPreviewFrame [frame $at.mappreview -padx 20]
    label $mapPreviewFrame.previewtext -text "Press right mouse button over a map to preview it"
    pack $mapPreviewFrame.previewtext -side top -anchor w
    pack [CreateMapPreview $mapPreviewFrame.previewimage] -side top -fill x
    pack $mapPreviewFrame -side left -anchor ne

    pack $at -side top

    bind $mapGroupListBox <<ListboxSelect>> "SetSelectedMapGroup %W $mapsListBoxMultiSelect"
    bind $mapsListBoxMultiSelect <<ListboxSelect>> "ClickedMapsListBox $mapGroupListBox %W"
    event add <<MyEvent>> <Return>
    bind $mapsListBoxMultiSelect <<MyEvent>> "ShowMapPreview %W"
    bind $mapsListBoxMultiSelect <3> "ShowMapPreview %W"
    bind $mapsListBoxMultiSelect <Motion> "UpdateCurrentMouseYInMaps %W"
    bind $mapGroupListBox <Double-B1-ButtonRelease> "RenameMapGroup $mapGroupListBox $mapsListBoxMultiSelect"

    $mapGroupListBox select set 0
    SetSelectedMapGroup $mapGroupListBox $mapsListBoxMultiSelect
    
    return $at
}

proc LayoutFuncConsole {at help layout parms} {
    frame $at
    frame $at.config -borderwidth 10
    frame $at.execf -borderwidth 10
    ExecutorCreate $at.execf
    pack $at.execf -side top -fill both -expand true
    pack $at

    return $at
}

proc LayoutFuncRconCli {at help layout parms} {
    frame $at
    frame $at.rconcli -borderwidth 10
    frame $at.rconcliexecf -borderwidth 10
    ::rcon::ExecutorCreate $at.rconcliexecf
    pack $at.rconcliexecf -side top -fill both -expand true
    pack $at
    return $at
}

proc CreateConfigPages { at w h } {
    ttk::notebook $at.n
    ttk::notebook::enableTraversal $at.n
    $at.n configure
    return $at.n
}

proc GetConfigValue {config key} {
    global $config
    set values [dict get $config values]
    return [dict get $values $key]
}

proc SetConfigPage {page} {
    global configPages
    global $page
    $configPages select $page
}

proc FlashConfigItem {page key} {
    global configPages
    global $page
    $configPages select $page
    Help "Missing item $key" "You must fill in item $key before performing this operation"
}
