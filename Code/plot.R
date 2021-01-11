#
#Team 5 project
#
# Program: plot.R
#
# Purpose: plot all the graph we need
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
#

source("ReadData.R")
source("DataClean.R")
source("Naive.R")

#Output file for graphs
pdf("CE.pdf")

Table_mape <- matrix(c(mape_1_Training,mape_2_Training,mape_3_Training,mape_4_Training,
                       mape_1_Validation,mape_2_Validation,mape_3_Validation,mape_4_Validation),
                     ncol = 4,byrow=TRUE)

Table_rmse <- matrix(c(rmse_1_Training,rmse_2_Training,rmse_3_Training,rmse_4_Training,
                       rmse_1_Validation,rmse_2_Validation,rmse_3_Validation,rmse_4_Validation),
                     ncol = 4,byrow=TRUE)

Table_pbias <- matrix(c(pbias_1_Training,pbias_2_Training,pbias_3_Training,pbias_4_Training,
                        pbias_1_Validation,pbias_2_Validation,pbias_3_Validation,pbias_4_Validation),
                    ncol = 4,byrow=TRUE)

Table_bias <- matrix(c(bias_1_Training,bias_2_Training,bias_3_Training,bias_4_Training,
                       bias_1_Validation,bias_2_Validation,bias_3_Validation,bias_4_Validation),
                     ncol = 4,byrow=TRUE)

colnames(Table_mape)<-c("nc","sdLy","3dma","7dma")
rownames(Table_mape) <- c("Training","Validation")
colnames(Table_rmse)<-c("nc","sdLy","3dma","7dma")
rownames(Table_rmse) <- c("Training","Validation")
colnames(Table_pbias)<-c("nc","sdLy","3dma","7dma")
rownames(Table_pbias) <- c("Training","Validation")
colnames(Table_bias)<-c("nc","sdLy","3dma","7dma")
rownames(Table_bias) <- c("Training","Validation")

#plot the performance of Naive methods
par(mfrow = c(2,2))
barplot(Table_mape,xlab = "MAPE",col=c(grey(0.25),grey(0.5)),beside=TRUE)
barplot(Table_rmse,xlab = "RMSE",col=c(grey(0.25),grey(0.5)),beside=TRUE)
barplot(Table_pbias,xlab = "%Bias",col=c(grey(0.25),grey(0.5)),beside=TRUE)
barplot(Table_bias,xlab = "Bias",col=c(grey(0.25),grey(0.5)),legend=rownames(Table_bias),beside=TRUE,xpd=TRUE)

#Plot based on a yearly basis
subset2005 <- window(CE.ts, start = c(as.Date(as.character("2005-1-1"))), end = c(as.Date(as.character("2005-12-31"))))
subset2006 <- window(CE.ts, start = c(as.Date(as.character("2006-1-1"))), end = c(as.Date(as.character("2006-12-31"))))
subset2007 <- window(CE.ts, start = c(as.Date(as.character("2007-1-1"))), end = c(as.Date(as.character("2007-12-31"))))
subset2008 <- window(CE.ts, start = c(as.Date(as.character("2008-1-1"))), end = c(as.Date(as.character("2008-12-31"))))
subset2009 <- window(CE.ts, start = c(as.Date(as.character("2009-1-1"))), end = c(as.Date(as.character("2009-12-31"))))
subset2010 <- window(CE.ts, start = c(as.Date(as.character("2010-1-1"))), end = c(as.Date(as.character("2010-12-31"))))
subset2011 <- window(CE.ts, start = c(as.Date(as.character("2011-1-1"))), end = c(as.Date(as.character("2011-12-31"))))
subset2012 <- window(CE.ts, start = c(as.Date(as.character("2012-1-1"))), end = c(as.Date(as.character("2012-12-31"))))
subset2013 <- window(CE.ts, start = c(as.Date(as.character("2013-1-1"))), end = c(as.Date(as.character("2013-12-31"))))
subset2014 <- window(CE.ts, start = c(as.Date(as.character("2014-1-1"))), end = c(as.Date(as.character("2014-12-31"))))
subset2015 <- window(CE.ts, start = c(as.Date(as.character("2015-1-1"))), end = c(as.Date(as.character("2015-12-31"))))
subset2016 <- window(CE.ts, start = c(as.Date(as.character("2016-1-1"))), end = c(as.Date(as.character("2016-12-31"))))
subset2017 <- window(CE.ts, start = c(as.Date(as.character("2017-1-1"))), end = c(as.Date(as.character("2017-12-31"))))
subset2018 <- window(CE.ts, start = c(as.Date(as.character("2018-1-1"))), end = c(as.Date(as.character("2018-12-31"))))
subset2005Jan <- window(CE.ts, start = c(as.Date(as.character("2005-1-1"))), end = c(as.Date(as.character("2005-1-31"))))
subset2005Jul <- window(CE.ts, start = c(as.Date(as.character("2005-7-1"))), end = c(as.Date(as.character("2005-7-31"))))
subset2006Jan <- window(CE.ts, start = c(as.Date(as.character("2006-1-1"))), end = c(as.Date(as.character("2006-1-31"))))
subset2006Jul <- window(CE.ts, start = c(as.Date(as.character("2006-7-1"))), end = c(as.Date(as.character("2006-7-31"))))
subset2011Jan <- window(CE.ts, start = c(as.Date(as.character("2011-1-1"))), end = c(as.Date(as.character("2011-1-31"))))
subset2011Jul <- window(CE.ts, start = c(as.Date(as.character("2011-7-1"))), end = c(as.Date(as.character("2011-7-31"))))
subset2012Jan <- window(CE.ts, start = c(as.Date(as.character("2012-1-1"))), end = c(as.Date(as.character("2012-1-31"))))
subset2012Jul <- window(CE.ts, start = c(as.Date(as.character("2012-7-1"))), end = c(as.Date(as.character("2012-7-31"))))
subset2017Jan <- window(CE.ts, start = c(as.Date(as.character("2017-1-1"))), end = c(as.Date(as.character("2017-1-31"))))
subset2017Jul <- window(CE.ts, start = c(as.Date(as.character("2017-7-1"))), end = c(as.Date(as.character("2017-7-31"))))
subset2018Jan <- window(CE.ts, start = c(as.Date(as.character("2018-1-1"))), end = c(as.Date(as.character("2018-1-31"))))
subset2018Jul <- window(CE.ts, start = c(as.Date(as.character("2018-7-1"))), end = c(as.Date(as.character("2018-7-31"))))
subset2006JanWeeks <- window(CE.ts, start = c(as.Date(as.character("2006-1-2"))), end = c(as.Date(as.character("2006-1-22"))))


subset2005.ts <- as.ts(subset2005)
subset2006.ts <- as.ts(subset2006)
subset2007.ts <- as.ts(subset2007)

ts.plot(subset2005.ts,subset2006.ts,subset2007.ts,gpars=list(type = "p", pch = 23, col=c(4,5,6)))
#ACF&PACF
#pick up two month in summer in 2011
subset2011 <- window(CE.ts, start = c(as.Date(as.character("2011-1-1"))), end = c(as.Date(as.character("2011-12-31"))))

par(mfrow=c(1,1))
plot(subset2011,ylab="Demand for 2011.")
acf2(subset2011,main="Demand for 2011 adj.")

plot(CE.ts,ylab = "Daily Load of CE during 2005-2018")
plot(CETS, ylab = "Hourly Load of CE during 2005 - 2018")
plot(subset2005, ylab = "Daily Load of CE in 2005")
plot(subset2006, ylab = "Daily Load of CE in 2006")
plot(subset2007, ylab = "Daily Load of CE in 2007")
plot(subset2008, ylab = "Daily Load of CE in 2008")
plot(subset2009, ylab = "Daily Load of CE in 2009")
plot(subset2010, ylab = "Daily Load of CE in 2010")
plot(subset2011, ylab = "Daily Load of CE in 2011")
plot(subset2012, ylab = "Daily Load of CE in 2012")
plot(subset2013, ylab = "Daily Load of CE in 2013")
plot(subset2014, ylab = "Daily Load of CE in 2014")
plot(subset2015, ylab = "Daily Load of CE in 2015")
plot(subset2016, ylab = "Daily Load of CE in 2016")
plot(subset2017, ylab = "Daily Load of CE in 2017")
plot(subset2005Jan, ylab = "Daily Load of CE in 2005 January")
plot(subset2006Jan, ylab = "Daily Load of CE in 2006 January")
plot(subset2005Jul, ylab = "Daily Load of CE in 2005 July")
plot(subset2006Jul, ylab = "Daily Load of CE in 2006 July")
plot(subset2011Jan, ylab = "Daily Load of CE in 2011 January")
plot(subset2011Jul, ylab = "Daily Load of CE in 2011 July")
plot(subset2012Jan, ylab = "Daily Load of CE in 2012 January")
plot(subset2012Jul, ylab = "Daily Load of CE in 2012 July")
plot(subset2017Jan, ylab = "Daily Load of CE in 2017 January")
plot(subset2017Jul, ylab = "Daily Load of CE in 2017 July")
plot(subset2018Jan, ylab = "Daily Load of CE in 2018 January")
plot(subset2018Jul, ylab = "Daily Load of CE in 2018 July")
plot(subset2006JanWeeks, ylab = "Daily Load of CE during the first to third week of 2006 January", type = "p")

#Decompose the trend and seasonal of the dataset we have(after remove the Feb 29th)
CE.ts1 <- ts(CE.ts, frequency = 365)
DECO <- decompose(CE.ts1)
plot(DECO)

#Plot the explanatory variables
plot(Weather.evts, main = "")

dev.off(dev.cur())
