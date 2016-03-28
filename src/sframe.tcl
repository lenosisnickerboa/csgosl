#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

#source: http://wiki.tcl.tk/9223

# sframe.tcl
    # Paul Walton
    # Create a ttk-compatible, scrollable frame widget.
    #   Usage:
    #       sframe new <path> ?-toplevel true?  ?-anchor nsew?
    #       -> <path>
    #
    #       sframe content <path>
    #       -> <path of child frame where the content should go>
    #       lenos added: -scrollx , -scrolly
    namespace eval ::sframe {
        namespace ensemble create
        namespace export *
    
        # Create a scrollable frame or window.
        proc new {path args} {
            set scrollx [expr { [dict exists $args -scrollx]  &&  [dict get $args -scrollx] }]
            set scrolly [expr { [dict exists $args -scrolly]  &&  [dict get $args -scrolly] }]
            
            # Use the ttk theme's background for the canvas and toplevel
            set bg [ttk::style lookup TFrame -background]
            if { [ttk::style theme use] eq "aqua" } {
                # Use a specific color on the aqua theme as 'ttk::style lookup' is not accurate.
                set bg "#e9e9e9"
            }
        
            # Create the main frame or toplevel.
            if { [dict exists $args -toplevel]  &&  [dict get $args -toplevel] } {
                toplevel $path  -bg $bg
            } else {
                ttk::frame $path
            }
            
            # Create a scrollable canvas with scrollbars which will always be the same size as the main frame.
            if { $scrollx && $scrolly } {
                set canvas [canvas $path.canvas -bg $bg -bd 0 -highlightthickness 0 -yscrollcommand [list $path.scrolly set] -xscrollcommand [list $path.scrollx set]]
            } else {
                if { $scrolly } {
                    set canvas [canvas $path.canvas -bg $bg -bd 0 -highlightthickness 0 -yscrollcommand [list $path.scrolly set]]
                }
                if { $scrollx } {
                    set canvas [canvas $path.canvas -bg $bg -bd 0 -highlightthickness 0 -xscrollcommand [list $path.scrollx set]]
                }
            }
            if { $scrolly } {
                ttk::scrollbar $path.scrolly -orient vertical   -command [list $canvas yview]
            }
            if { $scrollx } {
                ttk::scrollbar $path.scrollx -orient horizontal -command [list $canvas xview]
            }
            
            # Create a container frame which will always be the same size as the canvas or content, whichever is greater. 
            # This allows the child content frame to be properly packed and also is a surefire way to use the proper ttk background.
            set container [ttk::frame $canvas.container]
            pack propagate $container 0
            
            # Create the content frame. Its size will be determined by its contents. This is useful for determining if the 
            # scrollbars need to be shown.
            set content [ttk::frame $container.content]
            
            # Pack the content frame and place the container as a canvas item.
            set anchor "n"
            if { [dict exists $args -anchor] } {
                set anchor [dict get $args -anchor]
            }
            pack $content -anchor $anchor
            $canvas create window 0 0 -window $container -anchor nw
            
            # Grid the scrollable canvas sans scrollbars within the main frame.
            grid $canvas   -row 0 -column 0 -sticky nsew
            grid rowconfigure    $path 0 -weight 1
            grid columnconfigure $path 0 -weight 1
            
            # Make adjustments when the sframe is resized or the contents change size.
            bind $path.canvas <Expose> [list [namespace current]::resize $path]
            
            # Mousewheel bindings for scrolling.
            if { $scrolly } {
                bind [winfo toplevel $path] <MouseWheel>       [list +[namespace current] scroll $path yview %W %D]
            }
            if { $scrollx } {
                bind [winfo toplevel $path] <Shift-MouseWheel> [list +[namespace current] scroll $path xview %W %D]
            }
            
            return $path
        }
    
    
        # Given the toplevel path of an sframe widget, return the path of the child frame suitable for content.
        proc content {path} {
            return $path.canvas.container.content
        }
    
    
        # Make adjustments when the the sframe is resized or the contents change size.
        proc resize {path} {
            set canvas    $path.canvas
            set container $canvas.container
            set content   $container.content
    
            # Set the size of the container. At a minimum use the same width & height as the canvas.
            set width  [winfo width $canvas]
            set height [winfo height $canvas]
            
            # If the requested width or height of the content frame is greater then use that width or height.
            if { [winfo reqwidth $content] > $width } {
                set width [winfo reqwidth $content]
            }
            if { [winfo reqheight $content] > $height } {
                set height [winfo reqheight $content]
            }
            $container configure  -width $width  -height $height
    
            # Configure the canvas's scroll region to match the height and width of the container.
            $canvas configure -scrollregion [list 0 0 $width $height]
    
            # Show or hide the scrollbars as necessary.
            # Horizontal scrolling.
            if {[winfo exists $path.scrollx]} {
                if { [winfo reqwidth $content] > [winfo width $canvas] } {
                    grid $path.scrollx  -row 1 -column 0 -sticky ew
                } else {
                    grid forget $path.scrollx
                }
            }
            # Vertical scrolling.
            if {[winfo exists $path.scrolly]} {
                if { [winfo reqheight $content] > [winfo height $canvas] } {
                    grid $path.scrolly  -row 0 -column 1 -sticky ns
                } else {
                    grid forget $path.scrolly
                }
            }
            return
        }
    
    
        # Handle mousewheel scrolling.    
        proc scroll {path view W D} {
            if { [winfo exists $path.canvas]  &&  [string match $path.canvas* $W] } {
                $path.canvas $view scroll [expr {-$D}] units
            }
            return
        }
    }
	
