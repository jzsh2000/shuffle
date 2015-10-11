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
# 先按列打乱，再按行打乱。源文件示例：
## 1415926535 8979323846 2643383279 5028841971 6939937510 5820974944 5923078164 0628620899 8628034825 3421170679 : 1
## 8214808651 3282306647 0938446095 5058223172 5359408128 4811174502 8410270193 8521105559 6446229489 5493038196 : 2
## 4428810975 6659334461 2847564823 3786783165 2712019091 4564856692 3460348610 4543266482 1339360726 0249141273 : 3
unzip -qc $random_souce | awk '{print '$colSeq'}' | shuf > $tempfile
split -a1 -n2 $tempfile ${tempfile}.

# 将一个子文件的所有行反序，另一个子文件保持原样
rev ${tempfile}.a > $tempfile
cat ${tempfile}.b >> $tempfile

rm ${tempfile}.*
# 再按行打乱一次，然后删除文件中的空格及换行符。这样文件中仅存在数字
shuf $tempfile | sed 's/ //g' | tr -d '\n'

rm $tempfile
