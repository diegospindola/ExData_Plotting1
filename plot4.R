##################### Reading data

#reading header only
header <- read.csv("household_power_consumption.txt",sep=";", nrows=1, header=FALSE)
#reading data only from the dates 2007-02-01 and 
#2007-02-02 (starting from line 66638 up to 69517 = 2880 lines)
data <- read.csv("household_power_consumption.txt",sep=";",header=FALSE, skip=66637,nrows=2880)
#putting labels and data together
colnames( data ) <- unlist(header) #tip taken from this stackoverflow.com answer: http://stackoverflow.com/a/23544256/334681
#converting dates
library(dplyr)
dateTimeStr <- mutate(data, DateTime = paste(as.character(Date),as.character(Time), sep=" "))$DateTime
data$DateTime <- strptime(dateTimeStr, format="%d/%m/%Y %H:%M:%S")
data <- select(data, c(10, 3:9))


##################### Setting environment up
Sys.setlocale("LC_TIME","English")


##################### Making Plots

png("plot4.png",width=480,height=480)
par(mfrow=c(2,2), bg = NA)
#topleft
plot(data$DateTime, data$Global_active_power, type="l", ylab="Global Active Power", xlab="")
#topright
plot(data$DateTime, data$Voltage, type="l", ylab="Voltage", xlab="datetime")
#bottomleft
plot(data$DateTime, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red","blue"), legend=names(data[6:8]), lwd=1, bty="n")
#bottomright
plot(data$DateTime, data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")


##################### Saving File
dev.off()