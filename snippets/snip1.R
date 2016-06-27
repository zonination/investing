# Load libraries
# setwd("~/Dropbox/R/Stock Market")
# library(ggplot2)
# library(scales)
# source("z_theme.r")
# stocks<-read.csv("returns.csv", stringsAsFactors=FALSE)

stockrisk<-matrix(NA,nrow=21,ncol=3)
stockrisk<-as.data.frame(stockrisk)
names(stockrisk)<-c("year","chance","nochance")

for(n in 1:21){
  stockrisk$chance[n]<-
    length(subset(stocks,multip<1&year==n)$year)/length(subset(stocks,year==n)$year)
  stockrisk$year[n]<-n
  stockrisk$nochance[n]<-1-stockrisk$chance[n]
}

ggplot(stockrisk,aes(year,chance))+
  geom_line()+
  scale_y_continuous(labels=scales::percent)+
  ggtitle("Chance of Losing in the Stock Market")+
  ylab("Chance of Loss")+
  xlab("Years Invested")+
# scale_y_continuous(limits=c(0,1))+
  z_theme()
