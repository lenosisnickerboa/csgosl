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
    }
    return ""
}
