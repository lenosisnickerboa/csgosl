#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

#: Source: http://wiki.tcl.tk/557.html
package require http

source [file join $starkit::topdir trace.tcl]

proc BrowserWorkaroundWindows {url} {
  global installFolder
  set fileName [file nativename "$installFolder/bin/browser-workaround.bat"]
  set fileId [open "$fileName" "w"]
  puts $fileId "start \"Browser workaround launcher\" \"$url\""
  close $fileId
  exec $fileName &
}

proc Browser {url} {
  Trace "Browser: $url"
  # open is the OS X equivalent to xdg-open on Linux, start is used on Windows
  set commands {xdg-open open start}
  foreach browser $commands {
    if {$browser eq "start"} {
      set command [list {*}[auto_execok start] {}]
    } else {
      set command [auto_execok $browser]
    }
    if {[string length $command]} {
      break
    }
  }

  if {[string length $command] == 0} {
    return -code error "couldn't find browser"
  }

  #Apply workaround for urls containing "&"
  global currentOs
  if {($currentOs == "windows") && ([string match "*&*" $url])} {
    BrowserWorkaroundWindows $url    
  } else {
    if {[catch {exec {*}$command $url &} error]} {
      return -code error "couldn't execute '$command': $error"
    }    
  }
}
