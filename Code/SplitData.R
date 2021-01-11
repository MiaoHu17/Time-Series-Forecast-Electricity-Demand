#
#Team 5 project
#
# Program: SplitData.R
#
# Purpose: Split the data into 2 parts, training dataset and validation dataset
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
#

source("ReadData.R")
source("DataClean.R")
source("Holidays.R")

#Combine the CE.daily3 with the Holiday Data
CE.daily3$Time <- as.character(CE.daily3[[1]])
names(CE.daily3)[1] <- "Date"
CE.training <- subset(CE.daily3, CE.daily3$Date <= "2013-12-31")
CE.validation <- subset(CE.daily3, CE.daily3$Date > "2013-12-31" & CE.daily3$Date <= "2016-12-31")
CE.test <- subset(CE.daily3, CE.daily3$Date > "2016-12-31")
CE.ts3 <- timeSeries(CE.daily3[2],CE.daily3[[1]])
CE.ts4 <- ts(CE.ts3,frequency = 1)
CE.training.ts <- ts(window(CE.ts3, start = "2005-01-01",end = "2013-12-31"))
CE.validation.ts <- ts(window(CE.ts3, start = "2014-01-01",end = "2016-12-31"))
CE.test.ts <- ts(window(CE.ts3, start = "2017-01-01",end = "2019-01-31"))

CE.training.timeSeries <- timeSeries(CE.training[[2]],CE.training[[1]])
CE.validation.timeSeries <- timeSeries(CE.validation[[2]],CE.validation[[1]])
CE.test.timeSeries <- timeSeries(CE.test[[2]],CE.test[[1]])

Weather.training <- subset(Weather, Weather$Date <= "2013-12-31")
Weather.validation <- subset(Weather, Weather$Date > "2013-12-31" & Weather$Date <= "2016-12-31")
Weather.test <- subset(Weather, Weather$Date > "2016-12-31" & Weather$Date <= "2019-01-31")

Weather.training.temp <- timeSeries(Weather.training[[2]],Weather.training[[1]])
Weather.validation.temp <- timeSeries(Weather.validation[[2]],Weather.validation[[1]])
Weather.test.temp <- timeSeries(Weather.test[[2]],Weather.test[[1]])

Weather.training.pre <- timeSeries(Weather.training[[5]],Weather.training[[1]])
Weather.validation.pre <- timeSeries(Weather.validation[[5]],Weather.validation[[1]])
Weather.test.pre <- timeSeries(Weather.test[[5]],Weather.test[[1]])

Weather.training.hum <- timeSeries(Weather.training[[7]],Weather.training[[1]])
Weather.validation.hum <- timeSeries(Weather.validation[[7]],Weather.validation[[1]])
Weather.test.hum <- timeSeries(Weather.test[[7]],Weather.test[[1]])

Weather.training.wd <- timeSeries(Weather.training[[8]],Weather.training[[1]])
Weather.validation.wd <- timeSeries(Weather.validation[[8]],Weather.validation[[1]])
Weather.test.wd <- timeSeries(Weather.test[[8]],Weather.test[[1]])

Weather.training.hdd <- timeSeries(Weather.training[[3]],Weather.training[[1]])
Weather.validation.hdd <- timeSeries(Weather.validation[[3]],Weather.validation[[1]])
Weather.test.hdd <- timeSeries(Weather.test[[3]],Weather.test[[1]])

Weather.training.cdd <- timeSeries(Weather.training[[4]],Weather.training[[1]])
Weather.validation.cdd <- timeSeries(Weather.validation[[4]],Weather.validation[[1]])
Weather.test.cdd <- timeSeries(Weather.test[[4]],Weather.test[[1]])

Weather.training.ts <- ts(window(Weather.ts, start = "2005-01-01",end = "2013-12-31"))
Weather.validation.ts <- ts(window(Weather.ts, start = "2014-01-01",end = "2016-12-31"))
Weather.test.ts <- ts(window(Weather.ts, start = "2017-01-01",end = "2019-01-31"))
