#
# Team 5 project
#
# Program: ReadData.R
#
# Purpose: To read the data in CSV
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
#

# Set locale to English
Sys.setlocale("LC_TIME", "C")

install.packages(

#Setwd
#setwd("/Users/miaohu/Project/")

#Read the CE data in the csv
CE <- read.csv('hrl_load_metered.csv', sep=',', header=TRUE,col.names=c("Time1","Time","NERC","Market","Zone","Load_Zone","Load","IS_VERIFIED"))

#Only read the 2nd and 7th column
CE <- CE[,c(2,7)]

#Read the weather data
Weather <- read.csv('Consolidated data.csv', sep=',',header=TRUE)

#Load package
library("timeSeries")
library("forecast")
library("astsa")

#Remove the DayLight Saving Days in CE
index <- duplicated(CE$Time)
CE <- CE[!index,]

#Covert the TimeZone from EPT to CT(Central Time Zone)
CE$Time <- as.POSIXct(CE$Time, format = "%m/%d/%Y %I:%M:%S %p")
CE$Time <- CE$Time-3600
CE$Time <- as.character(CE$Time)
CE <- CE[2:(nrow(CE)-23),]
CE.df <- data.frame(CE)

#Note:Create a timeSeries object to get a full-date data, using UTC 
#     in order to remove the effect of Daylight Saving
fullTime <- data.frame(Time = 
                         seq(as.POSIXct("1/1/2005 12:00:00 AM", 
                                             tz = "UTC",
                                        format = "%m/%d/%Y %I:%M:%S %p"),
                                  as.POSIXct("1/31/2019 11:00:00 PM",
                                             tz = "UTC",
                                             format = "%m/%d/%Y %I:%M:%S %p"),
                                  by = "hour"))
fullTime$Time <- as.character(fullTime$Time)
fullTime <- merge(fullTime,CE.df, by.x='Time',all=TRUE)
Day <- fullTime$Time #get the day for later use

#Assign data type
timeCE <- as.character(unlist(fullTime[1]))
Load <- as.numeric(unlist(fullTime[2]))

#Setting timeSeries for CE and clean outlier
CETS <- timeSeries(Load,timeCE)
CETS <- interpNA(CETS, method = 'linear', rule = 2) #Using linear method to fill in the vacant data in the "Load" column
Load_1 <-  CETS[1:(length(CETS))]

#Aggregate daily load
CETS.list <- list(Day = Day,Load=Load_1) #Day is called from fullTime after merge
Load.daily <- CETS.list$Load
Time.daily <- CETS.list$Day
CETS.df <- data.frame(Time=as.Date(Time.daily,"%Y-%m-%d"),
                      Load=Load.daily) #Convert the list into a data frame in order to merge
CE.daily <- aggregate(Load ~ Time, CETS.df, 
                      function(x) c(dailydemand = sum(x)))

#Prepare data for the Na??ve Method
CE.ts <- timeSeries(CE.daily$Load,CE.daily$Time)
CE.daily1 <- as.list(CE.ts)
CE.daily1 <- data.frame(Time = CE.daily$Time,Load = CE.daily1)
CE.daily2 <- list()

#Remove 29 Feb
CE.daily2[[1]] <- CE.daily1[[1]][substr(as.character(CE.daily1[[1]]),6,10)!="02-29"]
CE.daily2[[2]] <- CE.daily1[[2]][substr(as.character(CE.daily1[[1]]),6,10)!="02-29"]
CE.daily2.data.frame <- data.frame(CE.daily2[[1]],CE.daily2[[2]])
CE.ts <- timeSeries(CE.daily2[[2]],CE.daily2[[1]])
Outliers <- tsoutliers(CE.ts)

#Weather Data Cleaning
Weather$Date <- as.POSIXct(Weather$Date, format='%B %d, %Y')
Weather$Date <- as.character(Weather$Date)
Weather1 <- list()
Weather1[[1]] <- Weather[[1]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[2]] <- Weather[[2]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[3]] <- Weather[[3]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[4]] <- Weather[[4]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[5]] <- Weather[[5]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[6]] <- Weather[[6]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[7]] <- Weather[[7]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather1[[8]] <- Weather[[8]][substr(as.character(Weather[[1]]),6,10)!="02-29"]
Weather <- as.data.frame(Weather1)
colnames(Weather) <- c("Date","Average temperature F","HDD","CDD","Precipitation (Inches)","Average daily MLP price","Humidity","Wind Speed (mph)")
Weather[[1]] <- as.character(Weather[[1]])
Weather[[2]] <- as.numeric(Weather[[2]])
Weather[[3]] <- as.numeric(Weather[[3]])
Weather[[4]] <- as.numeric(Weather[[4]])
Weather[[5]] <- as.numeric(Weather[[5]])
Weather[[6]] <- as.numeric(Weather[[6]])
Weather[[7]] <- as.numeric(Weather[[7]])
Weather[[8]] <- as.numeric(Weather[[8]])
Weather <- subset(Weather, Weather$Date <= "2019-01-31")
Weather.ts <- timeSeries(Weather[2:8],Weather[[1]])
