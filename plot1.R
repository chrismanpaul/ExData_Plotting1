#load packages

library(dplyr)
library(lubridate)

#load data, assumes data file is in the working directory

data_classes = c("character", "character", "numeric", "numeric", "numeric", 
                 "numeric", "numeric", "numeric", "numeric")
power_data <- read.table("household_power_consumption.txt", sep = ";", 
                         colClasses = data_classes, header = TRUE, 
                         na.strings = "?")
#format and select needed portion of data, and remove large, not unneccesary file

power_data$Date <- dmy(power_data$Date)
selected_data <- filter(power_data, year(Date) == 2007, month(Date) == 2, day(Date) == 1 | day(Date) == 2)

rm(power_data)
date_time <- as.POSIXct(paste(selected_data$Date,selected_data$Time)))
selected_data$Datetime <- date_time

#open png device, and write plot to it

png("plot1.png")
with(selected_data, hist(Global_active_power, col = "red", 
                         xlab = "Global Active Power (kilowatts)", 
                         main = "Global Active Power"))
dev.off()