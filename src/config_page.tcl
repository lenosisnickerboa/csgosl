#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir widgets.tcl]
source [file join $starkit::topdir hyperlink.tcl]
source [file join $starkit::topdir config_file.tcl]
source [file join $starkit::topdir browser.tcl]

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

proc CreateConfigPageH2 {at parms} {
    set text [lindex $parms 0]
    pack [label $at -text "$text" -anchor w -font {-size -14 -weight bold}] -side top -fill x -expand true
}

proc CreateConfigPageText {at parms} {
    set text [lindex $parms 0]
    pack [label $at -text "$text" -anchor w] -side top -fill x -expand true
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

proc CreateConfigPageItem {at lead name value type default help selections} {   
    if {$type == "directory"} {
        pack [CreateDirEntry $at $lead $name $default $help] -side top -fill x -expand true            
    } elseif {$type == "url"} {
        pack [CreateEntry $at $lead $name $default $help] -side top -fill x -expand true
    } elseif {$type == "int"} {
        pack [CreateEntry $at $lead $name $default $help] -side top -fill x -expand true
    } elseif {$type == "bool"} {
        pack [CreateCheckbox $at $lead $name $default $help] -side top -fill x -expand true
    } elseif {$type == "enum"} {
        pack [CreateSelector $at $lead $name $default $help $selections] -side top -fill x -expand true
    } elseif {$type != "line"} {
        pack [CreateEntry $at $lead $name $default $help] -side top -fill x -expand true
    }
}

proc CreateConfigPageFromLayout {at layout} {
    set pageOptions [dict get $layout options]
    set components [dict get $layout components]
    set configName [dict get $pageOptions configName]
    global $configName
    set config [set $configName]
    set parmValues [dict get $config values]
    set meta [dict get $config meta]
    
    sframe new $at.scrollableitems -anchor n -scrolly yes -scrollx no
    set page [sframe content $at.scrollableitems]

    set help [dict get $pageOptions help]
    bind $page <F1> [subst "Help $help" ]

    frame $page.buttons
    pack [button $page.buttons.setdefault -text "Set defaults" -anchor e -font {-size -8} -command [subst "SetDefaults $configName"]] -side left
    pack [button $page.buttons.helphint -text "Help on $help (F1)" -anchor e -font {-size -8} -command [subst "Help $help"]] -side left
    pack $page.buttons -side top -anchor e

    set widgetIx 0
    foreach {type args} $components {
        if {$type == "parm"} {
            set parmName [join [lindex $args 0]]
            set prefix [dict get $config prefix]
            set parmValue [dict get $parmValues $parmName]
            set globalParmName [GetGlobalConfigVariableName $prefix $parmName]
            global $globalParmName
            set $globalParmName $parmValue
            set metaItem [dict get $meta $parmName]
            set parmType [dict get $metaItem type]
            set help [dict get $metaItem help]
            set parmDefault [dict get $metaItem default]
            set selections [list]
            if {$parmType == "enum"} {
                set selections [dict get $metaItem selections]
            }
            CreateConfigPageItem $page.w$parmName $parmName $globalParmName $parmValue $parmType $parmDefault $help $selections
        } elseif {$type == "func"} {
            CreateConfigPageFunc $page.func$widgetIx $help $layout $args
        } elseif {$type == "h1"} {
            CreateConfigPageH1 $page.h1$widgetIx $args
        } elseif {$type == "h2"} {
            CreateConfigPageH2 $page.h2$widgetIx $args
        } elseif {$type == "url"} {
            CreateConfigPageUrl $page.url$widgetIx $args
        } elseif {$type == "text"} {
            CreateConfigPageText $page.h2$widgetIx $args
        } elseif {$type == "line"} {
            CreateConfigPageLine $page.line$widgetIx $args
        } elseif {$type == "space"} {
            CreateConfigPageSpace $page.space$widgetIx $args
        }
        incr widgetIx
    }
    pack $at.scrollableitems -side top -anchor nw -fill both -expand true
    return $at
}

proc CreateMapsSelector {at maps selector} {
    set width 320
    set height 256
    global installFolder
    
    foreach map $maps {
        set cachedFile "$installFolder/maps/cached/$map.jpg"
        if { ! [file exists "$cachedFile" ] } {
            set cachedFile [file join $starkit::topdir "no_map_picture.jpg"]
        }
        image create photo mapButtonImg$map -file "$cachedFile"
        if {$selector} {
            checkbutton $at.m_$map -text "$map" -image mapButtonImg$map -compound bottom -variable mapState$map -width $width -height $height
        } else {
            label $at.m_$map -text "$map" -image mapButtonImg$map -compound bottom -width $width -height $height
        }
        pack $at.m_$map -side top 
    }
    return $at
}

proc LayoutFuncMaps {at help layout parms} {
    global allMaps

    frame $at
    CreateMapsSelector $at $allMaps false
    pack $at -side top -fill both -expand true
    return $at
}

proc LayoutFuncSetDefaultsAll {at help layout parms} {
    pack [button $at -text "Set all defaults -- WARNING resets all settings to defaults" -anchor e -font {-size -8} -command [subst "SetDefaultsAll"]] -side left
}

proc CreateMapsSelectorWindow {lead maps selector} {
    global installFolder

    set at .mapSelectorWindow
    
    sframe new $at -toplevel true -anchor w -scrolly yes -scrollx no
    set top [sframe content $at]    

    wm title $at $lead
    wm geometry $at 800x600
 
    #fix to ensure the window is visible before grabbed   
    bind $at <Visibility> [list set waiting($at) gotit]
    vwait waiting($at)
    bind $at <Visibility> {}    ;# remove the binding again!
    grab set $at
    
    #TODO: add OK, cancel buttons

    pack [CreateMapsSelector $top $maps $selector] -side top
    tkwait window $at
    
    return $at
}

proc UpdateRunPage {} {
    global runPage
    global mapGroupsMapper
    set mapGroupsSel [GetConfigPageSelectorWidget $runPage mapgroup]
    set values [lsort [dict keys $mapGroupsMapper]]
    $mapGroupsSel configure -values $values
    set mapGroupName [GetGlobalConfigVariableName Run mapgroup]
    global $mapGroupName
    set mapGroup [set $mapGroupName]
    if { [lsearch -exact $values $mapGroup] == -1 } {
        set mapGroup [lindex $values 0]
        set $mapGroupName $mapGroup
    }
    set startMapName [GetGlobalConfigVariableName Run startmap]   
    global $startMapName
    set startMap [set $startMapName]
    global mapGroupsMapper
    set maps [lsort [dict get $mapGroupsMapper $mapGroup]]
    if { [lsearch -exact $maps $startMap] == -1 } {
        set $startMapName [lindex $maps 0]
    }
}

proc AddMapGroup {lb} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    global addMapGroupName
    global mapGroupsMapper
    if { $addMapGroupName != "" } {
        $lb insert end "$addMapGroupName"
        set mapGroups [set $mapGroupsName]
        set mapGroupsMapper [dict set mapGroupsMapper $addMapGroupName [list]]
        set $mapGroupsName [lsort [dict keys $mapGroupsMapper] ]
        UpdateRunPage
    }
}

proc AddMapGroupZ {lb} {
    AddMapGroup $lb
    global addMapGroupName
    set addMapGroupName ""
}

proc EditMapGroup {lb} {
    global mapGroupsMapper
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set idx [$lb curselection]
    set mapGroups [set $mapGroupsName]
    set sel [lindex $mapGroups $idx]
    global allMaps
    if { ! [dict exists $mapGroupsMapper $sel] } {
        set mapGroupsMapper [dict set mapGroupsMapper $sel [list]]
    }
    SetMapsState $allMaps [dict get $mapGroupsMapper $sel]
    CreateMapsSelectorWindow "Select maps which should be included in map group $sel and then close the window when done." $allMaps true
    set mapGroup [GetMapsState $allMaps]
    set mapGroupsMapper [dict set mapGroupsMapper $sel $mapGroup]
    UpdateRunPage
}

proc DeleteMapGroup {lb} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    global mapGroupsMapper
    set mapGroups [set $mapGroupsName]
    set idx [$lb curselection]
    if { $idx > 0 } {
	set sel [lindex $mapGroups $idx]
	$lb delete $idx
	set mapGroupsMapper [dict remove $mapGroupsMapper $sel]
	UpdateRunPage
    }
}

proc SetSelectedMapGroup {lb} {
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set mapGroups [set $mapGroupsName]
    set sel [lindex $mapGroups [$lb curselection]]
    global addMapGroupName
    set addMapGroupName "$sel"
}

variable addMapGroupName
variable mapGroupListBox

proc LayoutFuncMapGroups {at help layout parms} {
#see: http://www.tkdocs.com/tutorial/morewidgets.html
    set pageOptions [dict get $layout options]
    set configName [dict get $pageOptions configName]
    global $configName
    set config [set $configName]
    set values [dict get $config values]
    global addMapGroupName
    global mapGroupListBox
    set mapGroups [lsort [dict get $values mapGroups]]
    set mapGroupsName [GetGlobalConfigVariableName MapGroups mapGroups]
    global $mapGroupsName
    set $mapGroupsName $mapGroups
    frame $at
    frame $at.f
    set mapGroupListBox [tk::listbox $at.f.groups -listvariable $mapGroupsName -height 15 -width 40 -activestyle none]
    pack $mapGroupListBox -side left
    pack [ttk::scrollbar $at.f.sb -command "$at.f.groups yview" -orient vertical] -side left -fill y -expand true
    $at.f.groups configure -yscrollcommand "$at.f.sb set"
    pack $at.f -side top
    frame $at.e
    entry $at.e.sel -width 40 -relief sunken -textvariable addMapGroupName
    pack $at.e.sel -side left -anchor w -fill x
    pack $at.e -side top 
    frame $at.mgedit
    button $at.mgedit.add -text "Add" -command "AddMapGroup $mapGroupListBox"
    button $at.mgedit.edit -text "Edit" -command "EditMapGroup $mapGroupListBox"
    button $at.mgedit.delete -text "Delete" -command "DeleteMapGroup $mapGroupListBox"
    pack $at.mgedit.add -side left -anchor w
    pack $at.mgedit.edit -side left
    pack $at.mgedit.delete -side right 
    pack $at.mgedit -side top
    bind $mapGroupListBox <<ListboxSelect>> "SetSelectedMapGroup %W"
    bind $mapGroupListBox <Double-B1-ButtonRelease> [subst "EditMapGroup $mapGroupListBox"]
    bind $at.e.sel <Return> [subst "AddMapGroupZ $mapGroupListBox"]
    bind $at.e.sel <KP_Enter> [subst "AddMapGroupZ $mapGroupListBox"]
    pack $at -side top
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
