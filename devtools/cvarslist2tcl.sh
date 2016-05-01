#!/bin/bash

function process_line() {
    local line="$@"
    local variable=`echo $line | cut -d ',' -f1`
    if [ "$variable" == "\"Name\"" ] ; then return ; fi
    if [ -z "$variable" ] ; then return ; fi
    local value=`echo $line | cut -d ',' -f2 | tr -d ' '`
    if [ "$value" == "\"cmd\"" ] ; then return ; fi
    local help=`echo $line | cut -d ',' -f23- | tr '[]' '()' | tr -d '"'`
    local cheat=`echo $line | cut -d ',' -f6`
    if [ ! -z "$cheat" ] ; then
	echo  "\"string\"  [list $variable $value \"CHEAT:$help\"] \\"
    else
	echo  "\"string\"  [list $variable $value \"$help\"] \\"
    fi
}

#Concat quoted strings split over several lines
function get_next_line() {
    local lineTot=""
    while read line ; do
	if [ ${line: -1} == '"' ] ; then { echo $lineTot$line ; return 0 ; } ; fi
	lineTot=$lineTot$line
    done
    return 1
}

input="$1"

echo "## GamemodeConfig from csvars"
echo "variable gameModeConfigcsvars [CreateConfig \\"
echo "[list \\"
echo "name \"gameModeConfigcsvars\" \\"
echo "prefix \"gameModeConfigcsvarslist\" \\"
echo "filename \"\" \\" 
echo "saveProc \"SaveConfigFileDummy\" \\"
echo "] \\"
echo "[list \\"
#( egrep ',\"GAMEDLL\",|,\"ARCHIVE\",|,\"CHEAT\",' $input | while read line ; do process_line "$line" ; done ) | sort

( while line=`get_next_line` ; do
    echo $line
  done < $input | while read line ; do process_line "$line" ; done ) | sort
echo "] \\"
echo "]"
