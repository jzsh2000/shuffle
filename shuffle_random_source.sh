#!/bin/bash

# Author: JIN Xiaoyang
# Date  : 2015-10-11
# shuffle random source file (zip format expected)

function usage() {
    echo "Usage: $0 ZIP_FILE"
    exit 0
}

if [ $# -eq 0 ]; then
    usage
fi

random_souce=$1
if [ ! -f "$random_souce" ]; then
    usage
fi

if ! file "$random_souce" | grep -Fq "Zip archive data"; then
    usage
fi

# example of $colSeq: $2,$1,$3,$9,$10,$5,$8,$6,$4,$7
colSeq=$(Rscript -e 'cat(sample(10,10))' | sed -e 's/\b\([0-9]\)/$\1/g' -e 's/ /,/g')

tempfile=$(mktemp)
# 先按列打乱，再按行打乱
unzip -qc $random_souce | awk '{print '$colSeq'}' | shuf > $tempfile
split -a1 -n2 $tempfile ${tempfile}.

rev ${tempfile}.a > $tempfile
cat ${tempfile}.b >> $tempfile

rm ${tempfile}.*
shuf $tempfile | sed 's/ //g' | tr -d '\n'

rm $tempfile
