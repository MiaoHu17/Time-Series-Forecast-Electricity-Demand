#
#Team 5 project
#
# Program: Smoothing.R
#
# Purpose: Conduct Tbats on the given dataset.
#
# Written by: Miao Hu, 16 March 2019
# 
# ------------------------------------------------------
#

source("ReadData.R")
source("DataClean.R")
source("Holidays.R")
source("SplitData.R")

#Suggest seasonalities
par(mfrow(1,1),cex=1.5)
ACF7 <- acf(CE.training.ts)
ACF365 <- acf(CE.training.ts,730)

CE.training.ts1 <- msts(window(CE.ts3, start = "2008-01-01",end = "2013-12-31"), seasonal.periods = c(7,365))

#Tbats

CE.validation.observed <- CE.validation
CE.tbats <- subset(CE.daily3, CE.daily3$Date > "2007-12-31" & CE.daily3$Date <= "2013-12-31")
CE.tbats[[1]] <- as.Date(CE.tbats[[1]],"%Y-%m-%d")
up.tbats <- data.frame()
low.tbats <- data.frame()
CE.tbats1 <- data.frame()

for( i in (1:365)){
Tbats.timeSeries <- timeSeries(CE.tbats[[2]],CE.tbats[[1]])
Tbats.ts <- msts(Tbats.timeSeries, seasonal.periods = c(7,365))
Tbats <- tbats(Tbats.ts,use.box.cox = FALSE, use.parallel = TRUE, num.cores=8)
Load <- as.numeric(forecast(Tbats,h=1)[[2]])
up <- data.frame(forecast(Tbats,h=1)[[6]])
low <- data.frame(forecast(Tbats,h=1)[[7]])
up.tbats <- rbind(up.tbats,up)
low.tbats <- rbind(low.tbats,low)
tbats.data.frame <- data.frame(tail(CE.tbats,1)[[1]]+1,Load)
names(tbats.data.frame) <- c("Date","Load")
CE.tbats1 <- rbind(CE.tbats1,tbats.data.frame)
CE.tbats <- rbind(CE.tbats,CE.validation.observed[i,])
CE.tbats <- CE.tbats[-1,]
i =i + 1
}

CE.tbats2 <- as.list(CE.tbats1)
CE.tbats2[[2]] <- CE.tbats1[[2]][substr(as.character(CE.tbats1[[1]]),6,10)!="02-29"]
CE.tbats2[[1]] <- CE.tbats1[[1]][substr(as.character(CE.tbats1[[1]]),6,10)!="02-29"]
CE.tbats1 <- as.data.frame(CE.tbats1)

up.tbats1.80 <- up.tbats[[1]]
low.tbats1.80 <- low.tbats[[1]]
up.tbats1.80df <- data.frame(c(2191:3285),up.ets1.80)
up.tbats1.80ts <- ts(up.tbats[[1]],start=2191)
low.tbats1.80ts <- ts(low.tbats[[1]],start=2191)
up.tbats1.95ts <- ts(up.tbats[[2]],start=2191)
low.tbats1.95ts <- ts(low.tbats[[2]],start=2191)
CE.tbats2 <- (up.tbats[[1]]+low.tbats[[1]])/2
CE.tbats3 <- (up.tbats[[1]]+low.tbats[[1]])/2
CE.tbats2 <- cbind(CE.validation.observed[[1]],CE.tbats2)
CE.tbats2 <- as.data.frame(CE.tbats2)
names(CE.tbats2) <- c("Date","Load")
CE.tbats2.ts <- ts(CE.tbats3,start =2191)
CE.validation.observed.ts <- ts(CE.validation.observed[[2]],start=2191)
plot(CE.ets.training.ts,xlim = c(1825,3285),ylim=c(200000,500000),main="Forecast of TBATS",ylab="Daily demand in ComEd")
lines(CE.validation.observed.ts,col=1)
lines(up.tbats1.80ts,col="gray79",cex =0.5,lty=1)
lines(low.tbats1.80ts,col="gray79",cex =0.5,lty=1)
lines(up.tbats1.95ts,col="gray40",cex =0.5,lty=1)
lines(low.tbats1.95ts,col="gray40",cex =0.5,lty=1)
lines(CE.tbats2.ts,col="blue")
legend(2250,525000,legend=c("80% Interval","95% Interval","Observed Value","Forecast Value"),col=c("grey","dimgray","black","blue"),lty=1,bty="n",xpd =T)


#Performance
bias_tbats <- mean(as.numeric(CE.training.forecast[[2]])-as.numeric(CE.validation.observed[[2]]))
pbias_tbats <- mean((as.numeric(CE.training.forecast[[2]])-as.numeric(CE.validation.observed[[2]]))/as.numeric(CE.validation.observed[[2]])*100)
mape_tbats <- mean(abs(((as.numeric(CE.tbats2[[2]])-as.numeric(CE.validation.observed[[2]]))/as.numeric(CE.validation.observed[[2]])*100)))
rmse_tbats <- sqrt(mean(((as.numeric(CE.training.forecast[[2]])-as.numeric(CE.validation.observed[[2]]))^2)))

dev.off(dev.cur())
