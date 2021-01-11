#
#Team 5 project
#
# Program: SARIMA.R
#
# Purpose: Introduce the Holidays and Day of Week into our data
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
#

source("ReadData.R")
source("DataClean.R")
source("SplitData.R")

library(arfima)

ARIMA <- auto.arima(CE.training.timeSeries)

SARIMAAICC <- data.frame()
SARIMAAICC1 <- data.frame()

for(a in (0:6))
  for(b in (0:1))
    for(c in (0:6))
      for(d in (0:3))
        for(e in (0:1))
          for(f in (0:3)){
          SARIMA <- sarima(CE.training.timeSeries,a,b,c,d,e,f,7)
          SARIMAAICC  <- rbind(SARIMAAICC,c(SARIMA[[4]],SARIMA[[5]],SARIMA[[6]]))
          SARIMAAICC1  <- rbind(SARIMAAICC1,paste(a,b,c,d,e,f), stringsAsFactors = F )  
          names(SARIMAAICC1) <- ("Order")
          }
            


SARIMA1 <- sarima(CE.training.timeSeries,0,0,2,4,0,4,7)
SARI
