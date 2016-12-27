# NOTICE: This code is probably poorly-written garbage. Try to understand
# it at your own risk.

# Set working directory, and import libraries:
# setwd("~/Dropbox/R/Stock Market")
library(ggplot2)
library(scales)
library(lubridate)
source("z_theme.r")

# The following data source:
# I strongly recommend using the github link below, since the sp500 data is
# actively maintained. My data is updated only occasionally
# "https://raw.githubusercontent.com/datasets/s-and-p-500/master/data/data.csv"
sp500<-read.csv("stocks.csv", stringsAsFactors=FALSE)

# If you're not regenerating the source data, comment this part out
# and Uncomment the "Master Loop" section below
# stocks<-read.csv("returns.csv", stringsAsFactors=FALSE)

# Doing stuff with dates:
# Reformatting the dates to make it readable by the system.
sp500$Date<-as.Date(sp500$Date,"%Y-%m-%d") 

# S&P 500 was started in 1923; prior history is from Shiller. If you
# only want the "real" sp500 values, uncomment the line below:
# sp500<-subset(sp500,sp500$Date >= as.Date("1926-01-01","%Y-%m-%d"))

#Calculate real returns (Reinvested dividends)
sp500$real.return <- 1 # Start with initial conditions. I invest one dollar at the beginning of the stock market.
for(r in 2:nrow(sp500)){
  sp500$real.return[r]<-
    # Start with previous value:
    sp500$real.return[r-1]*
    # Multiply it by the % change in stock value in the last month:
    (((sp500$Real.Price[r]-sp500$Real.Price[r-1])/
        (sp500$Real.Price[r-1]))+1)+
    # Finally, add last month's dividends to the party; they get reinvested:
    (sp500$Real.Dividend[r-1]/sp500$Real.Price[r-1])*
    (sp500$real.return[r-1]/12)
}

# Master Loop
# If you're not regenerating the source data, uncomment this part
# Warning: May take a very long time to solve.
###############
stocks<-data.frame(NA,NA,NA,NA)
names(stocks)<-c("year","real","percent","inv.date")
for(f in 0:nrow(sp500)){
  sp500$future.f<-NA    #Future S&P Price
  sp500$cpi.f <- NA     #Future CPI
  sp500$future.r <- NA  #Future Real Returns
  buffer<-data.frame(NA,NA,NA,NA)
  names(buffer)<-c("year","real","percent","inv.date")
  for(n in (f+1):nrow(sp500)){
    # Get values for "f" years in the future
    sp500$future.f[n-f] <- sp500$SP500[n]                      # Work our Future S&P Price into its own column
    sp500$cpi.f[n-f] <- sp500$Consumer.Price.Index[n]          # Work the Future CPI into its own column
    sp500$future.r[n-f] <- sp500$real.return[n]                # Work the Real Returns into its own column
    buffer<-rbind(buffer,c(f/12,sp500$future.r[n-f],                   # Record all history
                  (sp500$future.r[n-f]-sp500$real.return[n-f]) /
                    sp500$real.return[n-f],
                  as.character(sp500$Date[n-f])
                  ))
  }
  stocks<-rbind(stocks,buffer)
  print(paste(f, " of ", nrow(sp500), " completed: ", signif(f*100/nrow(sp500),4),"%",sep=""))}
stocks<-subset(stocks,!is.na(stocks$percent))
rm(buffer)
# Use a cash multiplier instead of a percent:
stocks$multip<-as.numeric(stocks$percent)+1
stocks$year<-as.numeric(stocks$year)
stocks$real<-as.numeric(stocks$real)
stocks$percent<-as.numeric(stocks$percent)
# write.table(stocks,"returns.csv",sep=",")

ggplot(subset(stocks, year<=40),aes(x=year,y=multip),na.rm=T)+
# geom_boxplot(outlier.shape=NA,coef=0,fatten=0,fill="steelblue",color=NA)+
# geom_jitter(color="limegreen",alpha=.05,width=1,group=year)+
  geom_path(aes(group=inv.date),color="limegreen",alpha=.05)+
# Add a trackline for investment date on line below:
#  geom_path(data=subset(stocks, inv.date=="1942-01-01" & year<=50),aes(group=inv.date),color="black")+
  stat_summary(fun.y="mean",colour="black",geom="line")+
  labs(title="Returns After Investing",
       subtitle="Buy and Hold Strategy",
       x="Years Invested in US Stocks",
       y="Cash Multiplier (After Inflation and Dividends)",
       caption="Created by /u/zonination")+
  scale_y_log10(breaks=2^c(-3:15),
                # Force character, because otherwise the plot shows extra
                # `.00` where not wanted.
                labels=as.character(2^c(-3:15)))+
 scale_x_continuous(breaks=seq(0,200,5))+
  z_theme()
ggsave("returns-40yr.png",height=9,width=16,dpi=100,type="cairo-png")
