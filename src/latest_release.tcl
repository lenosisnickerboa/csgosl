#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir trace.tcl]
source [file join $starkit::topdir wget.tcl]

proc GetLatestRelease {} {
    Trace "Getting latest release..."
    set releaseFileName "release-info.txt"
    Wget "https://github.com/lenosisnickerboa/csgosl/releases/latest" $releaseFileName
    set fp [open "$releaseFileName" r]
    set fileData [read $fp]
    close $fp
    set data [split $fileData "\n"]
    foreach line $data {
        if { [regexp {.*\/lenosisnickerboa\/csgosl\/releases\/download\/v(.*)\/csgosl-linux\.zip.*} $line -> version] } {
            Trace "Found latest release $version"
            return $version
        }
        if { [regexp {.*\/github\.com\/lenosisnickerboa\/csgosl\/releases\/tag\/v(.*)\".*} $line -> version] } {
            Trace "Found latest release $version"
            return $version
        }
    }
    return ""
}

proc InstallRelease {release} {
    global installFolder
    set updateFolder "$installFolder/updatefolder"
    file delete -force "$updateFolder"
    file mkdir "$updateFolder"
    global currentOs
    set url "https://github.com/lenosisnickerboa/csgosl/releases/download/v$release/csgosl-linux.zip"
    if {$currentOs == "windows"} {
        set url "https://github.com/lenosisnickerboa/csgosl/releases/download/v$release/csgosl-windows.zip"
    }
    Trace "Dowloading release $release using url $url..."
    set downloadFileTo [file nativename "$updateFolder/csgosl.zip"]
    Wget "$url" "$downloadFileTo"
    exit 84
}
