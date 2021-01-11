#
#Team 5 project
#
# Program: Naive.R
#
# Purpose: Conduct the naive method on training and validation datasets
#
# Written by: Miao Hu, 21 February 2019
# 
# ------------------------------------------------------
#

source("ReadData.R")
source("DataClean.R")
source("SplitData.R")



#Naive method based on 1 day - Trainning
naive_1_Training <- CE.training[[2]][-length(CE.training[[2]])]
observed_1_Training <- CE.training[[2]][-1]
bias_1_Training <- mean(naive_1_Training-observed_1_Training)
pbias_1_Training <- mean((naive_1_Training-observed_1_Training)/observed_1_Training)*100
mape_1_Training <- mean(abs((naive_1_Training-observed_1_Training)/observed_1_Training))*100
rmse_1_Training <- sqrt(mean((naive_1_Training-observed_1_Training)^2))

#Naive method based on 365 days (a year) to get the Same day Last year - Trainning
naive_2_Training <- CE.training[[2]][-((length(CE.training[[2]])-364):length(CE.training[[2]]))]
observed_2_Training <- CE.training[[2]][-(1:365)]
bias_2_Training <- mean(naive_2_Training-observed_2_Training)
pbias_2_Training <- mean((naive_2_Training-observed_2_Training)/observed_2_Training)*100
mape_2_Training <- mean(abs((naive_2_Training-observed_2_Training)/observed_2_Training))*100
rmse_2_Training <- sqrt(mean((naive_2_Training-observed_2_Training)^2))

#Moving average 3 days - 1 - Trainning
naive_3_Training <- rollMean(CE.training.ts,3,align="right",na.pad=T)[-(1:2)]
naive_3_Training <- naive_3_Training[-length(naive_3_Training)]
observed_3_Training <- CE.training[[2]][-(1:3)]
bias_3_Training <- mean(naive_3_Training-observed_3_Training)
pbias_3_Training <- mean((naive_3_Training-observed_3_Training)/observed_3_Training)*100
mape_3_Training <- mean(abs((naive_3_Training-observed_3_Training)/observed_3_Training))*100
rmse_3_Training <- sqrt(mean((naive_3_Training-observed_3_Training)^2))

#Moving average 7 days - 2 - Trainning
naive_4_Training <- rollMean(CE.training.ts,7,align="right",na.pad=T)[-(1:6)]
naive_4_Training <- naive_4_Training[-length(naive_4_Training)]
observed_4_Training <- CE.training[[2]][-(1:7)]
bias_4_Training <- mean(naive_4_Training-observed_4_Training)
pbias_4_Training <- mean((naive_4_Training-observed_4_Training)/observed_4_Training)*100
mape_4_Training <- mean(abs((naive_4_Training-observed_4_Training)/observed_4_Training))*100
rmse_4_Training <- sqrt(mean((naive_4_Training-observed_4_Training)^2))

#Naive method based on 1 day - validation
naive_1_Validation <- CE.validation[[2]][-length(CE.validation[[2]])]
observed_1_Validation <- CE.validation[[2]][-1]
bias_1_Validation <- mean(naive_1_Validation-observed_1_Validation)
pbias_1_Validation <- mean((naive_1_Validation-observed_1_Validation)/observed_1_Validation)*100
mape_1_Validation <- mean(abs((naive_1_Validation-observed_1_Validation)/observed_1_Validation))*100
rmse_1_Validation <- sqrt(mean((naive_1_Validation-observed_1_Validation)^2))

#Naive method based on 365 days (a year) to get the Same day Last year - validation
naive_2_Validation <- CE.validation[[2]][-((length(CE.validation[[2]])-364):length(CE.validation[[2]]))]
observed_2_Validation <- CE.validation[[2]][-(1:365)]
bias_2_Validation <- mean(naive_2_Validation-observed_2_Validation)
pbias_2_Validation <- mean((naive_2_Validation-observed_2_Validation)/observed_2_Validation)*100
mape_2_Validation <- mean(abs((naive_2_Validation-observed_2_Validation)/observed_2_Validation))*100
rmse_2_Validation <- sqrt(mean((naive_2_Validation-observed_2_Validation)^2))

#Moving average 3 days - 1 - validation
naive_3_Validation <- rollMean(CE.validation.ts,3,align="right",na.pad=T)[-(1:2)]
naive_3_Validation <- naive_3_Validation[-length(naive_3_Validation)]
observed_3_Validation <- CE.validation[[2]][-(1:3)]
bias_3_Validation <- mean(naive_3_Validation-observed_3_Validation)
pbias_3_Validation <- mean((naive_3_Validation-observed_3_Validation)/observed_3_Validation)*100
mape_3_Validation <- mean(abs((naive_3_Validation-observed_3_Validation)/observed_3_Validation))*100
rmse_3_Validation <- sqrt(mean((naive_3_Validation-observed_3_Validation)^2))

#Moving average 7 days - 2 - validation
naive_4_Validation <- rollMean(CE.validation.ts,7,align="right",na.pad=T)[-(1:6)]
naive_4_Validation <- naive_4_Validation[-length(naive_4_Validation)]
observed_4_Validation <- CE.validation[[2]][-(1:7)]
bias_4_Validation <- mean(naive_4_Validation-observed_4_Validation)
pbias_4_Validation <- mean((naive_4_Validation-observed_4_Validation)/observed_4_Validation)*100
mape_4_Validation <- mean(abs((naive_4_Validation-observed_4_Validation)/observed_4_Validation))*100
rmse_4_Validation <- sqrt(mean((naive_4_Validation-observed_4_Validation)^2))
