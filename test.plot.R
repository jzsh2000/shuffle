#!/usr/bin/env Rscript

# Author: JIN Xiaoyang
# Date  : 2015-10-14
# 根据试验的测试数据生成图片

args=commandArgs(trailingOnly = TRUE)

usage <- function() {
    cat("Usage: $0 [shuffle.test]\n")
    q()
}

if (length(args)==0) {
    usage()
}

if (!file.exists(args[1])) {
    cat(paste("Cannot read file:", args[1], "\n"))
    q()
}

testfile=args[1]
# columns: card | freq | pos | test | test.conf
testdata <- read.delim(testfile)

testdata$test.conf[testdata$test<0.0001]="0.0001"
testdata$test.conf[testdata$test>=0.0001]="0.001"
testdata$test.conf[testdata$test>=0.001]="0.01"
testdata$test.conf[testdata$test>=0.01]="0.05"
testdata$test.conf[testdata$test>=0.05]="1"

library(ggplot2, quietly=TRUE, warn.conflicts=FALSE)

plot.obj <- ggplot(testdata, aes(x=pos, y=freq, fill=test.conf))+scale_fill_manual(values=c("0.0001"="red","0.001"="magenta","0.01"="burlywood","0.05"="darkseagreen","1"="deepskyblue"), limits = c("0.0001", "0.001", "0.01", "0.05", "1"))+geom_bar(stat="identity", colour="white", width=1)+scale_x_continuous(breaks=1:max(testdata$pos))
ggsave(plot = plot.obj, filename=paste0(testfile,".pdf"), height=6, width=8)

detach('package:ggplot2')
