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
png("plot3.png")
with(selected_data, plot(Datetime, Sub_metering_1, type = "n", xlab = "", ylab = ""))
with(selected_data, lines(Datetime, Sub_metering_1))
with(selected_data, lines(Datetime, Sub_metering_2, col = "red"))
with(selected_data, lines(Datetime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
title(ylab = "Energy sub metering")


dev.off()