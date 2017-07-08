#!/bin/sh
# -*- tcl -*-
# The next line is executed by /bin/sh, but not tcl \
exec wish "$0" ${1+"$@"}

## Server config
variable gotvConfig [CreateConfig \
    [list \
        name     "gotvConfig" \
        prefix   "GOTV" \
        fileName "$configFolder/gotv.cfg" \
        saveProc "SaveConfigFileGoTv" \
    ] \
    [list \
        "bool"      [list gotvenable "0" "Enable gotv server" onchange "SetGoTvState"]\
        "int"       [list gotvport "27020" "Your gotv server port. You need to open this port in your router and forward it to your external IP address.\nRead more about this on the help page."]\
        "string"    [list gotvtitle "Your gotv server at $hostName operated by $name" "This is the gotv server name which is presented to gotv spectators."]\
        "string"    [list gotvname "Your gotv server at $hostName operated by $name" "This is the gotv server name as it appears in server browser and scoreboard."]\
        "string"    [list gotvpassword "" "Your gotv server password which anyone connecting to your gotv server must enter to log in and spectate.\nWhen running a LAN only server this can be left empty for no password."]\
        "int"       [list gotvdelay "10" "The number of seconds to delay your broadcast."]\
        "int"       [list gotvdeltacache "2" "Control broadcast smoothness"]\
        "int"       [list gotvsnapshotrate "24" "Snapshots broadcasted per second."]\
        "bool"      [list gotvallowcameraman "0" "Auto director allows spectators to become camera man"]\
        "bool"      [list gotvallowstaticshots "0" "Auto director uses fixed level cameras for shots"]\
        "bool"      [list gotvautorecord "0" "Automatically records all games as GOTV demos."]\
        "bool"      [list gotvchat "0" "Allow spectators to chat"]\
        "bool"      [list gotvdelaymapchange "1" "Delay map change until broadcast is complete"]\
        "int"       [list gotvmaxclients "10" "Max number of spectators"]\
    ] \
]

variable gotvLayout [CreateLayout \
    [list \
        configName  "gotvConfig" \
        tabName     "GOTV" \
        help        "GOTV" \
    ] \
    [list \
        h1      [list "GOTV settings"] \
        space   [list] \
        h2      [list "General"] \
        line    [list] \
        space   [list] \
        parm    [list gotvenable] \
        parm    [list gotvtitle] \
        parm    [list gotvname] \
        parm    [list gotvpassword] \
        parm    [list gotvmaxclients] \
        parm    [list gotvchat] \
        space   [list] \
        h2      [list "Connection"] \
        line    [list] \
        space   [list] \
        parm    [list gotvport] \
        space   [list] \
        h2      [list "Broadcast settings"] \
        line    [list] \
        space   [list] \
        parm    [list gotvautorecord] \
        parm    [list gotvdelay] \
        parm    [list gotvallowstaticshots] \
        parm    [list gotvallowcameraman] \
        parm    [list gotvsnapshotrate] \
        space   [list] \
        h2      [list "Misc"] \
        line    [list] \
        space   [list] \
        parm    [list gotvdelaymapchange] \
        parm    [list gotvdeltacache] \
    ] \
]

proc SetGoTvState { value } {
    global gotvLayout
    set cp [GetCp]
    set enabled $value
    foreach parm [list gotvport gotvtitle gotvname gotvpassword gotvdelay gotvdeltacache gotvsnapshotrate gotvallowcameraman gotvallowstaticshots gotvautorecord gotvchat gotvdelaymapchange gotvmaxclients] {
        SetConfigItemState $cp.gotv $gotvLayout $parm $enabled        
    }
    return $value        
}