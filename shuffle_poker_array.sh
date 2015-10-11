#!/bin/bash

# Author: JIN Xiaoyang
# Date  : 2015-10-11
# shuffle poker array file

function usage() {
    echo "Usage: $0 ARRAY_FILE"
    exit 0
}

if [ $# -eq 0 ]; then
    usage
fi

poker_array=$1
if [ ! -f "$poker_array" ]; then
    usage
fi

colNum=$(awk 'NR==1{print NF}' $poker_array)
colSeq=$(Rscript -e 'cat(sample('$colNum','$colNum'))' | sed -e 's/\b\([0-9]\)/$\1/g' -e 's/ /,/g')
awk '{print '$colSeq'}' $poker_array | shuf
