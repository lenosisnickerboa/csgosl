#!/bin/bash

function Update() {
    cd updatefolder
    unzip -o csgosl.zip
    \rm -f csgosl.zip
    local updatefile=update.sh
    echo "sleep 5" > $updatefile
    echo "cp -af csgosl/* ../" >> $updatefile
    echo "cd .." >> $updatefile
    echo "./csgosl.sh &" >> $updatefile
    chmod +x $updatefile
    ./$updatefile &
    exit 0
}

while : ; do
    tclsh bin/csgosl.tcl "$@"
    rc=$?
    if [ $rc -eq 84 ] ; then
	Update
    fi
    if [ $rc -ne 42 ] ; then
	exit
    fi
done
