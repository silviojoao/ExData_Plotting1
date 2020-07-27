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
                   colClasses = c('factor', 'factor','numeric','numeric','numeric','numeric','numeric','numeric','numeric'), na.strings = '?') %>% filter(dmy(Date) == '2007-02-01' | dmy(Date) == '2007-02-02')

data$Date <- dmy(data$Date)

##
## First Plot
##
hist(data$Global_active_power,
     main = 'Global Active Power', xlab = 'Global Active Power(kilowatts)', col = 'orangered1')
dev.copy(png, file='plot1.png')
dev.off()
