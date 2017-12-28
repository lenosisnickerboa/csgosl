#!/bin/bash

BASE_FILE="$1"
[ -z "$BASE_FILE" ] && { echo "No base file stated!" ; exit 1 ; }
[ ! -f "$BASE_FILE" ] && { echo "Base file $BASE_FILE does not exist!" ; exit 1 ; }
shift

echo -e "//Generated `date`, will be rewritten every csgosl update.\r"
echo
head -n -1 $BASE_FILE
echo
for i in $* ; do
    echo -e "// Merging $i\r"
    cat $i 
done

echo "}"
