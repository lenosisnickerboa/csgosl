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
            windows_unzip_version windows_unzip_home_url windows_unzip_url
        set contribs \
        [list \
                h2      [list "Sourcemod $windows_sourcemod_version"] \
                line    [list] \
                url     [list "Homepage" "$windows_sourcemod_home_url"] \
                url     [list "Download $windows_sourcemod_version" "$windows_sourcemod_url"] \
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
            linux_metamod_version linux_metamod_home_url linux_metamod_url
        set contribs \
        [list \
                h2      [list "Sourcemod $linux_sourcemod_version"] \
                line    [list] \
                url     [list "Homepage" "$linux_sourcemod_home_url"] \
                url     [list "Download $linux_sourcemod_version" "$linux_sourcemod_url"] \
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
