# @Author: DJ Rajdev
# @Purpose: Exploratory Data Analysis, Lecture 1, Project 1

# rm(list=ls())
# setwd(paste('','Users','divyajyotirajdev','Desktop','code', 'exploratory_data_analysis', 'ExData_plotting1',sep='/'))

## Before Starting: if data directory not present in WD download data
if(!file.exists(file.path(getwd(),'household_power_consumption.txt'))){
  download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                destfile=file.path(getwd(),'hw1.zip'))
  unzip(zipfile = file.path(getwd(),'hw1.zip'), exdir = getwd())
}

## Read data, assuming system has enough memory
electricdat <- read.table(file= file.path(getwd(),'household_power_consumption.txt'),
                          header=T, sep=';', na.strings = '?', 
                          stringsAsFactors = F, 
                          colClasses = c(rep('character',2), rep('numeric',7)))
electricdat$Time <- strptime(paste(electricdat$Date,electricdat$Time), 
                             format = '%d/%m/%Y %H:%M:%S')
electricdat$Date <- as.Date(electricdat$Date, format = '%d/%m/%Y')
# Subset to required 2 days
start <- as.Date('2007-02-01', format='%Y-%m-%d')
end <- as.Date('2007-02-02', format='%Y-%m-%d')
electricdat <- electricdat[electricdat$Date == start | electricdat$Date == end,]


## Plotting begins
png('figure4.png', width = 480, height=480)
par(mfrow=c(2,2))
plot(electricdat$Time, electricdat$Global_active_power,
     type='l', ylab = 'Global Active Power', xlab='')
plot(electricdat$Time, electricdat$Voltage,
     type='l', ylab = 'Voltage', xlab='datetime')
plot(electricdat$Time, electricdat$Sub_metering_1,
     type='l', ylab = 'Energy sub metering', xlab='')
points(electricdat$Time, electricdat$Sub_metering_2,
       type='l', col='red')
points(electricdat$Time, electricdat$Sub_metering_3,
       type='l', col='blue')
legend('topright', col=c('black', 'red', 'blue'), lty=1,
       legend=names(electricdat)[7:9])
plot(electricdat$Time, electricdat$Global_reactive_power,
     type='l', xlab='datetime')
dev.off()





