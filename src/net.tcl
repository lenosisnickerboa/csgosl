#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

source [file join $starkit::topdir wget.tcl]

namespace eval net {
}

#source https://wiki.tcl.tk/3015
proc net::localIpAddress {{target www.google.com} {port 80}} {
     set s [socket $target $port]
     set res [fconfigure $s -sockname]
     close $s
     lindex $res 0
}

proc net::externalIpAddress {} {
    global installFolder
    set fileName "$installFolder/externalIP.txt"
    Wget "whatismyip.akamai.com" "$fileName"
    set fp [open "$fileName" r]
    set fileData [read $fp]
    close $fp
    file delete -force "$fileName"
    return $fileData
}

proc net::isPortOpen {port} {
    global installFolder
    set fileName "$installFolder/isPortOpen.txt"
    WgetPost "canyouseeme.org" "port=$port" "$fileName"
    set fp [open "$fileName" r]
    set fileData [read $fp]
    close $fp
    file delete -force "$fileName"
    set notOpen [string match "*Error:*" $fileData]
    if { $notOpen } {
        return 0
    } else {
        return 1
    }
}