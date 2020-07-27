########################################################################################
##  This script does:
##
##    - Downloads and reads the data
##    - Constructs the plot1 and save it to a PNG file with a width of 480 pixels 
##      and a height of 480 pixels.
##
########################################################################################

fileName <- 'exdata_data_household_power_consumption.zip'

if (!file.exists(fileName)){
      download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                    fileName)
}

unzip(fileName)

##
## Assigning the data
##
library(lubridate)
library(dplyr)
data <- read.table('household_power_consumption.txt', sep=';', header = T,
                   colClasses = c('factor', 'character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'), na.strings = '?') %>% filter(dmy(Date) == '2007-02-01' | dmy(Date) == '2007-02-02')

data$DateTime <- paste(data$Date,data$Time)
data$DateTime <- dmy_hms(data$DateTime)
##
## 3rd Plot
##
Sys.setlocale("LC_TIME", "C") # Change weekdays to english
plot(data$DateTime, data$Sub_metering_1, type = 'l', ylab = 'Energy sub metering',
     xlab='', col='grey23')
points(data$DateTime, data$Sub_metering_2, type='l', col='orangered')
points(data$DateTime, data$Sub_metering_3, type='l', col='blue')
legend('topright', paste0('Sub_metering',1:3), pch=20, col=c('grey23','orangered','blue'), cex = 0.65, pt.cex = 1.5)

dev.copy(png, file='plot3.png')
dev.off()
