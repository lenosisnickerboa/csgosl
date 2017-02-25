#!/bin/bash

full_path=`dirname "$(readlink -f "$0")"`
full_path_srcds=`dirname $full_path`/server

function status_ext() {
    local pids=`pgrep $1`
    [ -z "$pids" ] && return 1
    local pidline=`pwdx $pids | grep "$full_path_srcds"`
    [ -z "$pidline" ] && return 1
    echo $pidline | cut -d ':' -f1
}

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
	pid1=`status_ext srcds_run`
	pid2=`status_ext srcds_linux`
	[ ! -z "$pid1$pid2" ] && kill -9 $pid1 $pid2
	;;
    status)
	pid=`status_ext srcds_linux`
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
