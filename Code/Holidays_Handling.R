#
#Team 5 project
#
# Program: HolidaysAndDayOfWeek.R
#
# Purpose: Introduce the Holidays and Day of Week into our data
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
#

source("ReadData.R")
source("DataClean.R")

#Give dayofweek variable.
CE.daily3 <- CE.daily2.data.frame
names(CE.daily3) <- c("Time","Load")
CE.daily3$Time <- as.timeDate(CE.daily3$Time)
CE.daily3 <- as.data.frame(CE.daily3)
CE.daily3[[1]] <- as.POSIXct(CE.daily3[[1]])

#Assign Holidays variable
years <- (2005:2018)
MovingHolidays <- c(USMemorialDay(years),
                    USPresidentsDay(years),
                    USMLKingsBirthday(years),
                    USLaborDay(years),
                    USThanksgivingDay(years),
                    USColumbusDay(years))
FixedHolidays <- c(USChristmasDay(years),
                   USNewYearsDay(years),
                   USLincolnsBirthday(years),
                   USVeteransDay(years),
                   ChristmasEve(years),
                   USIndependenceDay(years))

MovingHolidays.data.frame <- data.frame(MovingHolidays)
MovingHolidays.data.frame[[1]] <- as.character(MovingHolidays.data.frame[[1]])
names(MovingHolidays.data.frame) <- "Date"
MovingHolidays.data.frame$Is.MovingHolidays <- 1
MovingHolidays.data.frame[[1]] <- sort(MovingHolidays.data.frame[[1]])

FixedHolidays.data.frame <- data.frame(FixedHolidays)
FixedHolidays.data.frame[[1]] <- as.character(FixedHolidays.data.frame[[1]])
names(FixedHolidays.data.frame) <- "Date"
FixedHolidays.data.frame$Is.FixedHolidays <- 1
FixedHolidays.data.frame[[1]] <- sort(FixedHolidays.data.frame[[1]])

FixedHolidays.lag.data.frame <- data.frame(FixedHolidays)
FixedHolidays.lag.data.frame[[1]] <- as.Date(FixedHolidays.lag.data.frame[[1]])
FixedHolidays.lag.data.frame[[1]] <- FixedHolidays.lag.data.frame[[1]]-1
names(FixedHolidays.lag.data.frame) <-"Date"
FixedHolidays.lag.data.frame$Is.FixedHolidays <- 1
FixedHolidays.lag.data.frame[[1]] <- as.character(FixedHolidays.lag.data.frame[[1]])
FixedHolidays.lag.data.frame[[1]] <- sort(FixedHolidays.lag.data.frame[[1]])
FixedHolidays.lag.data.frame <- FixedHolidays.lag.data.frame[-1,]

Time.data.frame <- data.frame(CE.daily3[[1]])
Time.data.frame[[1]] <- as.character(Time.data.frame[[1]])
names(Time.data.frame) <- "Date"
MovingHolidays.data.frame <- merge(Time.data.frame,MovingHolidays.data.frame, id = "Date", all=T)
FixedHolidays.data.frame <- merge(Time.data.frame,FixedHolidays.data.frame, id = "Date", all=T)
FixedHolidays.lag.data.frame <- merge(Time.data.frame,FixedHolidays.lag.data.frame, id = "Date", all=T)

MovingHolidays.Training <- subset(MovingHolidays.data.frame, MovingHolidays.data.frame$Date <= "2013-12-31")
MovingHolidays.Validation <- subset(MovingHolidays.data.frame, MovingHolidays.data.frame$Date > "2013-12-31" & MovingHolidays.data.frame$Date <= "2016-12-31")
MovingHolidays.Test <- subset(MovingHolidays.data.frame, MovingHolidays.data.frame$Date > "2016-12-31")

FixedHolidays.Training <- subset(FixedHolidays.data.frame, FixedHolidays.data.frame$Date <= "2013-12-31")
FixedHolidays.Validation <- subset(FixedHolidays.data.frame, FixedHolidays.data.frame$Date > "2013-12-31" & FixedHolidays.data.frame$Date <= "2016-12-31")
FixedHolidays.Test <- subset(FixedHolidays.data.frame, FixedHolidays.data.frame$Date > "2016-12-31")

