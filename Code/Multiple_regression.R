#
#Team 5 project
#
# Program: ReadData.R
#
# Purpose: To read the data in CSV
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
setwd("C:/Users/Admin/Desktop/Forecasting Methods/Project/Data")

source("ReadData.R")
source("DataClean.R")
source("SplitData.R")
source("Holidays.R")

# Is there a temperature effect on the demand?
# We show daily demand versus daily mean temperature.
# We use different plotting symbols for different years.
tmp <- window(Weather.training.temp,start = "2011-01-01",end="2013-12-31")
dmd <- window(CE.training.timeSeries,start = "2011-01-01",end="2013-12-31")
hum <- window(Weather.training.hum,start = "2011-01-01",end="2013-12-31")
pre <- window(Weather.training.pre,start = "2011-01-01",end="2013-12-31")
win <- window(Weather.training.wd,start = "2011-01-01",end="2013-12-31")

tmpdataframe <- subset(CE.training,CE.training$Date >= "2011-01-01")

plot(series(tmp),series(dmd),
     ylab="daily demand in Comed (MW/h)",col=(as.numeric(substr(tmpdataframe[[1]],1,4))+1),
     xlab="Temperature (deg F)",pch=23,cex=1.5)
legend(50,450000,col=2012:2014,legend=2014:2016,pch=23,cex=1.2)

# Is there a CDD or HDD effect?
cddp <- window(Weather.training.cdd,start = "2011-01-01",end="2013-12-31")
hddp <- window(Weather.training.hdd,start = "2011-01-01",end="2013-12-31")

par(mfrow=c(1,1))
plot(series(cddp),series(dmd),col=(as.numeric(substr(tmpdataframe[[1]],1,4))+1),
     ylab="daily demand in Comed (MW/h)",xlab="CDD",pch=23,xlim=c(0,60))
plot(series(hddp),series(dmd),col=(as.numeric(substr(tmpdataframe[[1]],1,4))+1),
     ylab="daily demand in Comed (MW/h)",xlab="HDD",pch=23)
par(mfrow=c(2,2))

# Is there a  HDD and CDD effect?
plot(hddp,dmd,xlab="HDDt",ylab="daily demand in Comed (MW/h)")
plot(cddp,dmd,xlab="CDDt",ylab="daily demand in Comed (MW/h)")

# Is there a lagged HDD effect?
plot(lag(hddp,1),dmd,xlab="lag-1 HDDt",ylab="daily demand in Comed (MW/h)")
plot(lag(cddp,2),dmd,xlab="lag-2 HDDt",ylab="daily demand in Comed (MW/h)")

# Is there a lagged CDD effect?
plot(lag(cddp,1),dmd,xlab="lag-1 CDDt",ylab="daily demand in Comed (MW/h)")
plot(lag(cddp,2),dmd,xlab="lag-2 CDDt",ylab="daily demand in Comed (MW/h)")
par(mfrow=c(1,1))

# Is there a precipitation effect?
par(mfrow=c(1,1))
plot(pre,dmd,xlab="precipitation",ylab="daily demand in Comed (MW/h)")

# Is there a windspped effect?
par(mfrow=c(1,1))
plot(win,dmd,xlab="Windspeed",ylab="daily demand in Comed (MW/h)")

# Is there a humidity effect?
par(mfrow=c(1,1))
plot(hum,dmd,xlab="humidity",ylab="daily demand in Comed (MW/h)")

# Again, concatenating so that the date for the three years 
# are in one vector (for each variable).
ch.wea.date <- subset(Weather,Weather$Date >= "2011-01-01" & Weather$Date <= "2013-12-31")

# Day of the week effect?
# Need to create a variable that contains the corresponding 
# 'day of the week' for each date and plot the demand against
# the day to 'see' if there is possibly an effect.
dayofweek2 <- substr(weekdays(strptime(ch.wea.date[[1]],"%Y-%m-%d")),1,3)
dayofweek3 <- substr(weekdays(strptime(Weather.training$Date,"%Y-%m-%d")),1,3)
dayofweekf <- substr(weekdays(strptime(Weather.validation$Date,"%Y-%m-%d")),1,3)

MovingHolidays1 <- subset(MovingHolidays.Training, MovingHolidays.Training$Date >= "2011-01-01" & MovingHolidays.Training$Date <= "2013-12-31")[[2]]
MovingHolidays1[is.na(MovingHolidays1)] <- 0
FixedHolidays1 <- subset(FixedHolidays.Training, FixedHolidays.Training$Date >= "2011-01-01" & FixedHolidays.Training$Date <= "2013-12-31")[[2]]
FixedHolidays1[is.na(FixedHolidays1)] <- 0

MovingHolidaysc <- subset(MovingHolidays.Training, MovingHolidays.Training$Date >= "2005-01-01" & MovingHolidays.Training$Date <= "2013-12-31")[[2]]
MovingHolidaysc[is.na(MovingHolidaysc)] <- 0
FixedHolidaysc <- subset(FixedHolidays.Training, FixedHolidays.Training$Date >= "2005-01-01" & FixedHolidays.Training$Date <= "2013-12-31")[[2]]
FixedHolidaysc[is.na(FixedHolidaysc)] <- 0

MovingHolidaysf <- subset(MovingHolidays.Validation, MovingHolidays.Validation$Date > "2013-12-28" & MovingHolidays.Validation$Date <= "2016-12-31")[[2]]
MovingHolidaysf[is.na(MovingHolidaysf)] <- 0
FixedHolidaysf <- subset(FixedHolidays.Validation, FixedHolidays.Validation$Date > "2013-12-28" & FixedHolidays.Validation$Date <= "2016-12-31")[[2]]
FixedHolidaysf[is.na(FixedHolidaysf)] <- 0

FixedHolidays1lag <- subset(FixedHolidays.lag.data.frame, FixedHolidays.lag.data.frame$Date >= "2011-01-01" & FixedHolidays.lag.data.frame$Date <= "2013-12-31")[[2]]
FixedHolidays1lag[is.na(FixedHolidays1lag)] <- 0

FixedHolidays2lag <- subset(FixedHolidays.lag.data.frame, FixedHolidays.lag.data.frame$Date >= "2005-01-01" & FixedHolidays.lag.data.frame$Date <= "2013-12-31")[[2]]
FixedHolidays2lag[is.na(FixedHolidays2lag)] <- 0

FixedHolidaysflag <- subset(FixedHolidays.lag.data.frame, FixedHolidays.lag.data.frame$Date >= "2013-12-28" & FixedHolidays.lag.data.frame$Date <= "2016-12-31")[[2]]
FixedHolidaysflag[is.na(FixedHolidaysflag)] <- 0

dow2 <- ifelse(dayofweek2=="Sun",1,ifelse(dayofweek2=="Mon",2,
                                          ifelse(dayofweek2=="Tue",3,ifelse(dayofweek2=="Wed",4,
                                                                            ifelse(dayofweek2=="Thu",5,ifelse(dayofweek2=="Fri",6,7))))))
# Creating the dummy variables.  auto.arima does not 
# take factor(dayofweek) as a regressor.
# We choose Friday as base.
DMon2 <- ifelse(factor(dayofweek2)=="Mon",1,0)
DTue2 <- ifelse(factor(dayofweek2)=="Tue",1,0)
DWed2 <- ifelse(factor(dayofweek2)=="Wed",1,0)
DThu2 <- ifelse(factor(dayofweek2)=="Thu",1,0)
DSat2 <- ifelse(factor(dayofweek2)=="Sat",1,0)
DSun2 <- ifelse(factor(dayofweek2)=="Sun",1,0)

MovingH2 <- ifelse(factor(MovingHolidays1)=="1",1,0)
FixedH2 <- ifelse(factor(FixedHolidays1)=="1",1,0)
FixedH4 <- ifelse(factor(FixedHolidays1lag)=="1",1,0)

# Creating the dummy variables.  auto.arima does not 
# take factor(dayofweek) as a regressor.
# We choose Friday as base.
DMon3 <- ifelse(factor(dayofweek3)=="Mon",1,0)
DTue3 <- ifelse(factor(dayofweek3)=="Tue",1,0)
DWed3 <- ifelse(factor(dayofweek3)=="Wed",1,0)
DThu3 <- ifelse(factor(dayofweek3)=="Thu",1,0)
DSat3 <- ifelse(factor(dayofweek3)=="Sat",1,0)
DSun3 <- ifelse(factor(dayofweek3)=="Sun",1,0)

MovingH3 <- ifelse(factor(MovingHolidaysc)=="1",1,0)
FixedH3 <- ifelse(factor(FixedHolidaysc)=="1",1,0)
FixedH6 <- ifelse(factor(FixedHolidays2lag)=="1",1,0)

#Days for the validation period
DMonf <- ifelse(factor(dayofweekf)=="Mon",1,0)
DTuef <- ifelse(factor(dayofweekf)=="Tue",1,0)
DWedf <- ifelse(factor(dayofweekf)=="Wed",1,0)
DThuf <- ifelse(factor(dayofweekf)=="Thu",1,0)
DSatf <- ifelse(factor(dayofweekf)=="Sat",1,0)
DSunf <- ifelse(factor(dayofweekf)=="Sun",1,0)

MovingHf <- ifelse(factor(MovingHolidaysf)=="1",1,0)
FixedHf <- ifelse(factor(FixedHolidaysf)=="1",1,0)
FixedH2f <- ifelse(factor(FixedHolidaysflag)=="1",1,0)

# Linear regression (3 years) including day of the week and holidays
par(mfrow=c(1,1))
chreg2a <- lm(dmd ~ tmp + factor(dayofweek2) + factor(MovingHolidays1) + factor(FixedHolidays1),
              x=T, y=T, subset=(tmp>=65))
plot(chreg2a$x[,2],chreg2a$y,
     ylab="daily demand in Comed (MW/h)",xlab="Temperature (deg Fahrenheit)",
     main="2011-2013: when Temp>=65F only, adding factor(dayofweek)")
points(chreg2a$x[,2],chreg2a$fitted.values,
       col=as.numeric(factor(dayofweek2)[tmp>=65]),pch=15)
legend("bottomright",legend=levels(factor(dayofweek2)),
       col=as.numeric(factor(levels(factor(dayofweek2)))),pch=rep(15,6),
       title="Fitted",cex=0.8)
print(summary(chreg2a))

# Linear regression (3 years) including CDDt and some of its lags
chreg2b <- lm(dmd ~tmp +  factor(dayofweek2) + factor(MovingHolidays1) + factor(FixedHolidays1) +
                lag(cddp,1) + lag(cddp,2),
              x=T, y=T, subset=(tmp>=65))
plot(chreg2b$x[,2],chreg2b$y,
     ylab="daily demand in Comed (MW/h)",
     xlab="Temperature (deg Fahrenheit)",
     main="2011-2013: when Temp>=65C only, 
     adding 2 lags CDDt + factor(dayofweek)")
points(chreg2b$x[,2],chreg2b$fitted.values, 
       col=as.numeric(factor(dayofweek2)[tmp>=65]),pch=15)
legend("bottomright",legend=levels(factor(dayofweek2)),
       col=as.numeric(factor(levels(factor(dayofweek2)))),pch=rep(15,6),
       title="Fitted")
print(summary(chreg2b))

--------------------------------------------------------------------------------------------
  
# Linear regression (3 years) including day of the week, HDD, CDD an their lags
chreg3 <- lm(dmd ~ factor(dayofweek2) + factor(MovingHolidays1) + factor(FixedHolidays1) + factor(FixedH4) +
                 hum +
                 cddp + lag(cddp,1) + lag(cddp,2) +
                 hddp + lag(hddp,1) + lag(hddp,2),
               x=T, y=T)
plot(chreg3$x[,11],chreg3$y,
     ylab="daily demand in Comed (MW/h)",xlab="HDDt",
     main=paste("2011-2013: all data
                ",
                as.character(chreg3$call)[2]),cex.main=0.75)
points(chreg3$x[,11],chreg3$fitted.values,col="red")
legend("bottomright",legend=c("observed","fitted"),col=c("black","red"),
       pch=1)
#2nd graph
plot(chreg3$x[,2],chreg3$y,
     ylab="daily demand in Comed (MW/h)",xlab="CDDt",
     main=paste("2011-2013: all data
                ",
                as.character(chreg3$call)[2]),cex.main=0.75)
points(chreg3$x[,2],chreg3$fitted.values,col="red")
legend("bottomright",legend=c("observed","fitted"),col=c("black","red"),
       pch=1)

par(mfrow=c(2,2))
plot(chreg3)
print(summary(chreg3))

# Durbin-Watson test for autocorrelated residuals
library(lmtest)
print(dwtest(chreg3))
# Can also calculate DW statistic for different lags
# There is convincing evidence at the first five lags
# that the autocorrelation is not zero.
library(car)
print(durbinWatsonTest(chreg3,max.lag=5))

#Same but using autoarima

newfit <- auto.arima(dmd, xreg=cbind(hddp,cddp,DMon2, DTue2, DWed2, DThu2, DSat2, DSun2, hum, FixedH4,
                                     MovingH2, FixedH2,
                                     lag(hddp,1),lag(hddp,2),
                                     lag(cddp,1),lag(cddp,2)))
print(newfit)          # Selects ARIMA(5,0,0) with non-zero mean
acf(residuals(newfit)[-(1:5)],
    main="Auto-arima error structure")

# Same but using Sarima to generate diagnostic plot
library(astsa)
adjreg <- sarima(dmd, 2,1,1, xreg=cbind(hddp,cddp,DMon2, DTue2, DWed2, DThu2, DSat2, DSun2, hum, FixedH4,
                                        MovingH2, FixedH2,
                                        lag(hddp,1),lag(hddp,2),
                                        lag(cddp,1),lag(cddp,2)))

detach("package:astsa")

--------------------------------------------------------------------------------------------

# Linear regression (all years) including day of the week, HDD, CDD an their lags
chreg4 <- lm(CE.training.timeSeries ~ factor(dayofweek3) + factor(MovingHolidaysc) + factor(FixedHolidaysc) + factor(FixedH6) +
                 Weather.training.hum +
                 Weather.training.cdd + lag(Weather.training.cdd,1) + lag(Weather.training.cdd,2) +
                 Weather.training.hdd + lag(Weather.training.hdd,1) + lag(Weather.training.hdd,2),
               x=T, y=T)
plot(chreg4$x[,11],chreg4$y,
     ylab="daily demand in Comed (MW/h)",xlab="HDDt",
     main=paste("2005-2013: all data
                ",
                as.character(chreg4$call)[2]),cex.main=0.75)
points(chreg4$x[,11],chreg4$fitted.values,col="red")
legend("bottomright",legend=c("observed","fitted"),col=c("black","red"),
       pch=1)
#2nd graph
plot(chreg4$x[,8],chreg4$y,
     ylab="daily demand in Comed (MW/h)",xlab="CDDt",
     main=paste("2005-2013: all data
                ",
                as.character(chreg4$call)[2]),cex.main=0.75)
points(chreg4$x[,8],chreg4$fitted.values,col="red")
legend("bottomright",legend=c("observed","fitted"),col=c("black","red"),
       pch=1)

print(summary(chreg4))

par(mfrow=c(2,2))
plot(chreg4)
print(summary(chreg4))

# Durbin-Watson test for autocorrelated residuals
library(lmtest)
print(dwtest(chreg4))

# Can also calculate DW statistic for different lags
# There is convincing evidence at the first five lags
# that the autocorrelation is not zero.
library(car)
print(durbinWatsonTest(chreg4,max.lag=5))

#Same but using autoarima
newfit2 <- auto.arima(CE.training.timeSeries, xreg=cbind(Weather.training.cdd,Weather.training.hdd,
                                                         DMon3, DTue3, DWed3, DThu3, DSat3, DSun3, FixedH6,
                                                         Weather.training.hum,
                                                         MovingH3, FixedH3,
                                                         lag(Weather.training.hdd,1),lag(Weather.training.hdd,2),
                                                         lag(Weather.training.cdd,1),lag(Weather.training.cdd,2)))
print(newfit2)          # Selects ARIMA(5,1,0) with non-zero mean
acf(residuals(newfit2)[-(1:5)],
    main="Auto-arima error structure")

# Same but using Sarima to generate diagnostic plot
library(astsa)
adjreg <- sarima(CE.training.timeSeries, 5,1,0, xreg=cbind(Weather.training.cdd,Weather.training.hdd,
                                                           DMon3, DTue3, DWed3, DThu3, DSat3, DSun3, FixedH6,
                                                           Weather.training.hum,
                                                           MovingH3, FixedH3,
                                                           lag(Weather.training.hdd,1),lag(Weather.training.hdd,2),
                                                           lag(Weather.training.cdd,1),lag(Weather.training.cdd,2)))

n <- (4:1095)
newxreg1 <- cbind(Weather.validation.cdd[n-1],Weather.validation.hdd[n-1],DMonf[n],DTuef[n],DWedf[n],DThuf[n],DSatf[n],DSunf[n]
            ,FixedH2f[n],Weather.validation.hum[n-1],MovingHf[n],FixedHf[n],Weather.validation.hdd[n-2],Weather.validation.hdd[n-3]
            ,Weather.validation.cdd[n-2],Weather.validation.cdd[n-3])

ForecastReg<- predict(newfit2,n.ahead = 365*3,newxreg = newxreg1)

#Performance measures linear regression

bias_reg <- mean(as.numeric(ForecastReg[[1]]-CE.validation[[2]]))
pbias_reg <- mean((as.numeric(ForecastReg[[1]])-as.numeric(CE.validation[[2]]))/as.numeric(CE.validation[[2]])*100)
mape_reg <- mean(abs(((as.numeric(ForecastReg[[1]])-as.numeric(CE.validation[[2]]))/as.numeric(CE.validation[[2]])*100)))
