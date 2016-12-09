
#Raw dataset with weekend date and sales for each plan is given
str(prdt_raw)

library(reshape)
library(forecast)
library(zipcode)

#Obtaining columns containing time series, startting Sep'14 to Aug'16
ts_prdt_ip<- ts(prdt_raw[,-1],freq=365.25/7, start=2014+242/365.25)

ns <- ncol(ts_prdt_ip)
#depending on the number of weeks required to forecast
h <- 15
fcast <- matrix(NA,nrow=h,ncol=ns)

for(i in 1:ns)
{
  fcast[,i] <- forecast(tbats(ts_prdt_ip[,i]),h=15)$mean
}

#exporting the dataset
write(t(fcast),file="tbats_output.csv",sep=",",ncol=ncol(fcast))
