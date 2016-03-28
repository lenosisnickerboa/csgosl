#!/bin/bash

action="$1" ; shift

case "$action" in 
    start)
	"$@" &
	;;
    autorestart)
	while : ; do
	    "$@" &
	    echo Server was stopped or crashed, restarting...
	done
	;;
    stop)
	killall srcds_linux
	;;
    status)
	ps aux | grep srcds_linux | grep -v grep >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
	    echo running
#	    exit 0
	else
	    echo not_running
#	    exit 1   -- can't return 1 here, tcl interpreter exits
	fi
	;;
esac

#screen -d -m -t csgo-console -S csgo-console "$@"
#xterm -hold -e screen -r csgo-console &
