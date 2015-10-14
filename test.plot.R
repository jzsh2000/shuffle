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
testdata <- read.delim(testfile, colClasses=c("factor","numeric","numeric","numeric","factor"))

library(ggplot2, quietly=TRUE, warn.conflicts=FALSE)

plot.obj <- ggplot(testdata, aes(x=pos, y=freq, fill=test.conf))+geom_bar(stat="identity", colour="white", width=1)+scale_x_continuous(breaks=1:max(testdata$pos))
ggsave(plot = plot.obj, filename=paste0(testfile,".pdf"), height=6, width=8)

detach('package:ggplot2')
