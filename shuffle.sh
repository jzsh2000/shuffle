#!/bin/bash

# Author: JIN Xiaoyang
# Date  : 2015-10-10
# bash 版洗牌方案

if [ $# -eq 0 ]; then
    echo "Usage: $0 [NUMBER]"
    exit 0;
else
    rep=$1
fi

OriginArr=(
S2 S3 S4 S5 S6 S7 S8 S9 S0 SJ SQ SK SA H2 H3 H4 H5 H6 H7 H8 H9 H0 HJ HQ HK HA C2 C3 C4 C5 C6 C7 C8 C9 C0 CJ CQ CK CA D2 D3 D4 D5 D6 D7 D8 D9 D0 DJ DQ DK DA
)

for rep_i in $(seq $rep)
do
    echo "${OriginArr[@]}" | tr ' ' '\n' | shuf | tr '\n' ' ' | cut -d' ' -f1-26
done
