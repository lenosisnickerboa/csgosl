#!/bin/bash

BASE_FILE="$1"
[ -z "$BASE_FILE" ] && { echo "No base file stated!" ; exit 1 ; }
[ ! -f "$BASE_FILE" ] && { echo "Base file $BASE_FILE does not exist!" ; exit 1 ; }
shift

echo "//Generated `date`, will be rewritten every csgosl update"
head -n -1 $BASE_FILE
for i in $* ; do
    echo "// Merging $i"
    cat $i 
done

echo "}"
