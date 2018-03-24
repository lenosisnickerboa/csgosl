#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir contribs.tcl]

## About config
variable aboutConfig [CreateConfig \
    [list \
        name     "aboutConfig" \
        prefix   "About" \
        fileName "" \
        saveProc "SaveProcDummy" \
    ] \
    [list \
    ] \
]

proc GetContributors {} {
    
    set heading \
    [list \
            space   [list] \
            h1      [list "About"] \
            space   [list] \
            h2      [list "Author"] \
            line    [list] \
            space   [list] \
            text    [list "Lennart Oscarsson, lennart@oscarssons.com"] \
            space   [list] \
            h2      [list "Contributors"] \
            line    [list] \
            space   [list] \
    ]

    variable contribs
    
    global currentOs
    if {$currentOs == "windows"} {
        global \
            windows_tclkit_version windows_tclkit_home_url windows_tclkit_url \
            windows_sdx_version windows_sdx_home_url windows_sdx_url \
            windows_sourcemod_version windows_sourcemod_home_url windows_sourcemod_url\
            windows_metamod_version windows_metamod_home_url windows_metamod_url\
            windows_unzip_version windows_unzip_home_url windows_unzip_url \
            windows_wget_version windows_wget_home_url windows_wget_url \
            windows_franug_weapon_paints_version windows_franug_weapon_paints_home_url windows_franug_weapon_paints_url \
            windows_franug_knifes_version windows_franug_knifes_home_url windows_franug_knifes_url \
            windows_warmod_version windows_warmod_home_url windows_warmod_url \
            windows_multi1v1_version windows_multi1v1_home_url windows_multi1v1_url \
            windows_gunmenu_version windows_gunmenu_home_url windows_gunmenu_url \
            windows_cksurf_version windows_cksurf_home_url windows_cksurf_url \
            windows_retakes_version windows_retakes_home_url windows_retakes_url\
            all_esl_serverconfig_version all_esl_serverconfig_home_url all_esl_serverconfig_url
        
        set contribs \
        [list \
                h2      [list "Sourcemod $windows_sourcemod_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_sourcemod_home_url"] \
                url     [list "Download $windows_sourcemod_version" "$windows_sourcemod_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: Franug-Weapon_Paints $windows_franug_weapon_paints_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_franug_weapon_paints_home_url"] \
                url     [list "Download $windows_franug_weapon_paints_version" "$windows_franug_weapon_paints_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: Franug-Knifes $windows_franug_knifes_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_franug_knifes_home_url"] \
                url     [list "Download $windows_franug_knifes_version" "$windows_franug_knifes_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: WarMod $windows_warmod_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_warmod_home_url"] \
                url     [list "Download $windows_warmod_version" "$windows_warmod_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: Multi_1v1 $windows_multi1v1_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_multi1v1_home_url"] \
                url     [list "Download $windows_multi1v1_version" "$windows_multi1v1_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: GunMenu $windows_gunmenu_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_gunmenu_home_url"] \
                url     [list "Download $windows_gunmenu_version" "$windows_gunmenu_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: ckSurf $windows_cksurf_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_cksurf_home_url"] \
                url     [list "Download $windows_cksurf_version" "$windows_cksurf_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: retakes $windows_retakes_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_retakes_home_url"] \
                url     [list "Download $windows_retakes_version" "$windows_retakes_url"] \
                space   [list] \
                h2      [list "Config files: esl_serverconfig $all_esl_serverconfig_version"] \
                line    [list] \
                url     [list "Homepage" "$all_esl_serverconfig_home_url"] \
                url     [list "Download $all_esl_serverconfig_version" "$all_esl_serverconfig_url"] \
                space   [list] \
                h2      [list "Metamod $windows_metamod_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_metamod_home_url"] \
                url     [list "Download $windows_metamod_version" "$windows_metamod_url"] \
                space   [list] \
                h2      [list "Unzip $windows_unzip_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_unzip_home_url"] \
                url     [list "Download $windows_unzip_version" "$windows_unzip_url"] \
                space   [list] \
                h2      [list "Wget $windows_wget_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_wget_home_url"] \
                url     [list "Download $windows_wget_version" "$windows_wget_url"] \
                space   [list] \
                h2      [list "Tclkit $windows_tclkit_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_tclkit_home_url"] \
                url     [list "Download $windows_tclkit_version" "$windows_tclkit_url"] \
                space   [list] \
                h2      [list "Sdx $windows_sdx_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_sdx_home_url"] \
                url     [list "Download $windows_sdx_version" "url $windows_sdx_url"] \
        ] 
    } else {
        global \
            linux_sourcemod_version linux_sourcemod_home_url linux_sourcemod_url \
            linux_metamod_version linux_metamod_home_url linux_metamod_url \
            linux_franug_weapon_paints_version linux_franug_weapon_paints_home_url linux_franug_weapon_paints_url \
            linux_franug_knifes_version linux_franug_knifes_home_url linux_franug_knifes_url \
            linux_warmod_version linux_warmod_home_url linux_warmod_url \
            linux_multi1v1_version linux_multi1v1_home_url linux_multi1v1_url \
            linux_gunmenu_version linux_gunmenu_home_url linux_gunmenu_url \
            linux_cksurf_version linux_cksurf_home_url linux_cksurf_url \
            linux_retakes_version linux_retakes_home_url linux_retakes_url\
            all_esl_serverconfig_version all_esl_serverconfig_home_url all_esl_serverconfig_url
        
        set contribs \
        [list \
                h2      [list "Sourcemod $linux_sourcemod_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_sourcemod_home_url"] \
                url     [list "Download $linux_sourcemod_version" "$linux_sourcemod_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: Franug-Weapon_Paints $linux_franug_weapon_paints_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_franug_weapon_paints_home_url"] \
                url     [list "Download $linux_franug_weapon_paints_version" "$linux_franug_weapon_paints_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: Franug-Knifes $linux_franug_knifes_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_franug_knifes_home_url"] \
                url     [list "Download $linux_franug_knifes_version" "$linux_franug_knifes_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: WarMod $linux_warmod_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_warmod_home_url"] \
                url     [list "Download $linux_warmod_version" "$linux_warmod_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: Multi_1v1 $linux_multi1v1_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_multi1v1_home_url"] \
                url     [list "Download $linux_multi1v1_version" "$linux_multi1v1_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: GunMenu $linux_gunmenu_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_gunmenu_home_url"] \
                url     [list "Download $linux_gunmenu_version" "$linux_gunmenu_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: ckSurf $linux_cksurf_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_cksurf_home_url"] \
                url     [list "Download $linux_cksurf_version" "$linux_cksurf_url"] \
                space   [list] \
                h2      [list "Sourcemod plugin: retakes $linux_retakes_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_retakes_home_url"] \
                url     [list "Download $linux_retakes_version" "$linux_retakes_url"] \
                space   [list] \
                h2      [list "Config files: esl_serverconfig $all_esl_serverconfig_version"] \
                line    [list] \
                url     [list "Homepage" "$all_esl_serverconfig_home_url"] \
                url     [list "Download $all_esl_serverconfig_version" "$all_esl_serverconfig_url"] \
                space   [list] \
                h2      [list "Metamod $linux_metamod_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_metamod_home_url"] \
                url     [list "Download $linux_metamod_version" "$linux_metamod_url"] \
        ]
    }
    return [concat $heading $contribs]
}

variable aboutLayout [CreateLayout \
    [list \
        configName  "aboutConfig" \
        tabName     "About" \
        help        "About" \
    ] \
    [GetContributors]
]
