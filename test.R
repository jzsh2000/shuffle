#!/usr/bin/env Rscript

# Author: JIN Xiaoyang
# Date  : 2015-10-10
# 评估洗牌算法效果

args=commandArgs(trailingOnly = TRUE)

if (length(args)==0) {
    cat("Usage: $0 [shuffle.out.txt]\n")
    q()
}

if (!file.exists(args[1])) {
    cat(paste("Cannot read file:", args[1], "\n"))
    q()
}

shuffle.file=args[1]
shuffle.length=as.numeric(args[2])
if(is.na(shuffle.length)||!is.numeric(shuffle.length)) {
    shuffle.length = -1
}

shuffle.out <- read.table(shuffle.file, nrow=shuffle.length)
shuffle.length <- nrow(shuffle.out)
# shuffle.out <- as.data.frame(lapply(shuffle.out, function(x){x<-factor(x, levels=cards)}))
# print(head(shuffle.out))

shape=c("S","H","C","D")
value=c(2:9,0,"J","Q","K","A")
# 长度为52的向量，分别表示每张牌
cards <- unlist(lapply(shape, function(x){paste0(x, value)}))

for(pos in 1:ncol(shuffle.out)) {
    freq.pos.table <- table(shuffle.out[,pos])
    # print(freq.pos.table)
    freq.pos.frame <- data.frame(card=names(freq.pos.table), freq=as.vector(freq.pos.table), pos=pos)
    freq.pos.frame$test <- sapply(freq.pos.frame$freq, function(x){binom.test(x, sum(freq.pos.frame$freq), p = 1/length(cards))$p.value})
    freq.pos.frame$test.conf[freq.pos.frame$test<0.0001]="0.0001"
    freq.pos.frame$test.conf[freq.pos.frame$test>=0.0001]="0.001"
    freq.pos.frame$test.conf[freq.pos.frame$test>=0.001]="0.01"
    freq.pos.frame$test.conf[freq.pos.frame$test>=0.01]="0.05"
    freq.pos.frame$test.conf[freq.pos.frame$test>=0.05]="1"

    if(!exists("freq.frame")) {
	freq.frame = freq.pos.frame
    } else {
	freq.frame = rbind(freq.frame, freq.pos.frame)
    }
}

write.table(freq.frame, paste0(shuffle.file,".",shuffle.length,".test"), sep="\t", quote=FALSE, row.names=FALSE)

library(ggplot2, quietly=TRUE, warn.conflicts=FALSE)

plot.obj <- ggplot(freq.frame, aes(x=pos, y=freq, fill=card))+geom_bar(stat="identity", colour="white", width=1)+guides(fill=FALSE)+scale_x_continuous(breaks=1:26)
ggsave(plot = plot.obj, filename=paste0(shuffle.file,".",shuffle.length,".pdf"), height=6, width=8)

plot.obj <- ggplot(freq.frame, aes(x=pos, y=freq, fill=test.conf))+geom_bar(stat="identity", colour="white", width=1)+scale_x_continuous(breaks=1:26)
ggsave(plot = plot.obj, filename=paste0(shuffle.file,".",shuffle.length,".test.pdf"), height=6, width=8)

detach('package:ggplot2')
