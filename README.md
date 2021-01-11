# Time-Series-Forecast-Electricity-Demand
This project is written for Course Forecasting Methods at HEC Montréal by Miao Hu, Junyuan Lin, Blosher Brar, Felipe González.
.
## Introduction
The main idea of this project is to explore different types of time-series techniques to forecast the daily electricity demand in a certain region. For my group it is Commonwealth Edison Co (ComEd) which is part of ennsylvania-New Jersey-Maryland Interconnection (PJM Interconnection)

![alt text](https://naniaenergy.com/wp-content/uploads/2019/12/PJM-Territory.png)

ComEd is located in northern Illinois and includes the city of Chicago with approximately 3.8 million., its central location and its access to rail and aviation hubs and major waterways, Illinois plays an important role in the nation's economy.

Detailed analysis and reports are stored in **'report'** folder, in these three pdf, we described how we clean the data, find and deal with outliers and implementing several time series models, including Naïve, Linear Regression with ARMA errors, TBATS (Trigonometric seasonality, Box-Cox transformation, ARMA errors, Trend and Seasonal components), SARIMA (Seasonal AutoRegressive Integrated Moving Average) and DSHW (Double-Seasonal Holt-Winters)

During the process we noticed that all models does not have the similar performance throughout the year. Therefore we defined the Summer and Non-Summer Period. (From May 1st to August 31st, as shown in the plot below)

![alt text](https://github.com/MiaoHu17/Time-Series-Forecast-Electricity-Demand/blob/main/plot/plot1.png?raw=true)
Performance of some models during summer and non-summer period
 Model                  |    Summer MAPE        | Non-Summer MAPE|
|------------------------|----------------|----------------|
| Linear Regression    |    3.29%      |    3.67%      |
| SARIMA         |    5.70%      |    3.42%      |
| TBATS | 6.16%      |    3.77%      |

As a result, we use the winner on Summer period to predict summer and do the same on non-summer period. We call this method as "Hybrid" (Linear Regression on Summer period and SARIMA on Non-Summer period.)

The performance of each model is given in the table below, thus Hybrid method performs the best on Validation set.

| Model                  |    MAPE        |    Bias        |
|------------------------|----------------|----------------|
| Naïve    |    6.41%      |    0.39      |
| Linear Regression      |    3.54%      |    0.54      |
| TBATS|    4.58%      |    0.23     |
| SARIMA  | 4.20%         |    0.29      |
| DSHW         |  5.08%        |    0.36      |
| Hybrid                |   3.38%       |    0.38      |
