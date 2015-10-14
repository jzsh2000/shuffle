#!/usr/bin/env Rscript

# Author: JIN Xiaoyang
# Date  : 2015-10-14
# 组合多次试验的测试数据

args=commandArgs(trailingOnly = TRUE)

usage <- function() {
    cat("Usage: $0 [shuffle.test]...\n")
    q()
}

if (length(args)==0) {
    usage()
}

for (testfile in args) {
    if (!file.exists(testfile)) {
	cat(paste0("WARNING: cannot read file: ", testfile, "\n"))
	next
    } else {
	testdata.tmp <- read.delim(testfile)

	# columns: card | freq | pos
	testdata.tmp = testdata.tmp[,1:3]

	if(!exists("testdata")) {
	    testdata=testdata.tmp
	} else {
	    testdata=rbind(testdata, testdata.tmp)
	}
    }
}

if (!exists("testdata.tmp")) {
    usage()
} else {
    rm(testdata.tmp)
}

library(plyr, quietly=TRUE, warn.conflicts=FALSE)
testdata <- ddply(testdata, .(card, pos), function(x){sum(x$freq)})
names(testdata)[3]="freq"
testdata = testdata[,c(1,3,2)]
testdata = arrange(testdata, pos)

# 总的牌数
testdata.cards <- length(table(testdata$card))

# 总的重复次数
testdata.rep <- sum(testdata$freq)/max(testdata$pos)

# The step below is very slow
testdata$test <- sapply(testdata$freq, function(x){binom.test(x, testdata.rep, p = 1/testdata.cards)$p.value})
write.table(testdata, "poker.test.txt", sep="\t", quote=FALSE, row.names=FALSE)

testdata$test.conf[testdata$test<0.0001]="0.0001"
testdata$test.conf[testdata$test>=0.0001]="0.001"
testdata$test.conf[testdata$test>=0.001]="0.01"
testdata$test.conf[testdata$test>=0.01]="0.05"
testdata$test.conf[testdata$test>=0.05]="1"

library(ggplot2, quietly=TRUE, warn.conflicts=FALSE)
plot.obj <- ggplot(testdata, aes(x=pos, y=freq, fill=test.conf))+geom_bar(stat="identity", colour="white", width=1)+scale_x_continuous(breaks=1:max(testdata$pos))
ggsave(plot = plot.obj, filename="poker.test.pdf", height=6, width=8)

detach('package:plyr')
detach('package:ggplot2')
