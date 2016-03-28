#!/bin/bash

#main

echo '#!/bin/sh'
echo '# -*- tcl -*-'
echo '# The next line is executed by /bin/sh, but not tcl \'
echo 'exec wish "$0" ${1+"$@"}'

while read line ; do
    tokens=($line)
    echo "set ${tokens[0]}_${tokens[1]}_version \"${tokens[2]}\""
    echo "set ${tokens[0]}_${tokens[1]}_home_url \"${tokens[3]}\""
    echo "set ${tokens[0]}_${tokens[1]}_url \"${tokens[4]}\""
done

