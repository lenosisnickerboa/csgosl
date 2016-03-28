#!/bin/bash

while : ; do
    tclsh bin/csgosl.tcl "$@"
    if [ $? -ne 42 ] ; then
	exit
    fi
done
