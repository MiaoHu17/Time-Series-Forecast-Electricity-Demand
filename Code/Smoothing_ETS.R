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



#Tbats
CE.training.ts1 <- msts(CE.training.ts,seasonal.periods = c(7,365))

CE.training.tbats <- tbats(CE.training.ts1,use.arma.errors = TRUE)
components <- tbats.components(CE.training.tbats)
plot(components)
CE.training.forecast <- forecast(CE.training.tbats,model = "tbats", h=1095)
CE.validation.observed <- CE.validation
CE.validation.observed[[1]] <- (as.numeric(row.names(CE.validation.observed))/365)+1
plot(CE.training.forecast,xlim=c(8,13),ylim=c(200000, 500000))
lines(CE.validation.observed,col=10)


#Performance
bias_tbats <- mean(as.numeric(CE.training.forecast[[2]])-as.numeric(CE.validation.observed[[2]]))
pbias_tbats <- mean((as.numeric(CE.training.forecast[[2]])-as.numeric(CE.validation.observed[[2]]))/as.numeric(CE.validation.observed[[2]])*100)
mape <- mean(abs(((as.numeric(CE.training.forecast[[2]])-as.numeric(CE.validation.observed[[2]]))/as.numeric(CE.validation.observed[[2]])*100)))


#ETS
CE.ets.training <- subset(CE.daily3, CE.daily3$Date > "2007-12-31" & CE.daily3$Date <= "2013-12-31")
CE.ets <- subset(CE.daily3, CE.daily3$Date > "2007-12-31" & CE.daily3$Date <= "2013-12-31")
CE.ets[[1]] <- as.Date(CE.ets[[1]],"%Y-%m-%d")
up.ets <- data.frame()
low.ets <- data.frame()
CE.ets1 <- data.frame()

for( i in (1:1096)){
  Ets.timeSeries <- timeSeries(CE.ets[[2]],CE.ets[[1]])
  Ets.ts <- msts(Ets.timeSeries, seasonal.periods = c(7,365))
  Ets <- stlf(Ets.ts,h=1)
  Load <- as.numeric(Ets[[2]])
  up <- data.frame(Ets[[5]])
  low <- data.frame(Ets[[6]])
  up.ets <- rbind(up.ets,up)
  low.ets <- rbind(low.ets,low)
  ets.data.frame <- data.frame(tail(CE.ets,1)[[1]]+1,Load)
  names(ets.data.frame) <- c("Date","Load")
  CE.ets1 <- rbind(CE.ets1,ets.data.frame)
  CE.ets <- rbind(CE.ets,CE.validation.observed[i,])
  CE.ets <- CE.ets[-1,]
  i =i + 1
}

up.ets1.80 <- up.ets[[1]]
low.ets1.80 <- low.ets[[1]]
up.ets1.80 <- up.ets1.80[-790]
low.ets1.80 <- low.ets1.80[-790]
up.ets1.80df <- data.frame(c(2191:3285),up.ets1.80)
up.ets1.80ts <- ts(up.ets[[1]],start=2191)
low.ets1.80ts <- ts(low.ets[[1]],start=2191)
up.ets1.95ts <- ts(up.ets[[2]],start=2191)
low.ets1.95ts <- ts(low.ets[[2]],start=2191)
CE.ets2 <- as.list(CE.ets1)
CE.ets2[[2]] <- CE.ets2[[2]][substr(as.character(CE.ets2[[1]]),6,10)!="02-29"]
CE.ets2[[1]] <- CE.ets2[[1]][substr(as.character(CE.ets2[[1]]),6,10)!="02-29"]
CE.ets2 <- as.data.frame(CE.ets2)
CE.ets2 <- merge(CE.ets1,CE.ets.training, id = "Date",all=T)
CE.ets2 <- subset(CE.ets1, CE.ets1$Date >"2013-12-31")
CE.ets2.ts <- ts(CE.ets1[[2]],start = 2191)
CE.ets.training[[2]] <- as.numeric(CE.ets.training[[2]])
CE.ets.training[[1]] <- as.character(CE.ets.training[[1]])
CE.ets.training.ts <- ts(CE.ets.training[[2]])
CE.validation.observed.ts <- ts(CE.validation.observed[[2]],start=2191)
plot(CE.ets.training.ts,xlim = c(1825,3285),ylim=c(200000,500000))
lines(CE.validation.observed.ts,col=1)
lines(up.ets1.80ts,col="gray79",cex =0.5,lty=1)
lines(low.ets1.80ts,col="gray79",cex =0.5,lty=1)
lines(up.ets1.95ts,col="gray40",cex =0.5,lty=1)
lines(low.ets1.95ts,col="gray40",cex =0.5,lty=1)
lines(CE.ets1.ts,col="blue")
legend(1750,525000,legend=c("80% Interval","95% Interval","Observed Value","Forecast Value"),col=c("grey","dimgray","black","blue"),lty=1,bty="n",xpd =T)

mape_ets <- mean(abs(as.numeric((CE.ets2[[2]]-CE.validation.observed[[2]])/CE.validation.observed[[2]])))*100
