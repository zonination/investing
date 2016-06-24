# Set working directory, and import libraries:
setwd("~/Dropbox/R/Stock Market")
library(ggplot2)
library(scales)
library(lubridate)
source("z_theme.r")

# The following data source:
# I strongly recommend using the github link below, since the sp500 data is
# actively maintained. My data is updated only occasionally
# "https://raw.githubusercontent.com/datasets/s-and-p-500/master/data/data.csv"
sp500<-read.csv("stocks.csv", stringsAsFactors=FALSE)

# If you're not regenerating the link above, comment this part out
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

# A quick plot to show Real Index
# ggplot(sp500,aes(Date,real.return))+
#   geom_line()+
#   scale_y_log10()

# A quick visual of the history
# ggplot(sp500,aes(Date,SP500/Consumer.Price.Index))+
#   geom_line()+
#   scale_y_log10()+
#   geom_smooth(method="lm")

# Master Loop
stocks<-data.frame(NA,NA,NA,NA)
names(stocks)<-c("year","real","percent","inv.year")
for(f in 1:145){
  sp500$future.f<-NA    #Future S&P Price
  sp500$cpi.f <- NA     #Future CPI
  sp500$future.r <- NA  #Future Real Returns
  for(n in (f*12+1):nrow(sp500)){
    # Get values for "f" years in the future
    sp500$future.f[n-f*12] <- sp500$SP500[n]                      # Work our Future S&P Price into its own column
    sp500$cpi.f[n-f*12] <- sp500$Consumer.Price.Index[n]          # Work the Future CPI into its own column
    sp500$future.r[n-f*12] <- sp500$real.return[n]                # Work the Real Returns into its own column
    stocks<-rbind(stocks,c(f,sp500$future.r[n-f*12],                   # Record all history
                  (sp500$future.r[n-f*12]-sp500$real.return[n-f*12]) /
                    sp500$real.return[n-f*12],
                  year(sp500$Date[n-f*12])
                  ))
  }
  print(paste(f, " of ", 145, " completed: ", round(f/145*100,2),"%",sep=""))
  
# Scatterplot for Gains vs. Date of Investment
  #   if(f<10){png(file=paste("geom_point0",f,".png",sep=""), width=700, height=500)} #Append a 0 to the file number to prevent issues when meshing images into gifs.
  #   else{png(file=paste("geom_point",f,".png",sep=""), width=700, height=500) }
  #   print(
  #     ggplot(sp500,aes(Date,
  #                      #Formula for nominal % Return
  #                      (future.f - SP500) /
  #                        (SP500)
  #                      ))+
  #       geom_point(alpha=.5,color="limegreen",size=3)+
  #       ggtitle("Gains S&P500 (Experimental ONLY)")+
  #       xlab("Date of investment")+
  #       ylab(paste("Returns after",f,"years of investing"))+
  #       geom_hline(yintercept=
  #                    mean(
  #           (sp500$future.f-sp500$SP500)/sp500$SP500,
  #           na.rm=TRUE)
  #           ,linetype=4)+
  #       scale_y_continuous(limits=c(-5,30),labels=percent)+
  #       geom_rug(sides="r",size=1,alpha=.2,color="limegreen")
  #   )
  #   print(paste("Scatterplot",f,"complete."))
  #   dev.off()
  # 
  # #Scatterplot for Real Return vs. Date of Investment
  #   if(f<10){png(file=paste("geom_real0",f,".png",sep=""), width=700, height=500)}
  #   else{png(file=paste("geom_real",f,".png",sep=""), width=700, height=500) }
  #   print(
  #     ggplot(sp500,aes(Date,
  #                      #Formula for % Return
  #                      (future.r - real.return) /
  #                        (real.return)
  #     ))+
  #       geom_point(alpha=.5,color="limegreen",size=2)+
  #       ggtitle("Real Returns for the US Stock Market")+
  #       xlab("Date of investment")+
  #       ylab(paste("Real Returns after",f,"years of investing (%)"))+
  #        geom_hline(yintercept=
  #                     mean(
  #                       (sp500$future.r-sp500$real.return)/sp500$real.return,
  #                       na.rm=TRUE)
  #                   ,linetype=4,alpha=.3)+
  #       scale_y_continuous(limits=c(-2,50),labels=percent)+
  #       geom_rug(sides="r",size=.5,alpha=.1,color="limegreen")+
  #       z_theme()
  #   )
  #   print(paste("Realplot",f,"complete."))
  #   dev.off()
  # 
  # #Histogram for Gains !!! REPLACED BY GEOM_RUG()
  # if(f<10){png(file=paste("geom_histogram0",f,".png",sep=""), width=700, height=500)}
  # else{png(file=paste("geom_histogram",f,".png",sep=""), width=700, height=500) }
  # print(
  #   ggplot(sp500,aes(
  #                    #Formula for nominal % Return
  #                    (future.r - real.return) /
  #                      real.return
  #     ))+
  #     geom_vline(xintercept=
  #                  mean(
  #                    (sp500$future.r-sp500$real.return)/sp500$real.return,
  #                    na.rm=TRUE)
  #                ,linetype=4,alpha=.3)+
  #     geom_histogram(alpha=.5,fill="limegreen")+
  #     ggtitle("Gains S&P500 (Experimental Data)")+
  #     xlab(paste("Returns after",f,"years of investing"))+
  #     ylab(paste("Number of Occurrences"))+
  #     scale_y_continuous(breaks=NULL)+
  #     scale_x_continuous(limits=c(-2,50),labels=percent)+
  #     z_theme()
  # )
  # print(paste("Histogram",f,"complete."))
  # dev.off()

}

# system("convert -delay 10 geom_hist*.png histoblob.gif")
# system("convert -delay 10 geom_real*.png real.gif")
# system("rm geom*.png") #Works only on Linux and Mac

# Use a cash multiplier instead of a percent:
stocks$multip<-stocks$percent+1
write.table(stocks,"returns.csv")

ggplot(stocks,aes(x=year,y=multip,group=year),na.rm=T)+
# geom_boxplot(outlier.shape=NA,coef=0,fatten=0,fill="steelblue",color=NA)+
  geom_jitter(color="limegreen",alpha=.05,width=1)+
  ggtitle("Returns After Investing")+
  stat_summary(fun.y="mean",colour="black",fill="limegreen",geom="point",shape=21)+
  ylab("Cash Multiplier, after Inflation and Dividends")+
  xlab("Years Invested in US Stocks")+
  scale_y_log10(breaks=2^c(-5:100))+
  scale_x_continuous(breaks=seq(0,200,5))+
#  scale_color_distiller(palette="Spectral")+
#  scale_y_continuous(limits=c(-5,5))+
  geom_smooth()+
  z_theme()