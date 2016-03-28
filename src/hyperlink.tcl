#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

#: Source: http://wiki.tcl.tk/36776

proc Hyperlink { name args } {

  if { "Underline-Font" ni [ font names ] } {
    font create Underline-Font {*}[ font actual TkDefaultFont ]
    # adjust size below to your preference
    font configure Underline-Font -underline true -size 10
  }

  if { [ dict exists $args -command ] } {
    set command [ dict get $args -command ]
    dict unset args -command
  }

  # add -foreground, -font, and -cursor, but only if they are missing
  set args [ dict merge [ dict create -foreground blue -font Underline-Font -cursor hand2 ] $args ]

  label $name -anchor w {*}$args

  if { [ info exists command ] } {
    bind $name <Button-1> $command
  }

  return $name
}
